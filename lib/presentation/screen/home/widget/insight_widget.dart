import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_loading.dart';
import '../home_controller.dart';

class InsightWidget extends GetWidget<HomeController> {
  const InsightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.loadingInsight.value
            ? const AppLoading()
            : controller.listInsight.isEmpty
                ? Text(
                    "No data",
                    style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0.sp,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0.sp,
                          horizontal: 6.0.sp,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(12.0.sp),
                        ),
                        child: Row(
                          children: [
                            AppImageWidget.asset(
                              path: controller.listInsight[index].icon,
                              width: 44.0.sp,
                              height: 44.0.sp,
                            ),
                            SizedBox(
                              width: 12.0.sp,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.listInsight[index].title,
                                    style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 8.0.sp,
                                  ),
                                  Text(
                                    "View detail",
                                    style: AppTextTheme.fw400ts12(AppColor.primaryColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
