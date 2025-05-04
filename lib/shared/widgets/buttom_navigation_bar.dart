import 'package:blink_talk/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      backgroundColor: Colors.white,
      currentIndex: _getCurrentIndex(),
      onTap: (index) {
        switch (index) {
          case 0:
            Get.toNamed(Routes.HOME);
            break;
          case 1:
            Get.toNamed(Routes.DEALING_WITH_MODEL);
            break;
          case 2:
            Get.toNamed(Routes.ABOUT);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset('assets/images/navbar/hospital.png'),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset('assets/images/navbar/restaurant.png'),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset('assets/images/navbar/about.png'),
          ),
          label: '',
        ),
      ],
    );
  }

  int _getCurrentIndex() {
    var currentRoute = Get.currentRoute;
    switch (currentRoute) {
      case Routes.HOME:
        return 0;
      case Routes.DEALING_WITH_MODEL:
        return 1;
      case Routes.ABOUT:
        return 2;
      default:
        return 0;
    }
  }
}
