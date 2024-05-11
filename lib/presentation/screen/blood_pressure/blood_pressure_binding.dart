import 'package:get/get.dart';

import 'blood_pressure_controller.dart';

class BloodPressureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodPressureController>(() => BloodPressureController());
  }
}
