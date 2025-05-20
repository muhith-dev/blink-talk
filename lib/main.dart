import 'package:blink_talk/app/services/auth_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  final isLoggedIn = await AuthService.isLoggedIn();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: isLoggedIn ? '/home' : '/login',
      getPages: AppPages.routes,
    ),
  );
}
