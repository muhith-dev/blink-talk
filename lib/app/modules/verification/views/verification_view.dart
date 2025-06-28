import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed('/login');
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 386),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verifikasi",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kode verifikasinya udah dikirim ke",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          controller.email.isNotEmpty
                              ? controller.email
                              : "Email belum tersedia",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 51,
                            height: 51,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onCompleted: (value) {
                            controller.otpCode = value;
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      if (controller.secondReaming.value == 0) {
                        return TextButton(
                            onPressed: () {
                              controller.secondReaming.value = 300;
                              controller.startTimer();
                            },
                            child: Text(
                              "Kirim ulang kode",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ));
                      } else {
                        final minutes = (controller.secondReaming.value ~/ 60)
                            .toString()
                            .padLeft(2, '0');
                        final seconds = (controller.secondReaming.value % 60)
                            .toString()
                            .padLeft(2, '0');

                        return Text(
                          "Kirim ulang kode dalam $minutes:$seconds",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      if (controller.otpCode == null ||
                          controller.otpCode!.length != 6) {
                        Get.snackbar("Error", "Kode OTP belum lengkap");
                        return;
                      }
                      controller.verifyOtp(
                          email: controller.email, otp: controller.otpCode!);
                    },
                    child: Text(
                      "konfirmasi",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
