import 'package:get/get.dart';

import 'add_blood_pressure/add_blood_pressure_controller.dart';
import 'blood_pressure_controller.dart';

class BloodPressureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodPressureController>(() => BloodPressureController());
    Get.lazyPut<AddBloodPressureController>(() => AddBloodPressureController());
  }
}
