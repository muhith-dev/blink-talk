import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../shared/widgets/customTextField.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: Align(
              alignment: Alignment.topCenter,
              child: Lottie.asset('assets/animations/auth.json', height: 300),
            ),
          ),

          Positioned(
            top: 300,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign in',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Please enter a valid account',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Enter your email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 6),
                      CustomTextField(
                        obscureText: true,
                        hintText: 'Enter your password',
                        controller: controller.passwordController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot Password ?',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
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
                          onPressed: controller.login,
                          child: Obx(
                            () =>
                                controller.isLoading.value
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                      'Sign in',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Divider(color: Colors.black, height: 4),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "OR",
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Divider(color: Colors.black, height: 4),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : controller.signInWithGoogle,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 0.5, color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fixedSize: Size(70, 49),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Image.asset(
                              'assets/icons/google.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5.0,
                                ), //                 <--- border radius here
                              ),
                            ),
                            width: 70,
                            height: 49,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                                left: 25,
                                right: 25,
                              ),
                              child: Image(
                                image: AssetImage('assets/icons/x.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have account?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 2),
                          InkWell(
                            onTap: () => Get.offAllNamed('/register'),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
