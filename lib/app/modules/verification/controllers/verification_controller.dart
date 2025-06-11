import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/services/api_service.dart';

class VerificationController extends GetxController {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  final otp5Controller = TextEditingController();
  final otp6Controller = TextEditingController();
  final ApiController controller = Get.put(ApiController());
  late String email;
  var secondReaming = 300.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    email = Get.arguments['email'];
    print(email);
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondReaming > 0) {
        secondReaming--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    final String baseUrlCloud = controller.backendAPI.value;
    final String apiKeyCloud = controller.backendApiKey.value;
    final String apiUrlSendOTP = "$baseUrlCloud/api/auth/verify_otp_email";
    final String apiKey = "$apiKeyCloud";

    try {
      final response = await http.post(Uri.parse(apiUrlSendOTP),
          headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
          body: jsonEncode({"email": email, "otp": otp}));

      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Get.snackbar("Berhasil", "OTP berhasil diverifikasi silahkan login");
          Get.offAllNamed("/login");
        } else {
          Get.snackbar(
              "Gagal", data['message'] ?? "OTP salah atau tidak valid");
        }
      } else {
        Get.snackbar("Error", "Respons tidak valid dari server");
      }
    } catch (e) {
      Get.snackbar("verifikasi gagal", "$e");
    }
  }

  @override
  void onClose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
