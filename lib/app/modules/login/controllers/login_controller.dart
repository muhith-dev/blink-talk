import 'dart:convert';

import 'package:blink_talk/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/services/api_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiController controller = Get.put(ApiController());

  var isLoading = false.obs;

  Future<void> login() async {
    // if (controller.backendAPI.value.isEmpty ||
    //     controller.backendAPI.value == "Not Available") {
    //   Get.snackbar(
    //     'Error',
    //     'API belum tersedia. Pastikan koneksi internet dan coba lagi.',
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    isLoading.value = true;
    final String baseUrlCloud = controller.backendAPI.value;
    final String apiKeyCloud = controller.backendApiKey.value;
    final String apiUrl = "$baseUrlCloud/api/auth/login";
    final String apiKey = "$apiKeyCloud";
    print("Base URL: ${controller.backendAPI.value}");
    print("API URL: $apiUrl");

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

        await AuthService.saveToken(token);

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
