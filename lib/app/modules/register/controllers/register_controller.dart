import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../data/services/api_service.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ApiController controller = Get.put(ApiController());

  var isLoading = false.obs;

  Future<void> register() async {
    isLoading.value = true;
    final String baseUrlCloud = controller.backendAPI.value;
    final String apiKeyCloud = controller.backendApiKey.value;
    final String apiUrl = "$baseUrlCloud/api/auth/register";
    final String apiUrlSendOTP = "$baseUrlCloud/api/auth/send_otp_email";
    final String apiKey = "$apiKeyCloud";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "confirm_password": confirmPasswordController.text.trim()
        }),
      );

      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 201) {
          http.post(
            Uri.parse(apiUrlSendOTP),
            headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
            body: jsonEncode({
              "email": emailController.text.trim(),
            }),
          );
          Get.offAllNamed('/verification',
              arguments: {"email": emailController.text.trim()});
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

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      await googleSignIn.signOut(); // optional, untuk logout dulu

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print("Login Google dibatalkan pengguna");
        Get.snackbar("Login Dibatalkan", "Pengguna membatalkan login Google.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login ke Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        print("Login sukses: ${user.displayName} (${user.email})");

        Get.snackbar("Sukses", "Login Google berhasil");
        Get.offAllNamed('/home');
      }
    } catch (e) {
      print("Error saat login Google: $e");
      Get.snackbar("Error", "Terjadi kesalahan saat login: $e");
    }
  }

  void navigateToLogin() {
    Get.toNamed('/login');
  }

  Future<void> sendOTPEmail() async {
    final String baseUrlCloud = controller.backendAPI.value;
    final String apiKeyCloud = controller.backendApiKey.value;
    final String apiUrl = "$baseUrlCloud/api/auth/send_otp_email";
    final String apiKey = "$apiKeyCloud";
  }
}
