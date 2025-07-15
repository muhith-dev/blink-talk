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
  late TextEditingController oldPassword;
  late TextEditingController newPassword;
  late TextEditingController confirmPassword;

  late String img;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      final Map<String, dynamic> args = Get.arguments;

      final initialName = args['name'] ?? "No Name";
      final initialEmail = args['email'] ?? "No Email";
      final initialUsername = args['username'] ?? "No Username";

      img = args['image'] ?? "No Image";

      name = TextEditingController(text: initialName);
      email = TextEditingController(text: initialEmail);
      username = TextEditingController(text: initialUsername);
      oldPassword = TextEditingController();
      newPassword = TextEditingController();
      confirmPassword = TextEditingController();
    } else {
      name = TextEditingController(text: 'Error');
      email = TextEditingController(text: 'Error');
      username = TextEditingController(text: 'Error');
      oldPassword = TextEditingController();
      newPassword = TextEditingController();
      confirmPassword = TextEditingController();
      img = '';
    }
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    username.dispose();
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
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

    // Validasi input
    if (username.text.trim().isEmpty &&
        name.text.trim().isEmpty &&
        newPassword.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Tidak ada data yang diperbarui',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validasi password jika ingin mengubah password
    if (newPassword.text.trim().isNotEmpty) {
      if (oldPassword.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Password lama harus diisi untuk mengganti password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (newPassword.text.trim().length < 6) {
        Get.snackbar(
          'Error',
          'Password baru minimal 6 karakter',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (confirmPassword.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Konfirmasi password harus diisi',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (newPassword.text.trim() != confirmPassword.text.trim()) {
        Get.snackbar(
          'Error',
          'Password dan konfirmasi password tidak sama',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    final String apiUrl = "$baseUrlCloud/api/users/profile";

    // Buat body request sesuai dengan backend
    Map<String, dynamic> requestBody = {};

    if (username.text.trim().isNotEmpty) {
      requestBody['username'] = username.text.trim();
    }

    if (name.text.trim().isNotEmpty) {
      requestBody['nama'] = name.text.trim();
    }

    if (newPassword.text.trim().isNotEmpty) {
      requestBody['old_password'] = oldPassword.text.trim();
      requestBody['password'] = newPassword.text.trim();
      requestBody['confirm_password'] = confirmPassword.text.trim();
    }

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-API-Key': controller.backendApiKey.value,
        },
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Cek apakah response adalah JSON yang valid
      if (response.headers['content-type']?.contains('application/json') !=
          true) {
        Get.snackbar(
          'Error',
          'Server mengembalikan response yang tidak valid',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Gagal memproses response dari server',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (response.statusCode == 200) {
        Get.back(); // Kembali ke halaman sebelumnya
        Get.snackbar(
          "Berhasil",
          data['message'] ?? 'Profile berhasil diperbarui',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Edit Profile Gagal',
            data['message'] ?? 'Gagal memperbarui profile',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan koneksi: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
