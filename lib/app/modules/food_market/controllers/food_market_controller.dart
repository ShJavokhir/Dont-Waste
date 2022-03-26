import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodMarketController extends GetxController {
  //TODO: Implement FoodMarketController

  final count = 0.obs;
  late FirebaseFirestore firestore;
  final foods = <Food>[].obs;

  @override
  void onInit() async {
    print("hello");
    firestore = FirebaseFirestore.instance;

    //print("look " + foods.value[0].price.toString());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<void> setFoods() async{
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
    foods.value = await fetchFoods();
    Get.back();

  }

  Future<List<Food>> fetchFoods() async {

    final List<Food> foods = [];
    await firestore.collection("posts").get().then((value) {
      //print(value.size);
      value.docs.forEach((element) {
        final food = Food.fromJson(element.data());
        food.id = element.id;
        //print(food.id);
        foods.add(food);
      });
    });
    return foods;
  }
}
