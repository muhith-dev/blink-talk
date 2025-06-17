import 'package:get/get.dart';

import '../controllers/streamlit_controller.dart';

class StreamlitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreamlitController>(
      () => StreamlitController(),
    );
  }
}
