import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      // signed in
      Get.offAndToNamed("/choice-view");
    } else {
      print("Not signed in yet");
    }
    await auth.verifyPhoneNumber(
      timeout: Duration(seconds: 90),
      phoneNumber: phoneNumber.value,
      verificationCompleted: (PhoneAuthCredential credential) async {
        Get.snackbar("Info", "Succesfully authenticated");
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Error", "Verification failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.snackbar("Info", "Verification code has succesfully sent");
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
                        Text("Please enter verificatoin code sent to your phone number", textAlign: TextAlign.center,),
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

                              hintText: 'Verification code',

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
                            await auth.signInWithCredential(credential);
                            if (auth.currentUser != null) {
                              // signed in
                              Get.offAndToNamed('/choice-view');
                              print("Signed in");
                            } else {
                              Get.snackbar("Error", "Unexpected error happened");
                            }

                            //controller.authenticate();
                            //Get.find()
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              //width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Verify",
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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Get.snackbar("Info", "Verification code timed out");
      },
    );
  }
}
