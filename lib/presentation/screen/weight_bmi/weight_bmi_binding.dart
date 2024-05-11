import 'package:get/get.dart';

import 'weight_bmi_controller.dart';

class WeightBmiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeightBmiController>(() => WeightBmiController());
  }
}
