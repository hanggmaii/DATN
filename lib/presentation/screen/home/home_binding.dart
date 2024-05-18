import 'package:get/get.dart';

import '../../dialog/alarm_dialog_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put(AlarmDialogController());
  }
}
