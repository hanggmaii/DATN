import 'package:datn/presentation/screen/alarm/alarm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enum/alarm_type.dart';
import '../../../theme/app_color.dart';
import 'alarm_add_button_controller.dart';
import 'animated_floating_action_button.dart';
import 'bubble_menu.dart';

class AddAlarmButton extends GetView<AlarmAddButtonController> {
  const AddAlarmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      animation: controller.animation,
      onPress: () {
        if (controller.animationController.isCompleted) {
          controller.animationController.reverse();
        } else {
          controller.animationController.forward();
        }
      },
      backgroundCloseColor: AppColor.primaryColor,
      items: AlarmType.values
          .map(
            (alarmType) => Bubble(
              title: alarmType.tr,
              onPress: () {
                controller.onPressAdd(context, alarmType);
              },
            ),
          )
          .toList(),
    );
  }
}
