import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../language/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/container_widget.dart';

class SystolicDiastolicWidget extends StatelessWidget {
  final int systolicMin;
  final int systolicMax;
  final int diastolicMin;
  final int diastolicMax;

  const SystolicDiastolicWidget({
    super.key,
    required this.systolicMin,
    required this.systolicMax,
    required this.diastolicMin,
    required this.diastolicMax,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ContainerWidget(
            padding: EdgeInsets.symmetric(
              vertical: 16.sp,
            ),
            child: _ItemWidget(
              title: TranslationConstants.systolic.tr,
              min: systolicMin,
              max: systolicMax,
            ),
          ),
        ),
        SizedBox(
          width: 24.0.sp,
        ),
        Expanded(
          child: ContainerWidget(
              padding: EdgeInsets.symmetric(
                vertical: 16.sp,
              ),
              child: _ItemWidget(
                title: TranslationConstants.diastolic.tr,
                min: diastolicMin,
                max: diastolicMax,
              )),
        ),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final String title;
  final int min;
  final int max;

  const _ItemWidget({
    required this.title,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            title,
            style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        Row(
          children: [
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    TranslationConstants.min.tr,
                    style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Text(
                  '$min',
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                )
              ],
            ),
            SizedBox(
              width: 36.sp,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    TranslationConstants.max.tr,
                    style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Text(
                  '$max',
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                )
              ],
            ),
            const Spacer(),
          ],
        )
      ],
    );
  }
}
