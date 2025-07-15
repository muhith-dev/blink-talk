import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/models/login_response.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/auth_service.dart';

class DealingWithModelController extends GetxController {
  final ApiController controller = Get.put(ApiController());
  var firstName = ''.obs;
  var email = ''.obs;
  var profileImageUrl = ''.obs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  CameraController? cameraController;
  var isCameraActive = false.obs;
  List<CameraDescription>? cameras;

  WebSocketChannel? _channel;
  var receivedMessage = "Tekan tombol Mulai untuk memulai deteksi...".obs;
  Timer? _reconnectTimer;
  Timer? _frameTimer;
  Timer? _cooldownTimer;
  var isWebSocketConnected = false.obs;
  var isProcessingFrame = false.obs;
  var isDetectionActive = false.obs;
  var isInCooldown = false.obs;
  var cooldownSeconds = 0.obs;

  static const String _webSocketUrl = 'ws://c5ea0150ac23.ngrok-free.app/ws';

  static const Duration _frameInterval = Duration(seconds: 2);
  static const Duration _cooldownDuration = Duration(seconds: 5);
  static const Duration _reconnectDelay = Duration(seconds: 5);

  @override
  void onInit() {
    super.onInit();
    initializeCameras();
    loadApiAndProfile();
  }

  void loadApiAndProfile() async {
    await controller.fetchAPIData();
    await getProfile();
  }

