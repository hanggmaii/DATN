import 'package:datn/presentation/widget/accept_button.dart';
import 'package:datn/presentation/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_image.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';

class HeartRateTutorialScreen extends StatelessWidget {
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
          const AcceptButton(
            buttonText: "Measure now",
          ),
          SizedBox(
            height: 24.0.sp,
          )
        ],
      ),
    );
  }
}
