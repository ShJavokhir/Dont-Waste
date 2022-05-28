import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/models/notification_model.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final isLoading = true.obs;
  late FirebaseFirestore firestore;
  final notifications = <Notification>[].obs;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async{
    print("came?");
    firestore = FirebaseFirestore.instance;
    isLoading.value = true;
    try{
      notifications.value = await fetchNotifications();
    }catch(err){
      showErrorSnackbar(err.toString());
    }
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {}

  Future<List<Notification>> fetchNotifications() async {

    final List<Notification> notifications = [];
    await firestore.collection("notifications").orderBy('postedTimestamp', descending: true).get().then((value) {
      //print(value.size);
      value.docs.forEach((element) {
        final food = Notification.fromJson(element.data());
        notifications.add(food);
      });
    });
    return notifications;
  }
}
