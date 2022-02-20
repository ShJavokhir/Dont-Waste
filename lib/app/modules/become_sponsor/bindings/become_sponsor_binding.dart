import 'package:get/get.dart';

import '../controllers/become_sponsor_controller.dart';

class BecomeSponsorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      BecomeSponsorController(),
    );
  }
}
