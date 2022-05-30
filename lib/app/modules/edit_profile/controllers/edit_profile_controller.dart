import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final fullName = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> saveFullName()async {

    //FirebaseAuth.instance.currentUser!.displayName = fullName.value;
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomLoaderDialog();
        // return CustomComfirmationDialog(
        //   onCancel: () {},
        //   onConfirm: () {},
        //   text: "test",
        // );
      },
    );
    await FirebaseAuth.instance.currentUser!.updateDisplayName(fullName.value).then((value) {
      Get.back();
      Get.back();
      Get.snackbar(
        "info".tr(),
        "succ_updated".tr(),
        colorText: Colors.white,
        margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
        progressIndicatorBackgroundColor: Colors.green,
        barBlur: 0,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(milliseconds: 2500),
        //instantInit: true,
        //shouldIconPulse: true,
        animationDuration: Duration(milliseconds: 300),
        icon: Icon(
          Icons.done,
          color: Colors.green,
          size: 35,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: yellow1,
      );
    }).catchError((onError){
      Get.back();
      Get.snackbar(
        "error".tr(),
        "err_while_posting".tr(),
        colorText: Colors.white,
        margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
        barBlur: 0,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(milliseconds: 200),
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
    });
  }
}
