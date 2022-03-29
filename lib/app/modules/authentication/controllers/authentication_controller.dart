import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:sizer/sizer.dart';

class AuthenticationController extends GetxController {
  //TODO: Implement AuthenticationController

  final phoneNumber = "".obs;
  final verificationCode = "".obs;

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

  Future<void> authenticate() async {
    if(phoneNumber.value == ""){
      showErrorSnackbar("write_phone_number".tr());
      return;
    }
    if(!phoneNumber.value.contains("+")){
      showErrorSnackbar("start_with_plus".tr());
      return;
    }




    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      // signed in
      Get.offAndToNamed("/choice-view");
    } else {
      print("Not signed in yet");
    }
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
    await auth.verifyPhoneNumber(
      timeout: Duration(seconds: 90),
      phoneNumber: phoneNumber.value,

      verificationCompleted: (PhoneAuthCredential credential) async {
        print("verification completed");
        Get.offAllNamed('/choice-view');

        Get.snackbar(
          "into".tr(),
          "succ_auth".tr(),
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
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.back();

        showErrorSnackbar("verification_failed".tr() +  " : " + e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.back();

        showModalBottomSheet(
            isDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(36),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            context: Get.context!,
            builder: (builder) {
              return Container(
                height: 350.0,
                color: Colors.transparent, //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: Container(
                    padding: EdgeInsets.all(30),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0))),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("enter_otp".tr(), textAlign: TextAlign.center,),
                        SizedBox(height: 30,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          //Type TextField
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: black4,
                            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            //maxLength: 6,
                            //autofocus: true,
                            onChanged: (text){
                              verificationCode.value = text;
                            },
                            decoration: InputDecoration(

                              hintText: 'ver_code'.tr(),

                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: ()async {
                            // Create a PhoneAuthCredential with the code
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: verificationCode.value);

                            // Sign the user in (or link) with the credential
                            try{
                              await auth.signInWithCredential(credential);
                            }catch(err){
                              showErrorSnackbar(err.toString(), timeout: 4500);
                              return;
                            }

                            if (auth.currentUser != null) {
                              // signed in
                              Get.offAndToNamed('/choice-view');
                              print("Signed in");
                            } else {
                              showErrorSnackbar("unexpected_err".tr());
                            }

                            //controller.authenticate();
                            //Get.find()
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              //width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "verify".tr(),
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
                      ],
                    )
                ),
              );
            });
        Get.snackbar(
          "info".tr(),
          "code_sent_succ".tr(),
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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Get.snackbar("info".tr(), "otp_timed_out".tr());
      },
    );
  }
}
