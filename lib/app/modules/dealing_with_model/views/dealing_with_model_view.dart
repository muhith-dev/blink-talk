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
                    const SizedBox(height: 280),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            controller.receivedMessage.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    const SizedBox(height: 16),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              controller.isWebSocketConnected.value
                                  ? Icons.wifi
                                  : Icons.wifi_off,
                              color: controller.isWebSocketConnected.value
                                  ? Colors.green
                                  : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.isWebSocketConnected.value
                                  ? 'Terhubung'
                                  : 'Tidak Terhubung',
                              style: TextStyle(
                                color: controller.isWebSocketConnected.value
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Icon(
                              controller.isDetectionActive.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: controller.isDetectionActive.value
                                  ? Colors.green
                                  : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.isDetectionActive.value
                                  ? 'Aktif'
                                  : 'Tidak Aktif',
                              style: TextStyle(
                                color: controller.isDetectionActive.value
                                    ? Colors.green
                                    : Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Obx(() => Stack(
                    children: [
                      Container(
                        child: controller.isCameraActive.value
                            ? AspectRatio(
                                aspectRatio: 1 / 1,
                                child:
                                    CameraPreview(controller.cameraController!),
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
                      if (controller.isInCooldown.value)
                        Container(
                          height: 400,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Cooldown',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Obx(() => Text(
                                      '${controller.cooldownSeconds.value} detik',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => _buildDetectionControlButton()),
                const SizedBox(width: 10),
                Obx(() => ElevatedButton.icon(
                      onPressed: controller.toggleCamera,
                      icon: Icon(
                        controller.isCameraActive.value
                            ? CupertinoIcons.video_camera_solid
                            : CupertinoIcons.video_camera,
                      ),
                      label: Text(
                        controller.isCameraActive.value ? 'Matikan' : 'Kamera',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isCameraActive.value
                            ? Colors.red
                            : const Color(0xff3E83FC),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
      drawer: controller.buildDrawer(context),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildDetectionControlButton() {
    if (controller.isInCooldown.value) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Text(
                  'Cooldown ${controller.cooldownSeconds.value} detik',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: controller.isDetectionActive.value
          ? controller.stopDetection
          : controller.startDetection,
      icon: Icon(
        controller.isDetectionActive.value ? Icons.stop : Icons.play_arrow,
      ),
      label: Text(
        controller.isDetectionActive.value ? 'Berhenti' : 'Mulai Deteksi',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            controller.isDetectionActive.value ? Colors.red : Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
