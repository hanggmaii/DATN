import 'package:get/get.dart';

import 'alarm_controller.dart';
import 'widgets/alarm_add_button_controller.dart';

class AlarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlarmController>(() => AlarmController());
    Get.lazyPut<AlarmAddButtonController>(() => AlarmAddButtonController());
  }
}
