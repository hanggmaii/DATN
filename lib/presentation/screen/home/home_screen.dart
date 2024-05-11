import 'package:datn/presentation/widget/app_touchable.dart';
import 'package:datn/presentation/widget/dots_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import 'home_controller.dart';
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
          Padding(
            padding: EdgeInsets.only(bottom: 12.0.sp),
            child: Row(
              children: [
                Text(
                  "Alarm",
                  style: AppTextTheme.headerTextStyle,
                ),
                const Spacer(),
                AppTouchable(
                  onPressed: () {},
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
          Container(
            height: 90.0.sp,
            margin: EdgeInsets.only(
              bottom: 12.0.sp,
            ),
            child: ListView.builder(
              itemCount: 2,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(
                    width: 100.0.sp,
                    height: 78.0.sp,
                    child: DottedBorder(
                      strokeWidth: 0.5.sp,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12.0.sp),
                      dashPattern: const [12, 6],
                      color: AppColor.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                color: AppColor.primaryColor,
                                size: 28.0.sp,
                              ),
                              Text(
                                "Set alarm",
                                style: AppTextTheme.fw600ts14(
                                  AppColor.defaultTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
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
                  vertical: 8.0.sp,
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
