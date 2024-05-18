import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/enum/alarm_type.dart';
import '../../data/model/alarm_model.dart';
import '../../utils/app_log.dart';
import '../../utils/app_utils.dart';
import '../widget/accept_button.dart';
import '../widget/app_week_days_picker.dart';
import '../widget/reject_button.dart';
import 'alarm_dialog_controller.dart';
import 'app_dialog.dart';

Future<void> showAddAlarm({
  required BuildContext context,
  required AlarmType type,
  void Function()? onPressCancel,
  void Function(AlarmModel)? onPressSave,
}) async {
  showAppDialog(
    context,
    "Set alarm",
    hideGroupButton: true,
    widgetBody: AddAlarmDialog(
      alarmType: type,
      onPressCancel: () => onPressCancel?.call(),
      onPressSave: (item) {
        onPressSave?.call(item);
        Get.back();
      },
    ),
  );
}

class AddAlarmDialog extends GetView<AlarmDialogController> {
  const AddAlarmDialog({
    super.key,
    required this.alarmType,
    required this.onPressCancel,
    required this.onPressSave,
  });

  final AlarmType alarmType;
  final void Function() onPressCancel;
  final void Function(AlarmModel) onPressSave;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12.0.sp,
            ),
            AppWeekdaysPicker(
              initialWeekDays: controller.alarmModel.value.alarmDays,
              enableSelection: true,
              onSelectedWeekdaysChanged: controller.onSelectedWeekDaysChanged,
            ),
            SizedBox(
              height: 12.0.sp,
            ),
            SizedBox(
              height: 160.0.sp,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime(
                  0,
                  0,
                  0,
                  controller.alarmModel.value.time.hour,
                  controller.alarmModel.value.time.minute,
                ),
                use24hFormat: true,
                onDateTimeChanged: controller.onTimeChange,
              ),
            ),
            SizedBox(
              height: 12.0.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: RejectButton(
                    onPressButton: () {
                      controller.reset();
                      onPressCancel.call();
                    },
                  ),
                ),
                SizedBox(width: 8.0.sp),
                Expanded(
                  child: AcceptButton(
                    onPressButton: controller.isValid.value
                        ? () {
                            final alarmModel = controller.alarmModel.value.copyWith(
                              type: alarmType
                            );

                            controller.reset();
                            AppLog.debug("Save button click");
                            AppLog.debug("AlarmDialog.alarmModel.id: ${alarmModel.id}");
                            AppLog.debug("AlarmDialog.alarmModel.type: ${alarmModel.type.title}");
                            onPressSave.call(alarmModel);
                          }
                        : () {
                            AppLog.debug("Save button click");
                            AppUtils.showToast("Select a day");
                          },
                    buttonText: "Save",
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
