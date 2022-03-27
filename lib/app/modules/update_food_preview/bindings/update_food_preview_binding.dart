import 'package:get/get.dart';

import '../controllers/update_food_preview_controller.dart';

class UpdateFoodPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateFoodPreviewController>(
      () => UpdateFoodPreviewController(),
    );
  }
}
