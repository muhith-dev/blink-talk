import 'package:get/get.dart';

import '../controllers/dealing_with_model_controller.dart';

class DealingWithModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealingWithModelController>(
      () => DealingWithModelController(),
    );
  }
}
