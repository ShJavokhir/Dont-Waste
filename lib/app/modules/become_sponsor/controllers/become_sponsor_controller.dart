import 'dart:async';
import 'dart:io';
import 'package:dont_waste/app/modules/frame/controllers/frame_controller.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BecomeSponsorController extends GetxController {
  //TODO: Implement BecomeSponsorController
  XFile? image;
  final didImageSelected = false.obs;
  final isDonation = false.obs;
  final isEatable = true.obs;
  final title = "".obs;
  final description = "".obs;
  final quantity = 0.0.obs;
  final price = 0.0.obs;
  final phoneNumber = "".obs;
  //41.338622, 69.334240
  final latitude = 41.338622.obs;
  final longitude = 69.334240.obs;
  final isLocationSelected = false.obs;
  final category = "all".obs;
  Completer<GoogleMapController> controller = Completer();

  @override
  void onInit() {
    print("came here");
    super.onInit();
  }

  @override
  void onReady() {
    print("on ready");

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

  Future<void> pickImage() async{
    print("Picking image");
    await ImagePicker().pickImage(
      imageQuality: 50,
        source: ImageSource.gallery).then((value) => {
          if(value != null){
            image = value,
            print("image picked"),
            didImageSelected.value = true
          }
    }).catchError((onError){
      Get.snackbar("Error", onError.toString());
    });
    print("image picking finished");

  }
  Future<void> upload() async {
    if(title.value == ""){
      showErrorSnackbar("Please write the title");
      return;
    }
    if(description.value == ""){
      showErrorSnackbar("Please write the description");
      return;
    }
    if(quantity.value == 0.0){
      showErrorSnackbar("Please write the quantity");
      return;
    }
    // if(quantity.value){
    //   showErrorSnackbar("Please write the quantity");
    //   return;
    // }

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
    var imageUrl = "no";
    if(image != null){

      //print(image.path);
      // print("Uploading image");
      // firebase_storage.UploadTask uploadTask;
      //
      // firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      //     .ref()
      //     .child('postImages')
      //     .child('/${Uuid().v4()}.jpg');
      //
      // final metadata = firebase_storage.SettableMetadata(
      //     contentType: 'image/jpeg',
      //     customMetadata: {'picked-file-path': image!.path});
      //
      // uploadTask = ref.putFile(File(image!.path), metadata);
      // await Future.value(uploadTask);

      firebase_storage.FirebaseStorage storage =
      await firebase_storage.FirebaseStorage.instance;
      print("Instance got");
      int ced = await image!.length();
      await firebase_storage.FirebaseStorage.instance
          .ref('postImages/${Uuid().v4()}.jpg')
          .putFile(File(image!.path))
          .then((p0) async {
           imageUrl = await p0.ref.getDownloadURL();
      });
      print("Image url: " + imageUrl);
      // StorageTaskSnapshot snapshot = await storage
      //     .ref()
      //     .child("admins/$adminId.png")
      //     .putFile(uiData.profileImage)
      //     .onComplete;
      // print("2");
    }

    final food = Food();
    food.title = title.value;
    food.description = description.value;
    food.location = GeoPoint(latitude.value, longitude.value);
    food.phone_number = phoneNumber.value==""?FirebaseAuth.instance.currentUser!.phoneNumber:phoneNumber.value;
    food.price = price.value;
    food.quantity = quantity.value;
    food.views = 0;
    food.isDonation = isDonation.value;
    food.category = category.value;
    food.isEatable = isEatable.value;
    food.ownerName = FirebaseAuth.instance.currentUser?.displayName;
    food.photo_url = imageUrl==""?null: imageUrl;
    //final coordinates = Coordinates(latitude.value, longitude.value);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude.value, longitude.value);

    //final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //final first = addresses.first;
    food.city = placemarks[0].country;
    food.postedTimestamp = DateTime.now().millisecondsSinceEpoch;
    food.userId = FirebaseAuth.instance.currentUser!.uid;
    //print(placemarks[0].country);
    //print(placemarks[1].);
    final firestore = FirebaseFirestore.instance;

    firestore.collection("posts").add(food.toJson()).then((value) async {
      Get.back();
      Get.find<FrameController>().changeTabIndex(0);
      Get.delete<BecomeSponsorController>();

      Get.snackbar(
        "info".tr(),
        "succ_posted".tr(),
        colorText: Colors.white,
        margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
        progressIndicatorBackgroundColor: Colors.green,
        barBlur: 0,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(milliseconds: 1350),

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
      FirebaseFirestore.instance.collection("app").doc("statistics").update({"totalPosts": FieldValue.increment(1)});
    }).catchError((onError) {
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
