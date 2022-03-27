import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/modules/update_food_preview/bindings/update_food_preview_binding.dart';
import 'package:dont_waste/app/modules/update_food_preview/controllers/update_food_preview_controller.dart';
import 'package:dont_waste/app/widgets/divider.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:dont_waste/app/widgets/single_food_order_for_admin.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: yellow1,
              //automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Colors.black26,
              labelColor: yellow1,

              physics: AlwaysScrollableScrollPhysics(),

              tabs: [
                Tab(text: "my_posts".tr(), icon: Icon(Icons.apps)),
                Tab(text: "settings".tr(), icon: Icon(Icons.settings)),
                // Tab(text: "My Ads", ),
                // Tab(text: "Settings",),
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 0.4,
            //automaticallyImplyLeading: false,
            title: Text("account".tr()),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TabBarView(children: [
              Obx(
                () => ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ...controller.foods.value.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SingleFoodOrderForAdmin(
                          id: e.id,
                          onView: (){
                            FoodPreviewBinding().dependencies();
                            Get.find<FoodPreviewController>().foodModel = e;
                            Get.toNamed("/food-preview");
                          },
                          onEdit: ()async {
                            UpdateFoodPreviewBinding().dependencies();
                            Get.find<UpdateFoodPreviewController>().oldFood = e;
                            await Get.toNamed("/update-food-preview");
                            await Future.delayed(Duration(seconds: 2));
                            await controller.setFoods();
                          },
                          onDelete: () {
                            controller.deletePost(e.id);
                          },
                          title: e.title ?? "null",
                          price: e.price ?? 0,
                          location: e.city ?? "Uzbekistan",
                          views: e.views ?? 0,
                          photo_url: e.photo_url,
                        ),
                      );
                    }).toList(),
                    controller.foods.value.length == 0?Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.insert_emoticon),
                          SizedBox(width: 10,),
                          Text("u_have_no_posts".tr()),
                        ],
                      ),),),
                    ):Container(),
                  ],
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                              defaultText:
                              FirebaseAuth.instance.currentUser!.displayName ?? "",
                              hint: "full_name".tr(),
                              isMultipleLine: false,
                              onChanged: (text) {
                                controller.fullName.value = text;
                                //controller.title.value = text;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            // margin:
                            // EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: black4,
                              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'user_id'.tr(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius:
                                      BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                                    ),
                                    child: FittedBox(
                                      child: Text(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        textAlign: TextAlign.center,

                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => ElevatedButton(
                              onPressed: controller.fullName.value != ""
                                  ? () async {
                                      controller.saveFullName();
                                    }
                                  : null,
                              child: Container(
                                  padding: EdgeInsets.all(15),
                                  //width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "save".tr(),
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15.sp),
                                  )),
                              style: ElevatedButton.styleFrom(
                                //padding: EdgeInsets.all(20),

                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                                ),
                                shadowColor: Colors.transparent,
                                //side: BorderSide(width: 1, color: Colors.green),
                                primary: green2,
                                // <-- Button color
                                onPrimary: Colors.white, // <-- Splash color
                              ),
                            ),
                          ),


                        ]),
                  ),
                  TextButton(onPressed: (){
                    controller.signOut();
                  }, child: Text(
                    "sign_out".tr(),
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height: 15,)
                ],
              ),
            ]),
          )),
    );
  }
}
