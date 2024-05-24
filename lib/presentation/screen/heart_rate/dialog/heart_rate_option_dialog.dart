import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';
import '../heart_rate_controller.dart';

void showHeaderRateOptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const HeartRateOptionDialog();
    },
  );
}

class HeartRateOptionDialog extends StatelessWidget {
  const HeartRateOptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final HeartRateController heartRateController = Get.find<HeartRateController>();

    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose on option",
              style: AppTextTheme.headerTextStyle,
            ),
            SizedBox(
              height: 8.0.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTouchable(
                  onPressed: () {
                    Get.back();
                    heartRateController.onPressMeasureNow();
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0.sp),
                    color: AppColor.backgroundColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0.sp,
                    horizontal: 12.0.sp,
                  ),
                  radius: 12.0.sp,
                  child: Column(
                    children: [
                      AppImageWidget.asset(
                        path: AppImage.imgHeartRate,
                        width: 68.0.sp,
                        height: 68.0.sp,
                      ),
                      Text(
                        "Measure",
                        style: AppTextTheme.fw600ts14(
                          AppColor.defaultTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.0.sp,
                ),
                AppTouchable(
                  onPressed: () {
                    Get.back();
                    heartRateController.onPressAddData();
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0.sp),
                    color: AppColor.backgroundColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0.sp,
                    horizontal: 12.0.sp,
                  ),
                  radius: 12.0.sp,
                  child: Column(
                    children: [
                      AppImageWidget.asset(
                        path: AppImage.imgAdd,
                        width: 68.0.sp,
                        height: 68.0.sp,
                      ),
                      Text(
                        "Add",
                        style: AppTextTheme.fw600ts14(
                          AppColor.defaultTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
