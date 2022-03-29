import 'package:dont_waste/app/modules/about/bindings/about_binding.dart';
import 'package:dont_waste/app/modules/about/controllers/about_controller.dart';
import 'package:dont_waste/app/modules/become_sponsor/controllers/become_sponsor_controller.dart';
import 'package:dont_waste/app/modules/choice_view/controllers/choice_view_controller.dart';
import 'package:dont_waste/app/modules/food_market/bindings/food_market_binding.dart';
import 'package:dont_waste/app/modules/food_market/controllers/food_market_controller.dart';
import 'package:dont_waste/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FrameController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  var tabIndex = 0;

  void changeTabIndex(int index) async{
    Get.delete<BecomeSponsorController>();
    Get.delete<FoodMarketController>();
    Get.delete<UserProfileController>();
    Get.delete<AboutController>();
    if(index == 0) {
      Get.put(ChoiceViewController());
      tabIndex = index;
    }
    if(index == 1){
      FoodMarketBinding().dependencies();
      await Get.find<FoodMarketController>().setFoods();
      tabIndex = index;
    }
    if(index == 2){
      final auth = FirebaseAuth.instance;
      //auth.signOut();
      if (auth.currentUser != null) {
        // signed in
        Get.put(BecomeSponsorController());


        tabIndex = index;
        print("Signed");
      } else {
        print("Not signed in yet");
        Get.toNamed("/authentication");
      }


    }
    if(index == 3) {
      final auth = FirebaseAuth.instance;

      //auth.signOut();
      if (auth.currentUser != null) {
        // signed in
        UserProfileBinding().dependencies();
        await Get.find<UserProfileController>().setFoods();
        // Get.toNamed("/food-preview");
        tabIndex = index;
        //print("Signed");
      } else {
        print("Not signed in yet");
        Get.toNamed("/authentication");
      }
    }
    if(index == 4){
      AboutBinding().dependencies();
      await Get.find<AboutController>().getStats();
      // Get.toNamed("/food-preview");
      tabIndex = index;
    }


    update();
  }

}
