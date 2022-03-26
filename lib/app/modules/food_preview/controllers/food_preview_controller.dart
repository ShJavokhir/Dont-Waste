import 'package:dont_waste/app/data/models/food_model.dart';
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
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
