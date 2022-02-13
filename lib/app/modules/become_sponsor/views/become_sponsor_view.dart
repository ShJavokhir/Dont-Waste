import 'dart:ui';

import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/custom_comfirmation_dialog.dart';
import 'package:dont_waste/app/widgets/custom_error_dialog.dart';
import 'package:dont_waste/app/widgets/custom_info_dialog.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../controllers/become_sponsor_controller.dart';

class BecomeSponsorView extends GetView<BecomeSponsorController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Container(
            child: ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
            )),
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
                    hint: "Full Name",
                    isMultipleLine: false,
                    onChanged: (text) {
                      print(text);
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomErrorDialog(
                                  text:
                                      "salom slaom salomsalom slaom salomsalom slaom salomsalom slaom salomsalom slaom salom");
                            },
                          );
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
                            context: context,
                            builder: (BuildContext context) {
                              return CustomComfirmationDialog(
                                onCancel: () {},
                                onConfirm: () {},
                                text: "wtf are u doin here ?",
                              );
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
