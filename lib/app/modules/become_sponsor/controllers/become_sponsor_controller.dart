import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final food = Food();
    food.title = title.value;
    food.description = description.value;
    food.location = GeoPoint(latitude.value, longitude.value);
    food.phone_number = phoneNumber.value;
    food.price = price.value;
    food.quantity = quantity.value;
    food.views = 0;
    food.photo_url = "https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg";
    //final coordinates = Coordinates(latitude.value, longitude.value);
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude.value, longitude.value);

    //final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //final first = addresses.first;
    food.city = placemarks[0].country;
    //print(placemarks[0].country);
    //print(placemarks[1].);
    final firestore = FirebaseFirestore.instance;
    firestore.collection("posts").add(food.toJson());
    
  }

}
