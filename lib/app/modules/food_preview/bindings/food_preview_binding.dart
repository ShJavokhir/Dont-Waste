import 'package:get/get.dart';

import '../controllers/food_preview_controller.dart';

class FoodPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodPreviewController>(
      () => FoodPreviewController(),
    );
  }
}
