import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../api_key.dart';
import '../../../services/auth_service.dart';

class DealingWithModelController extends GetxController {
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
    getProfile();
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
    final String apiUrl = "$backendUrl/api/auth/profile";
    final token = await AuthService.getToken();
    print(token);

    try {
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
        firstName.value = data['user']['name'];
        email.value = data['user']['email'];
        print(email.value);
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
