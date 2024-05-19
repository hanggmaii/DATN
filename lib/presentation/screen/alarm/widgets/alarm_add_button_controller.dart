import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enum/alarm_type.dart';
import '../../../dialog/add_alarm_dialog.dart';
import '../alarm_controller.dart';

class AlarmAddButtonController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  final AlarmController _alarmController = Get.find<AlarmController>();

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: animationController,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.onInit();
  }

  void onPressAdd(
    BuildContext context,
    AlarmType e,
  ) {
    if (animationController.isCompleted) {
      animationController.reverse();
    }

    showAddAlarm(
      context: context,
      type: e,
      onPressCancel: () => Get.back(),
      onPressSave: (alarmModel) {
        _alarmController.addAlarm(alarmModel);
      },
    );
  }
}
