import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {

  final totalUsers = 0.obs;
  final totalFoods = 0.obs;
  final savedFoods = 0.obs;
  final totalCountries = 0.obs;
  final totalDonations = 0.obs;

  final isLoading = true.obs;
  @override
  void onInit() async{
    isLoading.value = true;
    getStats().then((value) {
      isLoading.value = false;
    }).catchError((err){
      showErrorSnackbar(err.toString());
      isLoading.value = false;
    });

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
      savedFoods.value = statistics.data()!['savedFoods'];
      totalCountries.value = statistics.data()!['totalCountries'];
      totalDonations.value = statistics.data()!['totalDonations'];

    }
  }
}