  Future<void> initializeCameras() async {
    var status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      Get.snackbar(
          'Error', 'Izin kamera diperlukan untuk deteksi kedipan mata');
      return;
    }

    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _connectWebSocket();
    }
  }

  @override
  void onClose() {
    _disposeCamera();
    _disposeWebSocket();
    super.onClose();
  }

  void toggleCamera() async {
    if (isCameraActive.value) {
      _disposeCamera();
    } else {
      await _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      if (cameras == null || cameras!.isEmpty) return;

      final frontCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras![0],
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraActive.value = true;
    } catch (e) {
      print("Error kamera: $e");
      Get.snackbar('Error', 'Gagal menginisialisasi kamera');
    }
  }

  void _disposeCamera() {
    cameraController?.dispose();
    cameraController = null;
    isCameraActive.value = false;
    stopDetection();
  }

  void _connectWebSocket() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_webSocketUrl));

      _channel!.stream.listen(
        (message) {
          if (message != "Menunggu deteksi..." &&
              message != "Deteksi dihentikan") {
            _startCooldown();
          }

          receivedMessage.value = message;
          isWebSocketConnected.value = true;
          print('Received from server: $message');
        },
        onError: (error) {
          print('WebSocket error: $error');
          receivedMessage.value = "Koneksi WebSocket Error: $error";
          isWebSocketConnected.value = false;
          _scheduleReconnect();
        },
        onDone: () {
          print('WebSocket connection closed');
          receivedMessage.value = "Koneksi WebSocket terputus.";
          isWebSocketConnected.value = false;
          _scheduleReconnect();
        },
      );

      isWebSocketConnected.value = true;
      if (!isDetectionActive.value) {
        receivedMessage.value =
            "Terhubung ke server. Tekan tombol Mulai untuk memulai deteksi.";
      }

      print('Connected to WebSocket: $_webSocketUrl');
    } catch (e) {
      print('Could not connect to WebSocket: $e');
      receivedMessage.value = "Gagal terhubung ke WebSocket: $e";
      isWebSocketConnected.value = false;
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, () {
      print('Mencoba menyambungkan kembali WebSocket...');
      _connectWebSocket();
    });
  }

  void startDetection() {
    if (!isWebSocketConnected.value) {
      Get.snackbar('Error',
          "Tidak terhubung ke server. Mencoba menghubungkan kembali...");
      _connectWebSocket();
      return;
    }

    if (!isCameraActive.value) {
      Get.snackbar(
          'Error', "Kamera belum aktif. Aktifkan kamera terlebih dahulu.");
      return;
    }

    isDetectionActive.value = true;
    isInCooldown.value = false;
    receivedMessage.value = "Deteksi dimulai. Menunggu gerakan mata...";

    _channel?.sink.add('START_DETECTION');
    _startCameraStream();
  }

  void stopDetection() {
    isDetectionActive.value = false;
    isInCooldown.value = false;
    cooldownSeconds.value = 0;
    receivedMessage.value =
        "Deteksi dihentikan. Tekan tombol Mulai untuk memulai lagi.";

    _channel?.sink.add('STOP_DETECTION');
    _stopCameraStream();
    _cooldownTimer?.cancel();
  }

  void _startCooldown() {
    if (!isDetectionActive.value) return;

    isInCooldown.value = true;
    cooldownSeconds.value = _cooldownDuration.inSeconds;

    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      cooldownSeconds.value--;

      if (cooldownSeconds.value <= 0) {
        timer.cancel();
        if (isDetectionActive.value) {
          isInCooldown.value = false;
          receivedMessage.value = "Deteksi aktif. Menunggu gerakan mata...";
        }
      }
    });
  }

  void _startCameraStream() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      print("Kamera belum diinisialisasi, tidak bisa memulai stream.");
      return;
    }

    _frameTimer?.cancel();
    _frameTimer = Timer.periodic(_frameInterval, (timer) {
      if (isWebSocketConnected.value &&
          isDetectionActive.value &&
          !isInCooldown.value &&
          !isProcessingFrame.value) {
        _captureAndSendFrame();
      }
    });
  }

  void _captureAndSendFrame() async {
    if (cameraController == null ||
        !cameraController!.value.isInitialized ||
        isProcessingFrame.value ||
        !isDetectionActive.value ||
        isInCooldown.value) {
      return;
    }

    isProcessingFrame.value = true;

    try {
      final XFile imageFile = await cameraController!.takePicture();
      final Uint8List imageBytes = await imageFile.readAsBytes();

      final Uint8List? processedBytes = await _processImage(imageBytes);

      if (processedBytes != null &&
          _channel != null &&
          isWebSocketConnected.value) {
        _channel!.sink.add(processedBytes);
      }
    } catch (e) {
      print('Error capturing frame: $e');
    } finally {
      isProcessingFrame.value = false;
    }
  }

  Future<Uint8List?> _processImage(Uint8List imageBytes) async {
    try {
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return null;

      image = img.copyResize(image, width: 320);

      return Uint8List.fromList(img.encodeJpg(image, quality: 70));
    } catch (e) {
      print("Error processing image: $e");
      return null;
    }
  }

  void _stopCameraStream() {
    _frameTimer?.cancel();
    _frameTimer = null;
  }

  void _disposeWebSocket() {
    _stopCameraStream();
    _channel?.sink.close();
    _reconnectTimer?.cancel();
    _cooldownTimer?.cancel();
  }

  Future<void> getProfile() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        print("Login via Google terdeteksi");
        firstName.value = firebaseUser.displayName ?? 'Tanpa Nama';
        email.value = firebaseUser.email ?? 'Tanpa Email';
        profileImageUrl.value =
            firebaseUser.photoURL ?? 'Tanpa Foto'; // Updated
        print("Nama: ${firstName.value}");
        print("Email: ${email.value}");
        print("Photo: ${profileImageUrl.value}"); // Updated
        return;
      }

      final String baseUrl = controller.backendAPI.value;
      final String apiUrl = "$baseUrl/api/users/profile";
      final token = await AuthService.getToken();

      print("Login via token backend");
      print(baseUrl);
      print(apiUrl);

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);

        firstName.value = loginResponse.user.name;
        email.value = loginResponse.user.email;

        print("Nama: ${firstName.value}");
        print("Email: ${email.value}");
        print(loginResponse.expiresIn);
        print(loginResponse.message);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        if (data["msg"] == 'Token has expired') {
          print("Token expired: $data");
          await AuthService.clearToken();
          Get.snackbar(
            'Sesi habis',
            'Silahkan login kembali',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: Get.height / 2.5,
            ),
          );
          Get.offAllNamed('/login');
        }
      } else {
        print('Gagal ambil data user: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan. Coba lagi.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("get user credential error: $e");
    }
  }

  Widget buildDrawer(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        backgroundColor: const Color(0xff3E83FC),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            _drawerItem(context, 'Learn'),
            _drawerItem(context, 'Our Book'),
            _drawerItem(context, 'Language'),
            _drawerItem(context, 'Contact'),
            _drawerItem(context, 'Dark Mode'),
            const SizedBox(height: 270),
            _buildDrawerFooter(),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () => Navigator.pop(context),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildDrawerFooter() {
    return Container(
      color: Colors.white,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileImageUrl.value), // Updated
            radius: 25,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    firstName.value,
                    style: const TextStyle(
                      color: Color(0xff496173),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    email.value,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              await AuthService.clearToken();
              await AuthService.clearEmail();
              Get.offAllNamed('/login');
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.blue, size: 18),
          ),
        ],
      ),
    );
  }
}
