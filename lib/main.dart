import 'package:blink_talk/app/data/services/auth_service.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  cameras = await availableCameras();

  final isLoggedIn = await AuthService.isLoggedIn();

  runApp(
    GetMaterialApp(
      theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.yellow)),
      title: "Application",
      initialRoute: isLoggedIn ? '/home' : '/login',
      getPages: AppPages.routes,
    ),
  );
}
