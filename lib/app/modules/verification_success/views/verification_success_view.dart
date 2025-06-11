import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/verification_success_controller.dart';

class VerificationSuccessView extends GetView<VerificationSuccessController> {
  const VerificationSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: 150, left: 20, right: 20, bottom: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 340,
                  child: Image.asset('assets/images/verification/Box.png'),
                ),
                SizedBox(
                  height: 56,
                ),
                Text(
                  "Registrasi Berhasil",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Get.offAllNamed('/login');
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
                    backgroundColor: Color(0xFF1639F1),
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
