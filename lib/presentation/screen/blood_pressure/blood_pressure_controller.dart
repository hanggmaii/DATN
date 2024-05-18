import 'package:get/get.dart';

import '../../../data/enum/alarm_type.dart';
import '../../../data/model/alarm_model.dart';
import '../../base/base_controller.dart';
import '../../dialog/add_alarm_dialog.dart';
import '../home/home_controller.dart';

class BloodPressureController extends BaseController {
  final HomeController _homeController = Get.find<HomeController>();

  void addAlarm() {
    showAddAlarm(
      context: context,
      type: AlarmType.bloodPressure,
      onPressCancel: () {
        Get.back();
      },
      onPressSave: (AlarmModel item) {
        _homeController.addAlarm(item);
      },
    );
  }
}
