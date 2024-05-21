import 'package:get/get.dart';

import 'add_weight_bmi/add_weight_bmi_controller.dart';
import 'weight_bmi_controller.dart';

class WeightBmiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeightBmiController>(() => WeightBmiController());
    Get.lazyPut<AddWeightBMIController>(() => AddWeightBMIController());
  }
}
