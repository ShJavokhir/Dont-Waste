import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/modules/update_food_preview/bindings/update_food_preview_binding.dart';
import 'package:dont_waste/app/modules/update_food_preview/controllers/update_food_preview_controller.dart';
import 'package:dont_waste/app/widgets/custom_info_dialog.dart';
import 'package:dont_waste/app/widgets/divider.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:dont_waste/app/widgets/single_food_order_for_admin.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dont_waste/app/modules/frame/views/frame_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.initialIndex,
      length: 2,
      child: Scaffold(

          backgroundColor: Colors.white,
          bottomSheet: TabBar(

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
                        padding: EdgeInsets.only(bottom: 5),
                        child: SingleFoodOrderForAdmin(
                          id: e.id,
                          onTop: (){
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
                                              Text("ad_fee".tr(), textAlign: TextAlign.center, style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),),
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
                                                    Text("Pay using Payme app"),
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
                                                      Text("Pay using Apelsin app"),
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
                    SizedBox(height: 70,)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [

                            SizedBox(
                              height: 20,
                            ),

                            Container(

                              width: double.infinity,
                              child: ListTile(
                                leading: Text("language".tr(),style: Theme.of(context).textTheme.titleMedium),
                                title: DropdownButton<String>(
                                  underline: Container(),
                                  value: context.locale.countryCode,
                                  selectedItemBuilder: (_) {
                                    return  <String>['EN', 'RU', 'UZ'].map((String choice) {
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(width: 10,),
                                            Image.asset('assets/images/$choice.png', height: 30, width: 30,),
                                            SizedBox(width: 15,),
                                            Text(choice),
                                            SizedBox(width: 15,),
                                          ],
                                        ),
                                      );
                                    }).toList();
                                  },
                                  items: <String>['EN', 'RU', 'UZ'].map((String choice) {
                                    return DropdownMenuItem<String>(
                                      value: choice,
                                      child: Row(
                                        children: [
                                          Image.asset('assets/images/$choice.png', height: 30, width: 30,),
                                          SizedBox(width: 15,),
                                          Text(choice)
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (opt) {

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

                                  },
                                ),
                              ),
                            ),

                            Divider(),
                            SizedBox(height: 10,),
                            CustomTextField(
                                defaultText:
                                FirebaseAuth.instance.currentUser!=null?FirebaseAuth.instance.currentUser!.displayName ?? "":"null",
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
                                          FirebaseAuth.instance.currentUser!=null?FirebaseAuth.instance.currentUser!.uid:"null",
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

                            SizedBox(height: 20,),
                            TextButton(onPressed: (){
                              controller.signOut();
                            }, child: Text(
                              "sign_out".tr(),
                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                            )),


                          ]),
                    ),

                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
