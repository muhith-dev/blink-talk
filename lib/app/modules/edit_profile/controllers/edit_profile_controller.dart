import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/services/api_service.dart';
import '../../../data/services/auth_service.dart';

class EditProfileController extends GetxController {
  final ApiController controller = Get.put(ApiController());
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController newPassword;

  late String img;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      final Map<String, dynamic> args = Get.arguments;

      final initialName = args['name'] ?? "No Name";
      final initialEmail = args['email'] ?? "No Email";
      final initialUsername = args['username'] ?? "No Username";
      final initialPassword = args['newpassword'] ?? "";

      img = args['image'] ?? "No Image";

      name = TextEditingController(text: initialName);
      email = TextEditingController(text: initialEmail);
      username = TextEditingController(text: initialUsername);
      newPassword = TextEditingController(text: initialPassword);
    } else {
      name = TextEditingController(text: 'Error');
      email = TextEditingController(text: 'Error');
      username = TextEditingController(text: 'Error');
      newPassword = TextEditingController(text: 'Error');
      img = '';
    }
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    super.onClose();
  }

  Future<void> editProfile() async {
    final String baseUrlCloud = controller.backendAPI.value;
    final token = await AuthService.getToken();

    if (token == null) {
      Get.snackbar(
        'Error',
        'Token tidak ditemukan. Silakan login kembali.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.offAllNamed('/login');
      return;
    }

    final String apiUrl = "$baseUrlCloud/api/users/profile";

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'username': username.text.trim(),
        'password': newPassword.text.trim()
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      Get.offAllNamed('/profile');
      Get.snackbar("Berhasil", 'Profile berhasil di edit');
    } else {
      Get.snackbar('Edit Profile Gagal', data['message'] ?? 'Gagal',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
