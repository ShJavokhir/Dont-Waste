import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/about/views/about_view.dart';
import 'package:dont_waste/app/modules/become_sponsor/views/become_sponsor_view.dart';
import 'package:dont_waste/app/modules/choice_view/views/choice_view_view.dart';
import 'package:dont_waste/app/modules/food_market/views/food_market_view.dart';
import 'package:dont_waste/app/modules/user_profile/views/user_profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../controllers/frame_controller.dart';

class FrameView extends GetView<FrameController> {
  List<Widget> _pages = [ChoiceViewView(), FoodMarketView(), BecomeSponsorView(), UserProfileView(), AboutView()];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrameController>(
      builder: (controller) {
        return Scaffold(

            body: SafeArea(
                child: _pages[controller.tabIndex]

            ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(BORDER_RADIUS_1 * 1.0), topLeft: Radius.circular(BORDER_RADIUS_1 * 1.0)),
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 0.05, blurRadius: 0.01),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BORDER_RADIUS_1 * 1.0),
                topRight: Radius.circular(BORDER_RADIUS_1 * 1.0),
              ),
              child: BottomNavigationBar(
                elevation: 20,
                currentIndex: controller.tabIndex,
                onTap: (index)async{
                  controller.changeTabIndex(index);
                  // final currentIndex = 1;
                  // if(index == 0 && currentIndex != 0){
                  //   Get.offAllNamed('/choice-view');
                  // }else if(index == 1 && currentIndex != 1){
                  //   FoodMarketBinding().dependencies();
                  //   await Get.find<FoodMarketController>().setFoods();
                  //   //await Future.delayed(Duration(seconds: 2));
                  //   Get.offAllNamed("/food-market");
                  // }else if(index == 2 && currentIndex != 2){
                  //   Get.toNamed("/become-sponsor");
                  // }else if(index == 3 && currentIndex != 3){
                  //   if (FirebaseAuth.instance.currentUser != null) {
                  //     // signed in
                  //     UserProfileBinding().dependencies();
                  //     await Get.find<UserProfileController>().setFoods();
                  //     // Get.toNamed("/food-preview");
                  //     Get.toNamed('/user-profile');
                  //     //print("Signed");
                  //   } else {
                  //     print("Not signed in yet");
                  //     Get.toNamed("/authentication");
                  //   }
                  // }
                },
                type: BottomNavigationBarType.fixed, // Fixed
                backgroundColor: Colors.white, // <-- This works for fixed
                selectedItemColor: yellow1,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'home_button'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'foods_button'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_a_photo),
                    label: 'add_post_button'.tr(),
                  ),
                  BottomNavigationBarItem(

                    icon: Icon(Icons.account_circle),
                    label: 'profile_button'.tr(),
                  ),
                  BottomNavigationBarItem(

                    icon: Icon(Icons.question_mark_rounded),
                    label: 'about_button'.tr(),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
