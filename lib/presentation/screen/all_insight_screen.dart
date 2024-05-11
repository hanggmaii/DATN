import 'package:datn/presentation/screen/home/widget/insight_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';
import 'home/home_controller.dart';

class AllInsightScreen extends StatelessWidget {
  const AllInsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return AppContainer(
      child: Column(
        children: [
          const AppHeader(
            title: "Insights",
            backgroundColor: AppColor.backgroundColor,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: homeController.listInsight.length,
                padding: EdgeInsets.fromLTRB(
                  12.0.sp,
                  6.0.sp,
                  12.0.sp,
                  12.0.sp,
                ),
                itemBuilder: (context, index) {
                  return InsightWidget(
                    data: homeController.listInsight[index],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
