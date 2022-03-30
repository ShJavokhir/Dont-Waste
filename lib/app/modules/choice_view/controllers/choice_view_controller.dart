import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoiceViewController extends GetxController {
  //TODO: Implement ChoiceViewController

  final count = 0.obs;
  @override
  void onInit() async{

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
