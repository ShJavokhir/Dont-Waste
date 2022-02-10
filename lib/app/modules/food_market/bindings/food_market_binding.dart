import 'package:get/get.dart';

import '../controllers/food_market_controller.dart';

class FoodMarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodMarketController>(
      () => FoodMarketController(),
    );
  }
}
