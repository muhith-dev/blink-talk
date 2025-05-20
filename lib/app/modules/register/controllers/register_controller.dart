import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> register() async {
    isLoading.value = true;

    final String apiUrl = "https://be-flask-c.vercel.app/api/auth/register";
    final String apiKey = "api_key_bais_sangat_aman_sekali";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 201) {
          Get.offAllNamed('/login');
          Get.snackbar('Success', 'Register berhasil!');
        } else {
          Get.snackbar(
            'Register Failed ',
            data['message'] ?? 'Registrasi gagal.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        print("Unexpected response: ${response.body}");
        Get.snackbar(
          'Error',
          'Format respons tidak valid',
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
      print("Register error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToLogin() {
    Get.toNamed('/login');
  }
}
