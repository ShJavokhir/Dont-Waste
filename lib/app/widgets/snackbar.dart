import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

void showErrorSnackbar(String errorMsg, {int timeout: 2500}){
  Get.snackbar(
    "error".tr(),
    errorMsg,
    colorText: Colors.white,
    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),

    barBlur: 0,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(milliseconds: timeout),

    //instantInit: true,
    //shouldIconPulse: true,
    animationDuration: Duration(milliseconds: 300),
    icon: Icon(
      Icons.cancel,
      color: Colors.white,
      size: 35,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
  );
}

void showSuccessSnackbar(String successMsg,{int timeout=2500}){
  Get.snackbar(
    "info".tr(),
    successMsg,
    colorText: Colors.white,
    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),

    barBlur: 0,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(milliseconds: timeout),

    //instantInit: true,
    //shouldIconPulse: true,
    animationDuration: Duration(milliseconds: 300),
    icon: Icon(
      Icons.done,
      color: Colors.white,
      size: 35,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: yellow1,
  );
}

void showInfoSnackbar(String successMsg,{int timeout=2500}){
  Get.snackbar(
    "info".tr(),
    successMsg,
    boxShadows: <BoxShadow>[

      new BoxShadow(
        color: Colors.black26,
        blurRadius: 2.0,
        offset: new Offset(0.0, 1),
      ),
    ],
    colorText: Colors.black87,
    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),

    barBlur: 0,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(milliseconds: timeout),

    //instantInit: true,
    //shouldIconPulse: true,
    animationDuration: Duration(milliseconds: 300),
    icon: Icon(
      Icons.info_rounded,
      color: Colors.black87,
      size: 35,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
  );
}

void showNotificationSnackbar(String title, String description,{int timeout=2500}) {
  Get.snackbar(
    title,
    description,
    onTap: (sn) {
      Get.toNamed('/notifications');
    },
    isDismissible: true,


    boxShadows: <BoxShadow>[

      new BoxShadow(
        color: Colors.black26,
        blurRadius: 2.0,
        offset: new Offset(0.0, 1),
      ),
    ],
    colorText: Colors.black87,
    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),

    barBlur: 0,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(milliseconds: timeout),

    //instantInit: true,
    //shouldIconPulse: true,
    animationDuration: Duration(milliseconds: 300),
    icon: Icon(
      Icons.info_rounded,
      color: Colors.black87,
      size: 35,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
  );
}