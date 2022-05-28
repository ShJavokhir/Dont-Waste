import 'dart:ui';
import 'package:dont_waste/app/core/utils/category_utility.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/modules/food_market/bindings/food_market_binding.dart';
import 'package:dont_waste/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:dont_waste/app/widgets/categories.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/modules/food_preview/views/food_preview_view.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../controllers/food_market_controller.dart';

class FoodMarketView extends GetView<FoodMarketController> {

  // final Map<int, Widget> myTabs =  ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            controller.scrollUp();
          },
          backgroundColor: yellow1,
          child: Icon(Icons.arrow_upward_rounded),
        ),
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
        // appBar: AppBar(
        //   // actions: [
        //   //   IconButton(icon: Icon(Icons.menu), onPressed: (){
        //   //
        //   //   },),
        //   // ],
        //   // leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
        //   //   Get.back();
        //   // },),
        //   backgroundColor: Colors.white,
        //   elevation: 0.4,
        //   // automaticallyImplyLeading: false,
        //   title: Container(
        //     child: Container(
        //     width: double.infinity,
        //     child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Hero(
        //         tag: 'assets/images/burger.png',
        //         child: Image.asset(
        //           'assets/images/burger.png',
        //           alignment: Alignment.center,
        //           height: 50,
        //           width: 50,
        //         ),
        //       ),
        //       SizedBox(width: 10),
        //       // Hero(
        //       //   tag: 'assets/images/burger.png',
        //       //   child: Flexible(
        //       //     child: Image.asset(
        //       //       'assets/images/burger.png',
        //       //       alignment: Alignment.center,
        //       //       fit: BoxFit.contain,
        //       //     ),
        //       //   ),
        //       // ),
        //       Hero(
        //           tag: 'assets/images/burger.pngchoice',
        //           child: Text("find_food_page".tr(),
        //               style: Theme.of(context).textTheme.bodyText1)),
        //     ],
        //     ),
        //     ),
        //   ),
        //   centerTitle: false,
        // ),
        body: Column(children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Obx(
                () => ListView(
                  controller: controller.scrollController,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(DEFAULT_PADDING * 1.0,DEFAULT_PADDING * 1.0,DEFAULT_PADDING * 1.0,0),
                      child: Material(
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
                            height: 50,
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
                                FittedBox(
                                  child: Text(
                                    "see_nearby_foods".tr(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                      child: CupertinoSlidingSegmentedControl(
                          backgroundColor: black4,
                          padding: EdgeInsets.all(5),
                          thumbColor: Colors.orangeAccent,
                          groupValue: controller.segmentedControlGroupValue.value,
                          children: <int, Widget>{
                            0: Padding(padding: EdgeInsets.all(10), child: Text("eatable".tr(), style: TextStyle(
                              color: controller.segmentedControlGroupValue.value == 0?Colors.white:Colors.black87
                            ),)),
                            1: Padding(padding: EdgeInsets.all(10), child: Text("expired".tr(), style: TextStyle(
                      color: controller.segmentedControlGroupValue.value == 1?Colors.white:Colors.black87
                      ),))
                          },
                          onValueChanged: (i) {
                            controller.segmentedControlGroupValue.value =  int.parse(i.toString()) ;
                            controller.switchMarket();
                            // setState(() {
                            //   segmentedControlGroupValue = i;

                          }),
                    ),
                    Visibility(
                      visible: controller.segmentedControlGroupValue.value == 0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            //height: 50,
                              child: CustomCategories(onCategorySelected: (categoryId){
                                controller.fetchByCategory(CategoryUtility.getCategoryNameById(categoryId));
                              },)
                          ),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                      child: Visibility(visible: controller.isLoading.value , child: Container(
                        //padding: EdgeInsets.all(50),
                        //width: 85.w,
                        child: Container(
                            padding: EdgeInsets.all(15),
                            //width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: black4,
                              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(
                                    color: yellow1,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'loading'.tr(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      )),
                    ),
                    Visibility(visible: !controller.isLoading.value && controller.foods.value.length == 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 80,),
                          Image.asset('assets/images/sad.gif', height: 150, width: 150,),
                          SizedBox(height: 30,),
                          Text("no_foods_found".tr(), textAlign: TextAlign.center,)
                        ],
                      ),
                    )
                      ),
                    ...controller.foods.value.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15, right: DEFAULT_PADDING * 1.0, left: DEFAULT_PADDING * 1.0),
                        child: SingleFoodOrder(
                          id: e.id,
                          isDonation: e.isDonation ?? false,
                          postedTimestamp: e.postedTimestamp,
                          title: e.title ?? "null",
                          price: e.price ?? 0,
                          location: e.city ?? "Uzbekistan",
                          photo_url: e.photo_url ?? "no",
                          isEatable: e.isEatable ?? true,
                          isTop: e.isTop ?? false,
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
