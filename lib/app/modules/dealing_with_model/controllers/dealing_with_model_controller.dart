import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/login_response.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/auth_service.dart';

class DealingWithModelController extends GetxController {
  final ApiController controller = Get.put(ApiController());
  var firstName = ''.obs;
  var email = ''.obs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  CameraController? cameraController;
  var isCameraActive = false.obs;
  List<CameraDescription>? cameras;

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
    cameras = await availableCameras();
  }

  @override
  void onClose() {
    _disposeCamera();
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

      cameraController = CameraController(cameras![1], ResolutionPreset.medium);

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

  Future<void> getProfile() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        print("Login via Google terdeteksi");

        firstName.value = firebaseUser.displayName ?? 'Tanpa Nama';
        email.value = firebaseUser.email ?? 'Tanpa Email';

        print("Nama: ${firstName.value}");
        print("Email: ${email.value}");
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

  Widget _buildDrawerFooter() {
    return Container(
      color: Colors.white,
      height: 70,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.grey),
          ),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  firstName.value,
                  style: TextStyle(
                    color: Color(0xff496173),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(email.value, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              await AuthService.clearToken();
              Get.offAllNamed('/login');
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.blue, size: 18),
          ),
        ],
      ),
    );
  }
}
