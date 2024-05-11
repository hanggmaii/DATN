import 'package:get/get.dart';

import 'heart_rate_controller.dart';

class HeartRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeartRateController>(() => HeartRateController());
  }
}
