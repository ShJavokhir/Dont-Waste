import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AboutController extends GetxController {
  final totalUsers = 0.obs;
  final totalFoods = 0.obs;

  @override
  void onInit() {
    getStats();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  Future<void> getStats()async{
    final statistics = await FirebaseFirestore.instance.collection("app").doc("statistics").get();
    if(statistics != null){
      totalUsers.value = statistics.data()!['totalUsers'];
      totalFoods.value = statistics.data()!['totalPosts'];
    }
  }
}
