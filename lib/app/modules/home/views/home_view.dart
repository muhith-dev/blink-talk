import 'package:blink_talk/app/modules/learn/learn_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  Get.toNamed('/edit-profile');
                },
                child: Container(
                    width: 375,
                    height: 65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(controller.img.value),
                              radius: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.firstName.value,
                                  style: const TextStyle(
                                    color: Color(0xff496173),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  controller.email.value,
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
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
