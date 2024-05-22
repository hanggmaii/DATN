import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import 'alarm_controller.dart';
import 'widgets/alarm_add_button.dart';
import 'widgets/alarm_horizontal_widget.dart';

class AlarmScreen extends BaseScreen<AlarmController> {
  const AlarmScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
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
                      scrollDirection: Axis.vertical,
                      itemCount: controller.alarmList.length,
                      itemBuilder: (context, index) {
                        return AlarmHorizontalWidget(
                          controller: controller,
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const AddAlarmButton(),
        ],
      ),
    );
  }
}
