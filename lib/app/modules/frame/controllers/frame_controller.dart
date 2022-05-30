import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/modules/about/bindings/about_binding.dart';
import 'package:dont_waste/app/modules/about/controllers/about_controller.dart';
import 'package:dont_waste/app/modules/become_sponsor/controllers/become_sponsor_controller.dart';
import 'package:dont_waste/app/modules/choice_view/controllers/choice_view_controller.dart';
import 'package:dont_waste/app/modules/food_market/bindings/food_market_binding.dart';
import 'package:dont_waste/app/modules/food_market/controllers/food_market_controller.dart';
import 'package:dont_waste/app/modules/settings/bindings/settings_binding.dart';
import 'package:dont_waste/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_data_controller.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:dont_waste/app/widgets/custom_comfirmation_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

class FrameController extends GetxController {

  @override
  void onInit() {
    FoodMarketBinding().dependencies();
    super.onInit();
  }

  @override
  void onReady() {
    // Get.find<UserDataController>()
    super.onReady();
  }

  var tabIndex = 0;

  void changeTabIndex(int index, {int initialIndex=0}) async{
    Get.delete<BecomeSponsorController>();
    Get.delete<FoodMarketController>();
    Get.delete<UserProfileController>();
    Get.delete<AboutController>();
    if(index == 0) {
      FoodMarketBinding().dependencies();

      // Get.put(ChoiceViewController());
      tabIndex = index;
    }
    // if(index == 1){
    //   FoodMarketBinding().dependencies();
    //   //await Get.find<FoodMarketController>().setFoods();
    //   tabIndex = index;
    // }
    if(index == 1){
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
    if(index == 2) {
      final auth = FirebaseAuth.instance;

      //auth.signOut();
      if (auth.currentUser != null) {
        // signed in
        UserProfileBinding().dependencies();
        // await Get.find<UserProfileController>().setFoods();
        if(initialIndex != null){
          //Get.find<UserProfileController>().initialIndex  = initialIndex;
        }
        // Get.toNamed("/food-preview");
        tabIndex = index;
        //print("Signed");
      } else {
        print("Not signed in yet");
        Get.toNamed("/authentication");
      }
    }
    if(index == 3){
      SettingsBinding().dependencies();
      //await Get.find<AboutController>().getStats();
      // Get.toNamed("/food-preview");
      tabIndex = index;

      // AboutBinding().dependencies();
      // await Get.find<AboutController>().getStats();
      // // Get.toNamed("/food-preview");
      // tabIndex = index;
    }

    update();
  }

  void changeLocale(String opt){
    BuildContext context = Get.context!;
    if (opt == "UZ") {
      final locale = Locale("uz", "UZ");
      context.setLocale(locale);
      EasyLocalization.of(context)!.setLocale(locale);
      //EasyLocalization.of(context)!.currentLocale = locale;
      Get.updateLocale(locale);
    } else if (opt == "RU") {
      final locale =(Locale("ru", "RU"));
      context.setLocale(locale);
      Get.updateLocale(locale);
      EasyLocalization.of(context)!.setLocale(locale);
    } else if (opt == "EN") {
      final locale =(Locale("en", "EN"));
      context.setLocale(locale);
      Get.updateLocale(locale);
      EasyLocalization.of(context)!.setLocale(locale);
    }

    //Get.offAndToNamed('/choice-view');
    Get.forceAppUpdate();
    Get.appUpdate();
    //FrameBinding().dependencies();
    //       await Get.find<FoodMarketController>().setFoods();

  }
  Future<void> signOut()async{
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomComfirmationDialog(
          onCancel: () {
            Get.back();
          },
          onConfirm: () async{
            Get.back();
            FirebaseAuth.instance.signOut().then((value)async {
              Get.appUpdate();
              Get.snackbar(
                "info".tr(),
                "succesfully_signed_out".tr(),
                colorText: Colors.white,
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                progressIndicatorBackgroundColor: Colors.green,
                barBlur: 0,
                dismissDirection: DismissDirection.horizontal,
                duration: Duration(milliseconds: 2500),

                //instantInit:a true,
                //shouldIconPulse: true,
                animationDuration: Duration(milliseconds: 300),
                icon: Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 35,
                ),
                snackPosition: SnackPosition.TOP,
                backgroundColor: yellow1,
              );
              //setState();
            }).catchError((onError){
              Get.snackbar(
                "error".tr(),
                "unexpected_error_happened".tr() + onError.toString(),
                colorText: Colors.white,
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),

                barBlur: 0,
                dismissDirection: DismissDirection.horizontal,
                duration: Duration(milliseconds: 200),

                //instantInit: true,
                //shouldIconPulse: true,
                animationDuration: Duration(milliseconds: 300),
                icon: Icon(
                  Icons.cancel,
                  color: red2,
                  size: 35,
                ),
                snackPosition: SnackPosition.TOP,
                backgroundColor: yellow1,
              );
            });

          },
          text: "are_u_sure_to_sign_out".tr(),
        );
      },
    );
  }
  Future<bool> onWillPop()async{
    if(tabIndex == 0){
      return true;
    }else{
      changeTabIndex(0);
      return false;
    }

  }
}
