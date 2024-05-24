import 'package:get/get.dart';

import 'heart_rate_controller.dart';
import 'measure/measure_controller.dart';

class HeartRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeartRateController>(() => HeartRateController());
    Get.lazyPut<MeasureController>(() => MeasureController());
  }
}
