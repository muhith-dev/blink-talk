import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  late TextEditingController name;
  late TextEditingController email;

  late String img;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      final Map<String, dynamic> args = Get.arguments;

      final initialName = args['name'] ?? "No Name";
      final initialEmail = args['email'] ?? "No Email";

      img = args['image'] ?? "No Image";

      name = TextEditingController(text: initialName);
      email = TextEditingController(text: initialEmail);
    } else {
      name = TextEditingController(text: 'Error');
      email = TextEditingController(text: 'Error');
      img = '';
    }
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    super.onClose();
  }
}
