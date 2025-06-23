import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../shared/widgets/buttom_navigation_bar.dart';
import '../controllers/dealing_with_model_controller.dart';

class DealingWithModelView extends GetView<DealingWithModelController> {
  const DealingWithModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 180.0),
                  color: const Color(0xff3E83FC),
                  height: 610,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 280,
                      ),
                      Text(
                        'What the patient say show here',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )),
              Obx(
                () => Container(
                  child: controller.isCameraActive.value
                      ? AspectRatio(
                          aspectRatio: 1 / 1,
                          child: CameraPreview(controller.cameraController!),
                        )
                      : Container(
                          height: 400,
                          width: double.infinity,
                          color: Colors.black,
                          child: Lottie.asset(
                            'assets/animations/dealing.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 18),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      controller.scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu, color: Colors.white, size: 25),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Movements',
                style: TextStyle(
                  color: Color(0xff959595),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.toggleCamera,
        backgroundColor: const Color(0xff3E83FC),
        child: Obx(
          () => Icon(
            controller.isCameraActive.value
                ? CupertinoIcons.video_camera_solid
                : CupertinoIcons.video_camera,
            size: 30,
          ),
        ),
      ),
      drawer: controller.buildDrawer(context),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     double w = size.width;
//     double h = size.height;
//     path.lineTo(0, 200);
//     path.quadraticBezierTo(w * 0.5, h + 70, w, 200);
//     path.lineTo(w, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
