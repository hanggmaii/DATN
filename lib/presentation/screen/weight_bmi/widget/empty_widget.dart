import 'package:datn/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../../../widget/app_image_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final String message;

  const EmptyWidget({
    super.key,
    required this.imagePath,
    required this.message,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              AppImageWidget.asset(
                path: imagePath,
                width: imageWidth,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 52.sp),
                child: Text(
                  message,
                  style: AppTextTheme.fw400ts14(AppColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
