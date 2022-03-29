import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/widgets/custom_error_dialog.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class NearbyFoodsController extends GetxController {

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  //TODO: Implement NearbyFoodsController
  GoogleMapController? controller;
  final geo = Geoflutterfire();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  final foods = <Food>[].obs;
  final count = 0.obs;
  //final Rx<Position?> usersLocation = Rx<Position?>(Position());
  Position? usersLocation;
  late FirebaseFirestore firestore;
  @override
  void onInit()async {
    firestore = FirebaseFirestore.instance;
    // showDialog(
    //   barrierDismissible: false,
    //   context: Get.context!,
    //   builder: (BuildContext context) {
    //     return CustomLoaderDialog();
    //     // return CustomComfirmationDialog(
    //     //   onCancel: () {},
    //     //   onConfirm: () {},
    //     //   text: "test",
    //     // );
    //   },
    // );
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) => {
      print("device location found"),
      usersLocation = value,


    }).catchError((error, stackTrace)  {
      print("device location error: " + error.toString() + " | " + stackTrace.toString());
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomErrorDialog(
          text: error.toString() + " Please try to turn on GPS and allow location permission for this app",
    );
          // return CustomComfirmationDialog(
          //   onCancel: () {},
          //   onConfirm: () {},
          //   text: "test",
          // );
        },
      ).then((value) => {
        Get.back()
      });
    });

    // Get.back();
    // Create a geoFirePoint
    // final center = GeoFirePoint(48.85806075757082,2.294355558423788);
     // CLASS MEMBER, MAP OF MARKS

// get the collection reference or query
    foods.value = await fetchFoods();
    // Create a geoFirePoint

    late BitmapDescriptor customIcon;

// make sure to initialize before map loading
    await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0.1, 0.1)), 'assets/images/food-delivery.png', )

        .then((onValue) {
      customIcon = onValue;
    });
    final Uint8List markerIcon = await getBytesFromAsset('assets/images/food-delivery.png', 150);

    //if(customIcon == null) return;
    foods.value.forEach((element) {
      //markers.addAll(other)
      Marker marker = Marker(
        markerId: MarkerId(element.id),
        position:LatLng(element.location!.latitude, element.location!.longitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: (){
            showModalBottomSheet(
                isDismissible: true,
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
                            Text("Food"),
                            SizedBox(height: 20,),
                            getSingleFoodOrderForId(element.id)

                          ],
                        )
                    ),
                  );
                });

        }
      );
      print("here is it");
      markers[MarkerId(element.id)] = marker;
    });
    // double radius = 50;
    // String field = 'position';
    //
    // Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef:
    // collectionReference).within(center: center, radius: radius, field: field);
    super.onInit();
  }

  @override
  void onReady() {
    controller!.moveCamera(CameraUpdate.newLatLng(LatLng(usersLocation!.latitude, usersLocation!.longitude)));
    super.onReady();
  }
  Future<List<Food>> fetchFoods() async {
    print("Fetch foods function");
    final List<Food> foods = [];

    GeoFirePoint center = geo.point(latitude: usersLocation!.latitude,longitude: usersLocation!.longitude);
    print("users location: " + usersLocation!.latitude.toString() + " " + usersLocation!.longitude.toString());
    // get the collection reference or query
    var collectionReference = FirebaseFirestore.instance.collection("posts");


    double radius = 10000;
    String field = 'location';

    Stream<List<DocumentSnapshot>> stream =  geo.collection(collectionRef:
    collectionReference).within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      print("listeningg " + documentList.length.toString());

      documentList.forEach((element) {
        print("yea boi");
      });
    });

    stream.forEach((element2) {
      print("Fetch foods function first loop");
      for (var element in element2) {
        print("Fetch foods function second loop");
        final food = Food.fromJson(element.data() as Map<String, dynamic>);
        food.id = element.id;
        print("Setting ids");
        print(food.id);
        //print(food.id);
        foods.add(food);
      }
    });
    // await firestore.collection("posts").get().then((value) {
    //   //print(value.size);
    //   value.docs.forEach((element) {
    //
    //   });
    // });
    return foods;
  }
  @override
  void onClose() {}
  void increment() => count.value++;
  Widget getSingleFoodOrderForId(String id){
    final food = getFoodById(id);
    return SingleFoodOrder(id: food.id, onPressed: (){
      FoodPreviewBinding().dependencies();
      Get.find<FoodPreviewController>().foodModel = food;
      Get.toNamed("/food-preview");
    }, title: food.title!, price: food.price!, location: food.city!, isDonation: food.isDonation ?? false, photo_url: food.photo_url ?? "no", postedTimestamp: food.postedTimestamp);
  }
  Food getFoodById(String id){

    for(int i=0;i<foods.value.length; i++){
      //print(foods.value[i].)
      if(foods.value[i].id == id) return foods.value[i];
    }
    print("Food not found getFoodById: " + id);
    return Food();
  }
}
