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
      body: SingleChildScrollView(
        child: Column(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                                  aspectRatio: 5 / 5,
                                  child: CameraPreview(
                                      controller.cameraController!),
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
                          controller.isCameraActive.value
                              ? 'Matikan'
                              : 'Kamera',
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
            // DIMODIFIKASI: Bagian Movements dengan tampilan hasil deteksi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Movements',
                        style: TextStyle(
                          color: Color(0xff959595),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Tombol untuk clear movements
                      Obx(() => controller.detectedMovements.isNotEmpty
                          ? TextButton(
                              onPressed: controller.clearDetectedMovements,
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : const SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Current movement indicator
                  Obx(() => controller.currentMovement.value.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff3E83FC).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xff3E83FC),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Current Movement:',
                                style: TextStyle(
                                  color: Color(0xff959595),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.currentMovement.value,
                                style: const TextStyle(
                                  color: Color(0xff3E83FC),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()),

                  const SizedBox(height: 16),

                  // Movement history
                  Obx(() => controller.detectedMovements.isEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                                size: 48,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Belum ada gerakan terdeteksi',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Mulai deteksi untuk melihat gerakan mata',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: controller.detectedMovements.length,
                            itemBuilder: (context, index) {
                              final movement =
                                  controller.detectedMovements[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? const Color(0xff3E83FC).withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: _getMovementColor(movement),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        movement,
                                        style: TextStyle(
                                          color: index == 0
                                              ? const Color(0xff3E83FC)
                                              : const Color(0xff959595),
                                          fontSize: 14,
                                          fontWeight: index == 0
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (index == 0)
                                      const Icon(
                                        Icons.fiber_new,
                                        color: Color(0xff3E83FC),
                                        size: 16,
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // Helper function untuk menentukan warna berdasarkan jenis gerakan
  Color _getMovementColor(String movement) {
    if (movement.contains('blink')) {
      return Colors.purple;
    } else if (movement.contains('left')) {
      return Colors.orange;
    } else if (movement.contains('right')) {
      return Colors.green;
    } else if (movement.contains('up')) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
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
