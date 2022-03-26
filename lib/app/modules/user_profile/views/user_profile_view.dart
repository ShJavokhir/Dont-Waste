import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/divider.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:dont_waste/app/widgets/single_food_order_for_admin.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

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
                Tab(text: "My Ads", icon: Icon(Icons.apps)),
                Tab(text: "Settings", icon: Icon(Icons.settings)),
                // Tab(text: "My Ads", ),
                // Tab(text: "Settings",),
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 0.4,
            //automaticallyImplyLeading: false,
            title: Text("Profile"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TabBarView(children: [
              ListView(
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
                        onEdit: () {},
                        onDelete: () {},
                        title: e.title ?? "null",
                        price: e.price ?? 0,
                        location: e.city ?? "Tashkent",
                        views: e.views ?? 0,
                        photo_url: e.photo_url,
                      ),
                    );
                  }).toList()
                ],
              ),
              ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        defaultText:
                            FirebaseAuth.instance.currentUser!.displayName!,
                        hint: "Full name",
                        isMultipleLine: false,
                        onChanged: (text) {
                          controller.fullName.value = text;
                          //controller.title.value = text;
                        }),
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
                              "Save",
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
            ]),
          )),
    );
  }
}
