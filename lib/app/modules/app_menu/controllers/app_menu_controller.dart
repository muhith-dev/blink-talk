import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/login_response.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/auth_service.dart';

class AppMenuController extends GetxController {
  final ApiController controller = Get.put(ApiController());
  var firstName = ''.obs;
  var email = ''.obs;
  var img = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadApiAndProfile();
  }

  void loadApiAndProfile() async {
    await controller.fetchAPIData();
    await getProfile();
  }

  Future<void> getProfile() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        print("Login via Google terdeteksi");

        firstName.value = firebaseUser.displayName ?? 'Tanpa Nama';
        email.value = firebaseUser.email ?? 'Tanpa Email';
        img.value = firebaseUser.photoURL ?? 'Tanpa Foto';

        print("Nama: ${firstName.value}");
        print("Email: ${email.value}");
        print("Photo: ${img.value}");
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

  void showLogoutSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Apakah anda yakin ingin keluar ?'),
      action: SnackBarAction(
        label: 'Ya',
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
          await AuthService.clearToken();
          await AuthService.clearEmail();
          Get.offAllNamed('/login');
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show the SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
