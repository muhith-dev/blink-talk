import 'package:blink_talk/app/modules/learn/learn_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/buttom_navigation_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  height: 480,
                  color: Color(0xff3E83FC),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(Learn1());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'IF',
                                    style: TextStyle(
                                      color: Color(0xffCFE0FE),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'YOU NEED TO LEARN',
                                    style: TextStyle(
                                      color: Color(0xffCFE0FE),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'CLICK HERE',
                                    style: TextStyle(
                                      color: Color(0xffCFE0FE),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
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
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed('/dealing-with-model');
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'IF',
                            style: TextStyle(
                              color: Color(0xffA8A8A8),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'YOU NEED TO START',
                            style: TextStyle(
                              color: Color(0xffA8A8A8),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CLICK HERE',
                            style: TextStyle(
                              color: Color(0xffA8A8A8),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 40,
              left: 10,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/user-history');
                },
                child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(19)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.manage_history),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'login history',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double w = size.width;
    double h = size.height;
    path.lineTo(0, 120);
    path.quadraticBezierTo(w * 0.2, h - 50, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
