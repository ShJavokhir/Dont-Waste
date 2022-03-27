import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackbar(String errorMsg, {int timeout: 2500}){
  Get.snackbar(
    "Error",
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
    "Info",
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
      Icons.cancel,
      color: red2,
      size: 35,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: yellow1,
  );
}