import 'package:blink_talk/app/modules/onboarding/views/onboarding_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSecondView extends GetView {
  const OnboardingSecondView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/logo/blinktalk.png'),
            ),
          ),

          Positioned(
            top: 470,
            left: 0,
            right: 0,
            bottom: 0, // penting untuk height penuh dari posisi top
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 17, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gunakan di Restoran',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 44),
                    Text(
                      'Nikmati pengalaman makan di restoran tanpa hambatan komunikasi. BlinkTalk membantu Anda memesan makanan atau berinteraksi dengan pelayan hanya dengan kedipan mata, mendukung mereka yang memiliki keterbatasan bicara atau gerak.',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 75),
                    Container(
                      width: 370,
                      height: 59,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const OnboardingThirdView());
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
