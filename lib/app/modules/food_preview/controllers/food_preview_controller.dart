import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FoodPreviewController extends GetxController {
  //TODO: Implement FoodPreviewController
  var foodModel = Food();
  final count = 0.obs;
  @override
  void onInit() {
    print("FoodPreview onInit called");

    print(foodModel.title);
    super.onInit();
  }

  @override
  void onReady() {
    print("FoodPreview onready called");
    incrementViews();
    super.onReady();
  }
  Future<void> incrementViews()async{
    await FirebaseFirestore.instance.collection("posts").doc(foodModel.id).update({"views": FieldValue.increment(1)});
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
