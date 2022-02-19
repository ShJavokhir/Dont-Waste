import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FoodMarketController extends GetxController {
  //TODO: Implement FoodMarketController

  final count = 0.obs;
  late FirebaseFirestore firestore;

  @override
  void onInit() {
    print("hello");
    firestore = FirebaseFirestore.instance;
    // firestore.collection("test").doc("test").set({
    //   "test": "test",
    // });
    print("hello");
    firestore
        .collection("posts")
        .doc("rsJ2ZXEUR4zpaVmyOzXR")
        .get()
        .then((value) {
      //if(value.data() != null)
      Food food = Food.fromJson(value.data()!);
      print(food.phone_number);
      //print((value["location"] as GeoPoint));
      //print(value["location"]);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
