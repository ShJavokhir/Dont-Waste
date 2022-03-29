import 'dart:ui';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/modules/food_market/bindings/food_market_binding.dart';
import 'package:dont_waste/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/modules/food_preview/views/food_preview_view.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;

import '../controllers/food_market_controller.dart';

class FoodMarketView extends GetView<FoodMarketController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 20,
        //   currentIndex: 1,
        //   onTap: (index)async{
        //     final currentIndex = 1;
        //     if(index == 0 && currentIndex != 0){
        //       Get.offAllNamed('/choice-view');
        //     }else if(index == 1 && currentIndex != 1){
        //       FoodMarketBinding().dependencies();
        //       await Get.find<FoodMarketController>().setFoods();
        //       //await Future.delayed(Duration(seconds: 2));
        //       Get.offAllNamed("/food-market");
        //     }else if(index == 2 && currentIndex != 2){
        //       Get.toNamed("/become-sponsor");
        //     }else if(index == 3 && currentIndex != 3){
        //       if (FirebaseAuth.instance.currentUser != null) {
        //         // signed in
        //         UserProfileBinding().dependencies();
        //         await Get.find<UserProfileController>().setFoods();
        //         // Get.toNamed("/food-preview");
        //         Get.toNamed('/user-profile');
        //         //print("Signed");
        //       } else {
        //         print("Not signed in yet");
        //         Get.toNamed("/authentication");
        //       }
        //     }
        //   },
        //   type: BottomNavigationBarType.fixed, // Fixed
        //   backgroundColor: Colors.white, // <-- This works for fixed
        //   selectedItemColor: yellow1,
        //   unselectedItemColor: Colors.grey,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_cart),
        //       label: 'Food market',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.add_a_photo),
        //       label: 'Add food',
        //     ),
        //     BottomNavigationBarItem(
        //
        //       icon: Icon(Icons.account_circle),
        //       label: 'Profile',
        //     ),
        //
        //   ],
        // ),
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // actions: [
          //   IconButton(icon: Icon(Icons.menu), onPressed: (){
          //
          //   },),
          // ],
          // leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          //   Get.back();
          // },),
          backgroundColor: Colors.white,
          elevation: 0.4,
          // automaticallyImplyLeading: false,
          title: Container(
            child: Container(
            width: double.infinity,
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'assets/images/burger.png',
                child: Image.asset(
                  'assets/images/burger.png',
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(width: 10),
              // Hero(
              //   tag: 'assets/images/burger.png',
              //   child: Flexible(
              //     child: Image.asset(
              //       'assets/images/burger.png',
              //       alignment: Alignment.center,
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
              Hero(
                  tag: 'assets/images/burger.pngchoice',
                  child: Text("Find food",
                      style: Theme.of(context).textTheme.bodyText1)),
            ],
            ),
            ),
          ),
          centerTitle: false,
        ),
        body: Column(children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(DEFAULT_PADDING * 1.0,DEFAULT_PADDING * 1.0,DEFAULT_PADDING * 1.0,0),
              child: Obx(
                () => ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          //open nearby foods page
                          Get.toNamed("/nearby-foods");
                        },
                        splashColor: Colors.yellow,
                        highlightColor: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          // margin:
                          // EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: green2,
                            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 0.4),
                          ),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.image_search_rounded),
                              SizedBox(width: 10,),
                              Text(
                                "see_nearby_foods".tr(),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right_rounded)
                              // Expanded(
                              //   flex: 5,
                              //   child: Container(
                              //     padding: EdgeInsets.symmetric(horizontal: 10),
                              //     alignment: Alignment.center,
                              //     height: double.infinity,
                              //     width: 150,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white70,
                              //       borderRadius:
                              //       BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                              //     ),
                              //     child: FittedBox(
                              //       child: Text(
                              //         "Test",
                              //         textAlign: TextAlign.center,
                              //
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ...controller.foods.value.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SingleFoodOrder(
                          id: e.id,
                          isDonation: e.isDonation ?? false,
                          postedTimestamp: e.postedTimestamp,
                          title: e.title ?? "null",
                          price: e.price ?? 0,
                          location: e.city ?? "Uzbekistan",
                          photo_url: e.photo_url ?? "no",
                          onPressed: () {
                            FoodPreviewBinding().dependencies();
                            Get.find<FoodPreviewController>().foodModel = e;
                            Get.toNamed("/food-preview");
                          },
                        ),
                      );
                    }).toList()
                  ],
                ),
              ),

              // ListView(
              //   physics: BouncingScrollPhysics(
              //       parent: AlwaysScrollableScrollPhysics()),
              //   children: [
              //     SizedBox(height: 10),

              //     ),
              //   ],
              // )
            ),
          )
        ]),
      ),
    );
  }
}
