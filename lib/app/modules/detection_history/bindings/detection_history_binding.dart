import 'package:get/get.dart';

import '../controllers/detection_history_controller.dart';

class DetectionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetectionHistoryController>(
      () => DetectionHistoryController(),
    );
  }
}
