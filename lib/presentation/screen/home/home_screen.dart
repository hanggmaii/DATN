import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_touchable.dart';
import 'home_controller.dart';
import 'widget/alarm_horizontal_list_view.dart';
import 'widget/group_button_widget.dart';
import 'widget/insight_list_view_widget.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      leftPadding: 12.0.sp,
      rightPadding: 12.0.sp,
      child: Column(
        children: [
          const AppHeader(
            title: "Heart Rate",
            showBackButton: true,
          ),
          const HomeGroupButtonWidget(),
          Container(
            width: MediaQuery.of(controller.context).size.width,
            margin: EdgeInsets.symmetric(
              vertical: 18.0.sp,
            ),
            height: 1.0.sp,
            color: AppColor.borderColor,
          ),
          Obx(
            () => controller.alarmList.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(bottom: 12.0.sp),
                    child: Row(
                      children: [
                        Text(
                          "Alarm",
                          style: AppTextTheme.headerTextStyle,
                        ),
                        const Spacer(),
                        AppTouchable(
                          onPressed: () => controller.goToAlarmScreen(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.0.sp,
                          ),
                          child: Text(
                            "View all",
                            style: AppTextTheme.fw400ts14(
                              AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const AlarmHorizontalListView(),
          Row(
            children: [
              Text(
                "Insights",
                style: AppTextTheme.headerTextStyle,
              ),
              const Spacer(),
              AppTouchable(
                onPressed: () => controller.goToAllInsightScreen(),
                padding: EdgeInsets.symmetric(
                  horizontal: 4.0.sp,
                ),
                child: Text(
                  "View all",
                  style: AppTextTheme.fw400ts14(
                    AppColor.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const InsightListViewWidget(),
        ],
      ),
    );
  }
}
