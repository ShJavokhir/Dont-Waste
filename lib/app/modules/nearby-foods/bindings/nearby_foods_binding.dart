import 'package:get/get.dart';

import '../controllers/nearby_foods_controller.dart';

class NearbyFoodsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NearbyFoodsController>(
      () => NearbyFoodsController(),
    );
  }
}
