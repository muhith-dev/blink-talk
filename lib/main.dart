import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

List<CameraDescription>? cameras; // Tambahkan variabel global ini

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Wajib sebelum pakai kamera
  cameras = await availableCameras(); // Inisialisasi kamera

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
