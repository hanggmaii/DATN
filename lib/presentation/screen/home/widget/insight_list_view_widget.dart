import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_loading.dart';
import '../home_controller.dart';
import 'insight_widget.dart';

class InsightListViewWidget extends GetWidget<HomeController> {
  const InsightListViewWidget({super.key});

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
                    physics: const ClampingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return InsightWidget(
                        data: controller.listInsight[index],
                        showViewDetail: true,
                      );
                    },
                  ),
      ),
    );
  }
}
