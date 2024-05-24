import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_image.dart';
import '../widget/accept_button.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';
import '../widget/app_image_widget.dart';
import 'heart_rate/measure/measure_controller.dart';

class HeartRateTutorialScreen extends GetWidget<MeasureController> {
  const HeartRateTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          const AppHeader(
            title: "Heart Rate",
          ),
          const Spacer(),
          AppImageWidget.asset(
            path: AppImage.imgHeartRateTutorial,
            width: Get.width * 0.9,
          ),
          const Spacer(),
          AcceptButton(
            buttonText: "Measure now",
            onPressButton: controller.onPressStartMeasure,
          ),
          SizedBox(
            height: 24.0.sp,
          )
        ],
      ),
    );
  }
}
