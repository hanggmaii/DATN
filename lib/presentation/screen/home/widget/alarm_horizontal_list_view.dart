import 'package:datn/data/enum/alarm_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../home_controller.dart';

class AlarmHorizontalListView extends GetWidget<HomeController> {
  const AlarmHorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.alarmList.isEmpty
          ? const SizedBox.shrink()
          : Container(
              height: 90.0.sp,
              margin: EdgeInsets.only(
                bottom: 12.0.sp,
              ),
              child: ListView.builder(
                itemCount: controller.alarmList.length,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var formattedDate = DateFormat("HH:mm");

                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0.sp,
                      horizontal: 16.0.sp,
                    ),
                    margin: EdgeInsets.only(
                      right: 12.0.sp,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppImageWidget.asset(
                              path: AppImage.icClock,
                              width: 24.0.sp,
                              height: 24.0.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 12.0.sp,
                                right: 24.0.sp,
                              ),
                              child: Text(
                                formattedDate.format(controller.alarmList[index].time),
                                style: AppTextTheme.fw600ts20(
                                  AppColor.defaultTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8.0.sp,
                          ),
                          child: Text(
                            controller.alarmList[index].type.title,
                            style: AppTextTheme.fw600ts14(
                              AppColor.secondTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
