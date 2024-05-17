import 'package:datn/presentation/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/enum/alarm_type.dart';
import '../../data/model/alarm_model.dart';
import '../../language/app_translation.dart';
import '../../utils/app_log.dart';
import '../theme/app_color.dart';
import '../widget/app_button.dart';
import '../widget/app_week_days_picker.dart';
import 'alarm_dialog_controller.dart';

class AlarmDialog extends GetView<AlarmDialogController> {
  AlarmDialog({
    super.key,
    this.alarmModel,
    this.onPressCancel,
    this.onPressSave,
    this.alarmType,
  }) {
    if (alarmModel != null) {
      AppLog.debug("AlarmDialog.alarmModel.id: ${alarmModel!.id}");
      controller.alarmModel.value = alarmModel!;
    } else {
      controller.alarmModel.value = controller.alarmModel.value.copyWith(
        type: alarmType,
        time: DateTime.now(),
      );
    }
    controller.validate();
  }

  final AlarmModel? alarmModel;
  final void Function()? onPressCancel;
  final void Function(AlarmModel)? onPressSave;
  final AlarmType? alarmType;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 69.0.sp,
          ),
          AppWeekdaysPicker(
            initialWeekDays: controller.alarmModel.value.alarmDays,
            enableSelection: true,
            onSelectedWeekdaysChanged: controller.onSelectedWeekDaysChanged,
          ),
          SizedBox(
            height: 52.0.sp,
          ),
          SizedBox(
            height: 160.0.sp,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime:
                  DateTime(0, 0, 0, controller.alarmModel.value.time!.hour, controller.alarmModel.value.time!.minute),
              use24hFormat: true,
              onDateTimeChanged: controller.onTimeChange,
            ),
          ),
          SizedBox(
            height: 52.0.sp,
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () {
                    controller.reset();
                    if (onPressCancel != null) {
                      onPressCancel!();
                    } else {
                      Get.back();
                    }
                  },
                  height: 60.0.sp,
                  width: Get.width,
                  color: AppColor.primaryColor,
                  radius: 10.0.sp,
                  child: Text(
                    TranslationConstants.cancel.tr,
                    textAlign: TextAlign.center,
                    style: AppTextTheme.fw600ts14(Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 8.0.sp),
              Expanded(
                child: AppButton(
                  height: 60.0.sp,
                  width: Get.width,
                  onPressed: controller.isValid.value
                      ? () {
                          final alarmModel = controller.alarmModel.value;
                          controller.reset();
                          if (onPressSave != null) {
                            AppLog.debug("AlarmDialog.alarmModel.id: ${alarmModel.id}");
                            onPressSave!(alarmModel);
                          }
                        }
                      : null,
                  color: controller.isValid.value ? AppColor.primaryColor : AppColor.gray,
                  radius: 10.0.sp,
                  child: Text(
                    TranslationConstants.save.tr,
                    textAlign: TextAlign.center,
                    style: AppTextTheme.fw600ts14(Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
