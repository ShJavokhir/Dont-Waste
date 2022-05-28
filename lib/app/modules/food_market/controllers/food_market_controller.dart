import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodMarketController extends GetxController {
  //TODO: Implement FoodMarketController
  ScrollController scrollController = ScrollController();

   final segmentedControlGroupValue = 0.obs;
  final count = 0.obs;
  late FirebaseFirestore firestore;
  final foods = <Food>[].obs;
   final isLoading = true.obs;

  @override
  void onInit() async {



    firestore = FirebaseFirestore.instance;

    //print("look " + foods.value[0].price.toString());
    super.onInit();
  }

  void scrollUp(){
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }



  @override
  void onReady() async{
    isLoading.value = true;
    try{
      await setFoodsWithoutLoader();
    }catch(err){
      showErrorSnackbar("Error while fetching foods from server");
    }
    isLoading.value = false;


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
  Future<void> setFoodsWithoutLoader() async{

    foods.value = await fetchFoods();

  }
  Future<void> switchMarket() async {
    foods.clear();
    isLoading.value = true;
    try{
      if(segmentedControlGroupValue.value == 0){
        foods.value = await fetchFoods();
      }else if(segmentedControlGroupValue.value == 1){
        foods.value = await fetchExpiredFoods();
      }
    }catch(err){

    }


    isLoading.value = false;

  }

  Future<List<Food>> fetchFoods() async {

     final List<Food> foods = [];
     await firestore.collection("posts").orderBy('postedTimestamp', descending: true).get().then((value) {
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

   Future<List<Food>> fetchExpiredFoods() async {

     final List<Food> foods = [];
     await firestore.collection("posts").where('isEatable', isEqualTo: false).orderBy('postedTimestamp', descending: true).get().then((value) {
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

   Future<void> fetchByCategory(String catName) async {
     foods.clear();
      isLoading.value = true;
      try{
        foods.value = await fetchCategory(catName);
      }catch(err){

      }
      isLoading.value = false;
   }

  Future<List<Food>> fetchCategory(String catName) async {
    if(catName == 'all') {
      return await fetchFoods();
    }else{
      final List<Food> foods = [];
      await firestore.collection("posts").where('category', isEqualTo: catName).orderBy('postedTimestamp', descending: true).get().then((value) {
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
}
