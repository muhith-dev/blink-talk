import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/login_response.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/auth_service.dart';

class ProfileController extends GetxController {
  final ApiController controller = Get.put(ApiController());
  var userName = ''.obs;
  var firstName = ''.obs;
  var email = ''.obs;
  var img = ''.obs;
  var isGoogleLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadApiAndProfile();
  }

  void loadApiAndProfile() async {
    await controller.fetchAPIData();
    await getProfile();
  }

  void printResponse() async {}

  Future<void> getProfile() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        print("Login via Google terdeteksi");

        isGoogleLoggedIn.value = true;
        firstName.value = firebaseUser.displayName ?? 'Tanpa Nama';
        email.value = firebaseUser.email ?? 'Tanpa Email';
        img.value = firebaseUser.photoURL ?? 'Tanpa Foto';
        userName.value = firebaseUser.phoneNumber ?? 'Tanpa Username';

        print("Nama: ${firstName.value}");
        print("Email: ${email.value}");
        print("Photo: ${img.value}");
        return;
      }

      isGoogleLoggedIn.value = false;
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
        userName.value = loginResponse.user.username;

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
}
