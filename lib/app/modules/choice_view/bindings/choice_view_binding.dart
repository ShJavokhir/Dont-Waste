import 'package:get/get.dart';

import '../controllers/choice_view_controller.dart';

class ChoiceViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoiceViewController>(
      () => ChoiceViewController(),
    );
  }
}
