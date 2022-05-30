import 'package:get/get.dart';

import '../controllers/bonus_coins_controller.dart';

class BonusCoinsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusCoinsController>(
      () => BonusCoinsController(),
    );
  }
}
