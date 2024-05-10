import 'package:datn/presentation/screen/home/widget/group_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import 'home_controller.dart';
import 'widget/insight_widget.dart';

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
          Row(
            children: [
              Text(
                "Alarm",
                style: AppTextTheme.headerTextStyle,
              ),
              const Spacer(),
              Text(
                "View all",
                style: AppTextTheme.fw400ts14(
                  AppColor.primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Insights",
                style: AppTextTheme.headerTextStyle,
              ),
              const Spacer(),
              Text(
                "View all",
                style: AppTextTheme.fw400ts14(
                  AppColor.primaryColor,
                ),
              ),
            ],
          ),
          const InsightWidget(),
        ],
      ),
    );
  }
}
