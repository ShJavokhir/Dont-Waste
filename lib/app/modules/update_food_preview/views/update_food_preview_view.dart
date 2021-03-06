import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

import 'package:dont_waste/app/core/utils/map_utility.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/update_food_preview/controllers/update_food_preview_controller.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;

import 'package:url_launcher/url_launcher.dart';

class UpdateFoodPreviewView extends GetView<UpdateFoodPreviewController> {
  @override
  Widget build(BuildContext context) {

    print("Here debug msg in build: "+ controller.isEatable.value.toString());
    //controller.increment();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.4,
          //automaticallyImplyLeading: false,
          title: Container(
            child: Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("update_post".tr(),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    defaultText: controller.oldFood.title!,
                    hint: "title".tr(),
                    isMultipleLine: false,
                    onChanged: (text) {
                      controller.title.value = text;
                    }),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  defaultText: controller.oldFood.description!,
                    hint: "description".tr(),
                    isMultipleLine: true,
                    onChanged: (text) {
                      controller.description.value = text;
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
                      Text(
                        "is_donation".tr(),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Spacer(),
                      Container(
                        //padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          height: double.infinity,
                          //width: 150,
                          child: Obx(
                                ()=> CupertinoSwitch(
                              onChanged: (value){
                                controller.isDonation.value = value;
                              },
                              value: controller.isDonation.value,
                                  
                              activeColor: yellow1,
                              //activeTrackColor: Colors.yellow,
                              //inactiveThumbColor: Colors.redAccent,
                              //inactiveTrackColor: Colors.orange,
                            ),
                          )
                      )
                    ],
                  ),
                ),
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
                      Text(
                        "is_eatable".tr(),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Spacer(),
                      Container(
                        //padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          height: double.infinity,
                          //width: 150,
                          child: Obx(
                                ()=> CupertinoSwitch(
                              onChanged: (value){
                                controller.isEatable.value = value;
                              },
                              value: controller.isEatable.value,

                              activeColor: yellow1,
                              //activeTrackColor: Colors.yellow,
                              //inactiveThumbColor: Colors.redAccent,
                              //inactiveTrackColor: Colors.orange,
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        textInputType: TextInputType.number,
                        defaultText: controller.oldFood.quantity!.toString(),
                          hint: "quantity".tr(),
                          isMultipleLine: false,
                          onChanged: (text) {
                            if (text.isNumericOnly) {
                              controller.quantity.value = double.parse(text);
                            } else {
                              // Get.snackbar(
                              //     "error".tr(), "qnt_shoud_be_number".tr());
                            }
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=> Visibility(
                        visible: !controller.isDonation.value,
                        child: Flexible(
                          child: CustomTextField(
                              textInputType: TextInputType.number,
                              hint: "price".tr(),
                              isMultipleLine: false,
                              onChanged: (text) {
                                if (text.isNumericOnly) {
                                  controller.price.value = double.parse(text);
                                } else {
                                  Get.snackbar("error".tr(), "prc_should_be_number".tr());
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                ),

                //image here
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "location".tr(),
                    //controller.longitude.value.toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    var status = await Permission.locationWhenInUse.status;
                    await Permission.locationWhenInUse.request();
                    if (status.isDenied) {
                      Get.snackbar("error".tr(),
                          "location_perm_denied".tr());
                      // We didn't ask for permission yet or the permission has been denied before but not permanently.
                    }

// You can can also directly ask the permission about its status.
                    if (await Permission.location.isRestricted) {
                      Get.snackbar("error".tr(),
                          "location_perm_denied".tr());
                      // The OS restricts access, for example because of parental controls.
                    }
                    //should show on map
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(
                                "location".tr(),
                                style: TextStyle(fontSize: 18.sp),
                                textAlign: TextAlign.center,
                              ),
                              insetPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.all(15),
                              actionsPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(BORDER_RADIUS_1 * 1.0))),
                              content: Builder(
                                builder: (context) {
                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                  var height =
                                      MediaQuery.of(context).size.height;
                                  var width = MediaQuery.of(context).size.width;

                                  return Container(
                                    //padding: EdgeInsets.all(50),
                                    //height: 50.h,
                                    width: 85.w,
                                    height: 40.h,
                                    child: Expanded(child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          return Stack(
                                              alignment: Alignment(0.0, 0.0),
                                              children: <Widget>[
                                                Container(
                                                    padding: EdgeInsets.all(15),
                                                    width: double.infinity,
                                                    //height: 100,
                                                    decoration: BoxDecoration(
                                                      color: black4,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          BORDER_RADIUS_1 *
                                                              1.0),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          BORDER_RADIUS_1 *
                                                              1.0),
                                                      child: GoogleMap(
                                                        myLocationButtonEnabled:
                                                        true,
                                                        myLocationEnabled: true,
                                                        onCameraMove:
                                                            (onCameraMove) {
                                                          print("hello 1");
                                                          //print("moved 22");
                                                          controller
                                                              .longitude.value =
                                                              onCameraMove
                                                                  .target.longitude;
                                                          controller
                                                              .latitude.value =
                                                              onCameraMove
                                                                  .target.latitude;
                                                          // print(onCameraMove.target.latitude.toString());
                                                          // print(onCameraMove.target.longitude.toString());
                                                        },
                                                        initialCameraPosition:
                                                        CameraPosition(
                                                          target: LatLng(
                                                              controller
                                                                  .latitude.value,
                                                              controller
                                                                  .longitude.value),
                                                          zoom: 13.0,
                                                        ),
                                                      ),
                                                    )),
                                                Positioned(
                                                  top: (constraints.maxHeight -
                                                      25.sp) /
                                                      2,
                                                  right: (constraints.maxWidth -
                                                      25.sp) /
                                                      2,
                                                  child: Icon(
                                                    Icons.person_pin_circle,
                                                    size: 25.sp,
                                                    color: yellow1,
                                                  ),
                                                )
                                              ]);
                                        })),
                                  );
                                },
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.isLocationSelected.value =
                                          true;
                                          controller.moveCamera();
                                          //print(controller.longitude.value.toString());
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(15),
                                            //width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "select".tr(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15.sp),
                                            )),
                                        style: ElevatedButton.styleFrom(
                                          //padding: EdgeInsets.all(20),

                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                BORDER_RADIUS_1 * 1.0),
                                          ),
                                          shadowColor: Colors.transparent,
                                          //side: BorderSide(width: 1, color: Colors.green),
                                          primary: green2,
                                          // <-- Button color
                                          onPrimary:
                                          Colors.white, // <-- Splash color
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]);
                        });
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      //color: yellow1,
                        border: Border.all(color: black4),
                        borderRadius: BorderRadius.circular(24)),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                      child: Stack(
                          fit: StackFit.expand,
                          children: [
                      LayoutBuilder(builder: (BuildContext context,
                          BoxConstraints constraints) {
                        return Stack(
                          children: [
                            GoogleMap(
                              onMapCreated: (controller) {
                                // this
                                //     .controller
                                //     .controller
                                //     .complete(controller);
                              },
                              zoomGesturesEnabled: false,
                              rotateGesturesEnabled: false,
                              scrollGesturesEnabled: false,
                              mapType: MapType.normal,

                              initialCameraPosition: CameraPosition(
                                target: LatLng(controller.oldFood.location!.latitude,
                                    controller.oldFood.location!.longitude),
                                zoom: 13.0,
                              ),
                              //compassEnabled: false,
                              // indoorViewEnabled: true,
                              zoomControlsEnabled: false,
                              //liteModeEnabled: true,
                              onTap: (LatLang) async {
                                var status = await Permission
                                    .locationWhenInUse.status;
                                await Permission.locationWhenInUse
                                    .request();
                                if (status.isDenied) {
                                  Get.snackbar("error".tr(),
                                      "location_perm_denied".tr());
                                  // We didn't ask for permission yet or the permission has been denied before but not permanently.
                                }

// You can can also directly ask the permission about its status.
                                if (await Permission
                                    .location.isRestricted) {
                                  Get.snackbar("error".tr(),
                                      "location_perm_denied".tr());
                                  // The OS restricts access, for example because of parental controls.
                                }
                                //should show on map
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text(
                                            "location".tr(),
                                            style: TextStyle(
                                                fontSize: 18.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                          insetPadding: EdgeInsets.zero,
                                          contentPadding:
                                          EdgeInsets.all(15),
                                          actionsPadding:
                                          EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 5),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .all(Radius.circular(
                                                  BORDER_RADIUS_1 *
                                                      1.0))),
                                          content: Builder(
                                            builder: (context) {
                                              // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                              var height =
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height;
                                              var width =
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width;

                                              return Container(
                                                //padding: EdgeInsets.all(50),
                                                //height: 50.h,
                                                width: 85.w,
                                                height: 40.h,
                                                child: Expanded(child:
                                                LayoutBuilder(builder:
                                                    (BuildContext
                                                context,
                                                    BoxConstraints
                                                    constraints) {
                                                  return Stack(
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                      children: <Widget>[
                                                        Container(
                                                            padding:
                                                            EdgeInsets
                                                                .all(
                                                                15),
                                                            width: double
                                                                .infinity,
                                                            //height: 100,
                                                            decoration:
                                                            BoxDecoration(
                                                              color:
                                                              black4,
                                                              borderRadius:
                                                              BorderRadius.circular(BORDER_RADIUS_1 *
                                                                  1.0),
                                                            ),
                                                            child:
                                                            ClipRRect(
                                                              borderRadius:
                                                              BorderRadius.circular(BORDER_RADIUS_1 *
                                                                  1.0),
                                                              child:
                                                              GoogleMap(
                                                                myLocationButtonEnabled:
                                                                true,
                                                                myLocationEnabled:
                                                                true,
                                                                onCameraMove:
                                                                    (onCameraMove) {
                                                                  print(
                                                                      "hello 2");
                                                                  controller
                                                                      .longitude
                                                                      .value = onCameraMove.target.longitude;
                                                                  controller
                                                                      .latitude
                                                                      .value = onCameraMove.target.latitude;

                                                                  print(onCameraMove
                                                                      .target
                                                                      .latitude
                                                                      .toString());
                                                                  // print(onCameraMove.target.longitude.toString());
                                                                },
                                                                initialCameraPosition:
                                                                CameraPosition(
                                                                  target: LatLng(
                                                                      controller.latitude.value,
                                                                      controller.longitude.value),
                                                                  zoom:
                                                                  13.0,
                                                                ),
                                                              ),
                                                            )),
                                                        Positioned(
                                                          top: (constraints
                                                              .maxHeight -
                                                              25.sp) /
                                                              2,
                                                          right: (constraints
                                                              .maxWidth -
                                                              25.sp) /
                                                              2,
                                                          child: Icon(
                                                            Icons
                                                                .person_pin_circle,
                                                            size: 25.sp,
                                                            color:
                                                            yellow1,
                                                          ),
                                                        )
                                                      ]);
                                                })),
                                              );
                                            },
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .moveCamera();
                                                      controller
                                                          .isLocationSelected
                                                          .value = true;

                                                      //print(controller.longitude.value.toString());
                                                      Navigator.of(
                                                          context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                        padding:
                                                        EdgeInsets
                                                            .all(15),
                                                        //width: double.infinity,
                                                        alignment:
                                                        Alignment
                                                            .center,
                                                        child: Text(
                                                          "select".tr(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize:
                                                              15.sp),
                                                        )),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      //padding: EdgeInsets.all(20),

                                                      elevation: 0,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            BORDER_RADIUS_1 *
                                                                1.0),
                                                      ),
                                                      shadowColor: Colors
                                                          .transparent,
                                                      //side: BorderSide(width: 1, color: Colors.green),
                                                      primary: green2,
                                                      // <-- Button color
                                                      onPrimary: Colors
                                                          .white, // <-- Splash color
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]);
                                    });
                              },
                              //myLocationButtonEnabled: true,
                              //myLocationEnabled: true,
                              //liteModeEnabled: true,
                            ),
                            Positioned(
                                top: (constraints.maxHeight - 25.sp) / 2,
                                right: (constraints.maxWidth - 25.sp) / 2,
                                child: Container(
                                  width: 25.sp,
                                  height: 25.sp,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.red, width: 3)),
                                ))
                          ],
                        );
                      }),
                      // Visibility(
                      //   visible: !controller.isLocationSelected.value,
                      //   child: BackdropFilter(
                      //     filter: ImageFilter.blur(
                      //       sigmaX: 5.0,
                      //       sigmaY: 5.0,
                      //     ),
                      //     child: Container(
                      //       color: Colors.transparent,
                      //     ),
                      //   ),
                      // ),
                      // Visibility(
                      //   visible: !controller.isLocationSelected.value,
                      //   child: Center(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(Icons.location_on),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //           Text("Select new location",
                      //               style: TextStyle(color: Colors.black87)),
                      //         ],
                      //       )),
                      // ),
                          ],
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    textInputType: TextInputType.phone,
                    defaultText: controller.oldFood.phone_number!,
                    hint: "phone_number".tr(),
                    isMultipleLine: false,
                    onChanged: (text) {
                      controller.phoneNumber.value = text;
                    }),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updatePost();
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return CustomErrorDialog(
                          //         text:
                          //             "salom slaom salomsalom slaom salomsalom slaom salomsalom slaom salomsalom slaom salom");
                          //   },
                          // );
                        },
                        child: Container(
                            padding: EdgeInsets.all(15),
                            //width: double.infinity,
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                "update_button".tr(),
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            )),
                        style: ElevatedButton.styleFrom(
                          //padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          //side: BorderSide(width: 1, color: Colors.green),
                          primary: blue1, // <-- Button color
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomLoaderDialog();
                              // return CustomComfirmationDialog(
                              //   onCancel: () {},
                              //   onConfirm: () {},
                              //   text: "test",
                              // );
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(15),
                            //width: double.infinity,
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                "cancel".tr(),
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            )),
                        style: ElevatedButton.styleFrom(
                          //padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          //side: BorderSide(width: 1, color: Colors.green),
                          primary: red1, // <-- Button color
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
