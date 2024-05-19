import 'package:datn/data/enum/alarm_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/app_week_days_picker.dart';
import 'alarm_controller.dart';
import 'widgets/alarm_add_button.dart';

class AlarmScreen extends BaseScreen<AlarmController> {
  const AlarmScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Stack(
        children: [
          Column(
            children: [
              const AppHeader(
                title: "Alarm",
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16.0.sp,
                      right: 16.0.sp,
                      bottom: 16.0.sp,
                    ),
                    itemCount: controller.alarmList.length,
                    itemBuilder: (context, index) {
                      var formattedDate = DateFormat("HH:mm");

                      return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0.sp,
                              horizontal: 16.0.sp,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 6.0.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0.sp),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Remind to record",
                                      style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                                    ),
                                    const Spacer(),
                                    AppTouchable(
                                      onPressed: () => controller.onPressDeleteAlarm(index),
                                      padding: EdgeInsets.all(4.0.sp),
                                      child: AppImageWidget.asset(
                                        path: AppImage.icTrash,
                                        width: 24.0.sp,
                                        height: 24.0.sp,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.alarmList[index].type.title,
                                        style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        formattedDate.format(controller.alarmList[index].time),
                                        style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: AppWeekdaysPicker(
                                    initialWeekDays: controller.alarmList[index].alarmDays,
                                    enableSelection: false,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                ),
              ),
            ],
          ),
          const AddAlarmButton(),
        ],
      ),
    );
  }
}
