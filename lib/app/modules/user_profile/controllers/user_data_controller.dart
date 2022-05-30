import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/data/models/user_model.dart';
import 'package:dont_waste/app/modules/frame/controllers/frame_controller.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dont_waste/app/widgets/custom_comfirmation_dialog.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataController extends GetxController {
  late final FirebaseFirestore firestore;
  UserModel userModel = UserModel();

  @override
  void onInit()async {
    firestore = FirebaseFirestore.instance;
    fetchUserData();

    super.onInit();
  }

  @override
  void onReady() async{
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> fetchUserData()async{
    if(FirebaseAuth.instance.currentUser == null) return;
    final userData = await firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(userData.data() != null){
      userModel = UserModel.fromJson(userData.data()!);
      print("FCM token" + (userModel.fcmToken ?? ""));
    }else{
      showErrorSnackbar("Could not fetch user data");
    }
  }



}
