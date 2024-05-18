import 'package:datn/data/enum/alarm_type.dart';
import 'package:datn/data/model/alarm_model.dart';
import 'package:get/get.dart';

import '../../base/base_controller.dart';
import '../../dialog/add_alarm_dialog.dart';
import '../heart_rate_tutorial_screen.dart';
import '../home/home_controller.dart';

class HeartRateController extends BaseController {
  final HomeController _homeController = Get.find<HomeController>();

  void goToHeartRateTutorial() {
    Get.to(() => const HeartRateTutorialScreen());
  }

  void addAlarm() {
    showAddAlarm(
      context: context,
      type: AlarmType.heartRate,
      onPressCancel: () {
        Get.back();
      },
      onPressSave: (AlarmModel item) {
        _homeController.addAlarm(item);
      },
    );
  }
}
