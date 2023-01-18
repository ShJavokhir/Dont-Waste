import 'package:get/get.dart';

import '../controllers/donation_locations_controller.dart';

class DonationLocationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationLocationsController>(
      () => DonationLocationsController(),
    );
  }
}
