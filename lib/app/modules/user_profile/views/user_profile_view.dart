import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/modules/frame/controllers/frame_controller.dart';
import 'package:dont_waste/app/modules/update_food_preview/bindings/update_food_preview_binding.dart';
import 'package:dont_waste/app/modules/update_food_preview/controllers/update_food_preview_controller.dart';
import 'package:dont_waste/app/widgets/custom_info_dialog.dart';
import 'package:dont_waste/app/widgets/divider.dart';
import 'package:dont_waste/app/widgets/profile_menu_button.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:dont_waste/app/widgets/single_food_order_for_admin.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dont_waste/app/modules/frame/views/frame_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //controller.foods.clear();
    return Scaffold(

        backgroundColor: Colors.white,

        // appBar: AppBar(
        //
        //   backgroundColor: Colors.white,
        //   elevation: 0.4,
        //   //automaticallyImplyLeading: false,
        //   title: Text("account".tr()),
        //   centerTitle: true,
        // ),
        body: Container(
          //padding: EdgeInsets.symmetric(horizontal: 18),
          child: Obx(
                () => ListView(
                  controller: scrollController,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [

                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  child: Container(child: Image.asset("assets/images/avatar.png"),decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[

                      new BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        offset: new Offset(0.0, 0.5),
                      ),
                    ],
                  ),),
                  //backgroundColor: Colors.blueGrey,
                  radius: 50,
                ),
                SizedBox(height: 15,),
                Text('welcome'.tr() + " " + (FirebaseAuth.instance.currentUser!.displayName ?? ""), textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black87
                ),),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(15),
                  //height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: black4,
                      borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("current_balance".tr(), style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54
                          ),),
                          SizedBox(height: 10,),
                          Text("125000 uzs", style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),textAlign: TextAlign.left,),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          //customBorder: new CircleBorder(),
                          onTap: () {},
                          splashColor: Colors.white,
                          child: new Icon(
                            Icons.add_box_rounded,
                            size: 35.sp,
                            color: Colors.black87,
                          ),
                        ),
                      )
                      // IconButton(
                      //   hoverColor: Colors.black87,
                      //   splashColor: Colors.white,
                      //   icon: Icon(Icons.add_box_rounded), color: yellow1,onPressed: (){}, iconSize: 35.sp, enableFeedback: true,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                  child: Text("features".tr(), style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    children: [
                      SizedBox(width: DEFAULT_PADDING * 1.0,),
                      ProfileMenuButton(title: "add_post_button".tr(), onTap: (){
                        Get.find<FrameController>().changeTabIndex(1);
                      }, iconData: Icons.add_a_photo_rounded),
                      SizedBox(width: 10,),
                      ProfileMenuButton(title: "deposit".tr(), onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) =>
                            //CustomInfoDialog(text: "This feature is cooming soon, be prepared :).\n With the help of this function, you can advertise your foods so many people can discover it")
                            AlertDialog(
                              title: Text(
                                "payment_method".tr(),
                                style: TextStyle(fontSize: 18.sp),
                                textAlign: TextAlign.center,
                              ),
                              insetPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.all(15),
                              actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(BORDER_RADIUS_1 * 1.0))),
                              content: Builder(
                                builder: (context) {
                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                  var height = MediaQuery.of(context).size.height;
                                  var width = MediaQuery.of(context).size.width;

                                  return GestureDetector(
                                    onTap: (){
                                      Get.back();
                                      showDialog(context: context,
                                          builder: (ctx) =>
                                              CustomInfoDialog(text: "payment_info".tr())
                                      );
                                    },
                                    child: Container(
                                      //padding: EdgeInsets.all(50),
                                      //height: 50.h,
                                      width: 85.w,
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Text("ad_fee".tr(), textAlign: TextAlign.center, style: TextStyle(
                                          //     fontWeight: FontWeight.bold
                                          // ),),
                                          Container(
                                            // margin: EdgeInsets.all(15),
                                            width: double.infinity,
                                            //height: 100,
                                            decoration: BoxDecoration(
                                              color: black4,
                                              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: 15,),
                                                Image.asset('assets/images/payme.png', height: 100, width: 100),
                                                Text("pay_using_payme".tr()),
                                                SizedBox(width: 15,),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.all(15),
                                            width: double.infinity,
                                            //height: 100,
                                            decoration: BoxDecoration(
                                              color: black4,
                                              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: 15,),
                                                Image.asset('assets/images/click.png', height: 100, width: 100),
                                                Text("pay_using_apelsin".tr()),
                                                SizedBox(width: 15,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                        );
                      }, iconData: Icons.monetization_on_rounded),
                      SizedBox(width: 10,),
                      ProfileMenuButton(title: "advertise".tr(), onTap: (){
                        showInfoSnackbar("Please select post you want to advertise");
                        scrollController.animateTo(
                          400,
                          duration: Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                        );

                      }, iconData: Icons.star_rate_rounded ),
                      SizedBox(width: 10,),
                      ProfileMenuButton(title: "settings".tr(), onTap: (){
                        Get.find<FrameController>().changeTabIndex(4);
                      }, iconData: Icons.settings),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                  child: Text("list_of_your_foods".tr(), style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
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
                ...controller.foods.value.map((e) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5, right: DEFAULT_PADDING * 1.0 /3,left: DEFAULT_PADDING * 1.0 / 3),
                    child: SingleFoodOrderForAdmin(
                      id: e.id,
                      isEatable: e.isEatable ?? true,
                      isTop: e.isTop ?? false,
                      onTop: (){

                      },
                      onView: (){
                        FoodPreviewBinding().dependencies();
                        Get.find<FoodPreviewController>().foodModel = e;
                        Get.toNamed("/food-preview");
                      },
                      onEdit: ()async {
                        print("isDonation before edit: ${e.isDonation} ${e.id}");
                        UpdateFoodPreviewBinding().dependencies();
                        Get.find<UpdateFoodPreviewController>().oldFood = e;
                        Get.find<UpdateFoodPreviewController>().isDonation.value = e.isDonation ?? false;
                        Get.find<UpdateFoodPreviewController>().isEatable.value = e.isEatable ?? true;
                        await Get.toNamed("/update-food-preview");
                        Get.delete<UpdateFoodPreviewController>();
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
                      photoUrl: e.photo_url ?? "no",
                    ),
                  );
                }).toList(),
                controller.foods.value.length == 0 && !controller.isLoading.value?Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                  child: Container(child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(Icons.insert_emoticon),
                      SizedBox(width: 10,),
                      Text("u_have_no_posts".tr()),
                    ],

                  ),),),
                ):Container(),
                SizedBox(height: 70,)
              ],
            ),
          ),
        ));
  }
}
