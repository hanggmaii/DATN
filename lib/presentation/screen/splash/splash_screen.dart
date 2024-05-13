import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import 'splash_controller.dart';

class SplashScreen extends BaseScreen<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageWidget.asset(
              path: AppImage.imgSplash,
              height: 130.0.sp,
              width: 130.0.sp,
            ),
            Text(
              "HealthPulse",
              style: AppTextTheme.fw600ts20(AppColor.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
