import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../language/app_translation.dart';
import '../../../../utils/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';
import '../../heart_rate_tutorial_screen.dart';
import '../widget/heart_bpm.dart';
import 'measure_controller.dart';

class MeasureScreen extends GetView<MeasureController> {
  const MeasureScreen({super.key});

  Widget _buildStateMeasure(BuildContext context) {
    double sizeCircle = Get.width / 1.725;
    return Column(
      key: const ValueKey<int>(0),
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CircularPercentIndicator(
                    animation: true,
                    animationDuration: 200,
                    radius: sizeCircle / 2,
                    lineWidth: 10.0.sp,
                    percent: controller.progress.value < 0.0
                        ? 0.0
                        : controller.progress.value > 1.0
                            ? 1.0
                            : controller.progress.value,
                    circularStrokeCap: CircularStrokeCap.round,
                    animateFromLastPercent: true,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
                          child: AppImageWidget.asset(
                            path: AppImage.imgHeartRate,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: AppColor.gray,
                    progressColor: AppColor.red,
                  )),
              SizedBox(height: 24.0.sp),
              Obx(() => Text(
                    '${TranslationConstants.measuring.tr} (${(controller.progress.value * 100).toInt()}%)',
                    style: AppTextTheme.fw600ts16(AppColor.primaryColor),
                  )),
              SizedBox(height: 2.0.sp),
              Text(
                TranslationConstants.placeYourFinger.tr,
                style: AppTextTheme.fw600ts16(AppColor.primaryColor),
              ),
              SizedBox(height: 27.0.sp),
              HeartBPMDialog(
                context: context,
                onBPM: controller.onBPM,
                onRawData: controller.onRawData,
                alpha: 0.5,
              )
            ],
          ),
        ),
        AppTouchable(
          onPressed: controller.onPressStopMeasure,
          width: Get.width,
          backgroundColor: AppColor.primaryColor,
          padding: EdgeInsets.fromLTRB(
            80.0.sp,
            12.0.sp,
            80.0.sp,
            12.0.sp,
          ),
          child: Text(
            TranslationConstants.stop.tr,
            style: AppTextTheme.fw600ts16(AppColor.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return AppContainer(
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: controller.currentMeasureScreenState.value == MeasureScreenState.measuring
                    ? _buildStateMeasure(context)
                    : const HeartRateTutorialScreen(
                        key: ValueKey<int>(1),
                      ),
              );
            }),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 12.0.sp),
        ],
      ),
    );
  }
}
