import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BecomeSponsorController extends GetxController {
  //TODO: Implement BecomeSponsorController

  final title = "".obs;
  final description = "".obs;
  final quantity = 0.0.obs;
  final price = 0.0.obs;
  final phoneNumber = "".obs;
  //41.338622, 69.334240
  final latitude = 41.338622.obs;
  final longitude = 69.334240.obs;
  final isLocationSelected = false.obs;
  Completer<GoogleMapController> controller = Completer();

  @override
  void onInit() {
    print("came here");
    super.onInit();
  }

  @override
  void onReady() {
    print("on ready");
    final auth = FirebaseAuth.instance;
    //auth.signOut();
    if (auth.currentUser != null) {
      // signed in

      print("Signed");
    } else {
      print("Not signed in yet");
      Get.offAndToNamed("/authentication");
    }
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> moveCamera() async {
    final GoogleMapController controller = await this.controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude.value, longitude.value),
      zoom: 13,
    )));
  }

  Future<void> upload() async {
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
    final food = Food();
    food.title = title.value;
    food.description = description.value;
    food.location = GeoPoint(latitude.value, longitude.value);
    food.phone_number = phoneNumber.value;
    food.price = price.value;
    food.quantity = quantity.value;
    food.views = 0;
    food.photo_url =
        "https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg";
    //final coordinates = Coordinates(latitude.value, longitude.value);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude.value, longitude.value);

    //final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //final first = addresses.first;
    food.city = placemarks[0].country;
    //print(placemarks[0].country);
    //print(placemarks[1].);
    final firestore = FirebaseFirestore.instance;
    firestore.collection("posts").add(food.toJson()).then((value) async {
      Get.back();
      Get.back();
      Get.snackbar(
        "Info",
        "Successfully posted",
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
    }).catchError((onError) {
      Get.back();
      Get.snackbar(
        "Error",
        "Unexpected error while posting",
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
