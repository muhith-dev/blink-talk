import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;

    final String apiUrl = "https://be-flask-c.vercel.app/api/auth/login";
    final String apiKey = "api_key_bais_sangat_aman_sekali";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final token = data['token'];
        final user = data['user'];

        Get.offAllNamed('/home');
        Get.snackbar('Success', 'Login berhasil!');
      } else {
        Get.snackbar(
          'Login Failed',
          data['message'] ?? 'Login gagal.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan. Coba lagi.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Login error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.offAllNamed('/register');
  }
}
