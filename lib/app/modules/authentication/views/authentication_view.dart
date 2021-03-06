import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart' hide Trans;

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false
      resizeToAvoidBottomInset:true,
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: Colors.white,
          //automaticallyImplyLeading: false,
          title: Text("authentication".tr(),
              style: Theme.of(context).textTheme.bodyText1),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 40),
          child: Column(

              children: [
            CustomTextField(
              textInputType: TextInputType.phone,
              hint: "phone_number".tr(),
              onChanged: (phoneNumber) {
                controller.phoneNumber.value = phoneNumber;
              },
              defaultText: "+998",
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                controller.authenticate();
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  //width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "continue".tr(),
                    style: TextStyle(fontSize: 15.sp),
                  )),
              style: ElevatedButton.styleFrom(
                //padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                ),
                //side: BorderSide(width: 1, color: Colors.green),
                primary: yellow1, // <-- Button color
                onPrimary: Colors.white, // <-- Splash color
              ),
            ),
          ]),
        ));
  }
}
