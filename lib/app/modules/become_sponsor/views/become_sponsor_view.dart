import 'dart:ui';

import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/custom_comfirmation_dialog.dart';
import 'package:dont_waste/app/widgets/custom_error_dialog.dart';
import 'package:dont_waste/app/widgets/custom_info_dialog.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/become_sponsor_controller.dart';

class BecomeSponsorView extends GetView<BecomeSponsorController> {
  @override
  Widget build(BuildContext context) {
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
                  Hero(
                    tag: 'assets/images/lunch.png',
                    child: Image.asset(
                      'assets/images/lunch.png',
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
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
                      tag: 'assets/images/lunch.pngchoice',
                      child: Text("Become a sponsor",
                          style: Theme.of(context).textTheme.bodyText1)),
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
                    hint: "Title",
                    isMultipleLine: false,
                    onChanged: (text) {
                      controller.title.value = text;
                    }),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    hint: "Description",
                    isMultipleLine: true,
                    onChanged: (text) {
                      controller.description.value = text;
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                          hint: "Qantity",
                          isMultipleLine: false,
                          onChanged: (text) {
                            if (text.isNumericOnly) {
                              controller.quantity.value = double.parse(text);
                            } else {
                              Get.snackbar(
                                  "Error", "Quantity should be number");
                            }
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomTextField(
                          hint: "Price",
                          isMultipleLine: false,
                          onChanged: (text) {
                            if (text.isNumericOnly) {
                              controller.price.value = double.parse(text);
                            } else {
                              Get.snackbar("Error", "Price should be number");
                            }
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Image",
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
                  onTap: (){
                    controller.pickImage();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    //Type TextField
                    width: double.infinity,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: black4,
                      borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Icon(!controller.didImageSelected.value?Icons.image:Icons.done, color: !controller.didImageSelected.value?yellow1:Colors.green,)),
                        SizedBox(width: 8,),
                        Obx( () =>
                           Text(!controller.didImageSelected.value?"Select image":"Image selected", style: TextStyle(
                            color: !controller.didImageSelected.value?yellow1:Colors.green,
                            fontSize: 14.sp,
                          ),)

                        )
                      ],
                    )
                  ),
                ),
                //image here
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Joylashuv",
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
                      Get.snackbar("Error",
                          "Location permission is denied. Please allow location services for this app");
                      // We didn't ask for permission yet or the permission has been denied before but not permanently.
                    }

// You can can also directly ask the permission about its status.
                    if (await Permission.location.isRestricted) {
                      Get.snackbar("Error",
                          "Location permission is denied. Please allow location services for this app");
                      // The OS restricts access, for example because of parental controls.
                    }
                    //should show on map
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(
                                "Food location",
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
                                    child: LayoutBuilder(
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
                                    }),
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
                                              "Select",
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
                      child: Obx(
                        () => Stack(
                          fit: StackFit.expand,
                          children: [
                            LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Stack(
                                children: [
                                  GoogleMap(
                                    onMapCreated: (controller) {
                                      this
                                          .controller
                                          .controller
                                          .complete(controller);
                                    },
                                    zoomGesturesEnabled: false,
                                    rotateGesturesEnabled: false,
                                    scrollGesturesEnabled: false,
                                    mapType: MapType.normal,

                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(controller.latitude.value,
                                          controller.longitude.value),
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
                                        Get.snackbar("Error",
                                            "Location permission is denied. Please allow location services for this app");
                                        // We didn't ask for permission yet or the permission has been denied before but not permanently.
                                      }

// You can can also directly ask the permission about its status.
                                      if (await Permission
                                          .location.isRestricted) {
                                        Get.snackbar("Error",
                                            "Location permission is denied. Please allow location services for this app");
                                        // The OS restricts access, for example because of parental controls.
                                      }
                                      //should show on map
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                  "Food location",
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
                                                      child: LayoutBuilder(builder:
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
                                                      }),
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
                                                                "Select",
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
                            Visibility(
                              visible: !controller.isLocationSelected.value,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5.0,
                                  sigmaY: 5.0,
                                ),
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !controller.isLocationSelected.value,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Select location",
                                      style: TextStyle(color: Colors.black87)),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  defaultText: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                    hint: "Phone number",
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
                          controller.upload();
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
                            child: Text(
                              "Post",
                              style: TextStyle(fontSize: 15.sp),
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
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 15.sp),
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
