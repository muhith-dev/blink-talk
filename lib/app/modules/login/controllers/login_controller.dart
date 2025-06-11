import 'dart:convert';

import 'package:blink_talk/app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    final String apiUrlSendOTP = "$baseUrlCloud/api/auth/send_otp_email";
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
      } else if (data['email_verified'] == false) {
        print("error : $response");
        Get.snackbar(
          'Verification Required',
          'Email Anda perlu diverifikasi.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        http.post(
          Uri.parse(apiUrlSendOTP),
          headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
          body: jsonEncode({
            "email": emailController.text.trim(),
          }),
        );
        Get.offAllNamed('/verification',
            arguments: {"email": emailController.text.trim()});
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

        final token = googleAuth.accessToken;

        await AuthService.saveToken(token!);

        Get.snackbar("Sukses", "Login Google berhasil");
        Get.offAllNamed('/home');
      }
    } catch (e) {
      print("Error saat login Google: $e");
      Get.snackbar("Error", "Terjadi kesalahan saat login: $e");
    }
  }

  void navigateToRegister() {
    Get.offAllNamed('/register');
  }
}
