import 'package:dont_waste/app/modules/become_sponsor/controllers/become_sponsor_controller.dart';
import 'package:dont_waste/app/modules/choice_view/controllers/choice_view_controller.dart';
import 'package:dont_waste/app/modules/choice_view/views/choice_view_view.dart';
import 'package:dont_waste/app/modules/food_market/controllers/food_market_controller.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/frame_controller.dart';

class FrameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrameController>(
      () => FrameController(),
    );
    Get.lazyPut<ChoiceViewController>(
          () => ChoiceViewController(),
    );
    Get.lazyPut<FoodMarketController>(
          () => FoodMarketController(),
    );
    Get.lazyPut<UserProfileController>(
          () => UserProfileController(),
    );
    Get.lazyPut<BecomeSponsorController>(
          () => BecomeSponsorController(),
    );

  }
}
