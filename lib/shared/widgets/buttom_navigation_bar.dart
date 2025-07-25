import 'package:blink_talk/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

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
            Get.toNamed(Routes.CHART);
            break;
          case 3:
            Get.toNamed(Routes.APP_MENU);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Symbols.home,
              color: Colors.black,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Symbols.eye_tracking_rounded,
              color: Colors.black,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.insert_chart,
              color: Colors.black,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.dehaze,
              color: Colors.black,
            ),
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
      case Routes.CHART:
        return 2;
      case Routes.APP_MENU:
        return 3;
      default:
        return 0;
    }
  }
}
