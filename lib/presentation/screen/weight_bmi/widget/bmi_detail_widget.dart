import 'package:datn/presentation/theme/app_color.dart';
import 'package:datn/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enum/bmi_type.dart';
import '../../../../utils/app_image.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';

class BMIDetailWidget extends StatelessWidget {
  final String date;
  final String time;
  final int bmi;
  final int weight;
  final int height;
  final BMIType bmiType;
  final Function() onEdit;
  final Function() onDelete;

  const BMIDetailWidget({
    super.key,
    required this.date,
    required this.time,
    required this.bmi,
    required this.weight,
    required this.height,
    required this.bmiType,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: onEdit,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.0.sp),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              offset: const Offset(0, 0),
              blurRadius: 10.0.sp,
            ),
          ],
        ),
        padding: EdgeInsets.all(14.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$time ",
                      style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                    ),
                    Text(
                      date,
                      style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '$height',
                        style: AppTextTheme.fw400ts14(AppColor.primaryColor)?.copyWith(
                          fontSize: 24.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: ' cm',
                            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 24.0.sp,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '$weight',
                        style: AppTextTheme.fw400ts14(AppColor.primaryColor)?.copyWith(
                          fontSize: 24.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: ' kg',
                            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: 'BMI = ',
                    style: AppTextTheme.fw400ts14(AppColor.defaultTextColor)?.copyWith(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: '$bmi',
                        style: AppTextTheme.fw400ts14(AppColor.primaryColor)?.copyWith(
                          fontSize: 24.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 24.0.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTouchable(
                    width: 40.0.sp,
                    height: 40.0.sp,
                    onPressed: onDelete,
                    padding: EdgeInsets.all(8.0.sp),
                    child: AppImageWidget.asset(
                      path: AppImage.icTrash,
                    ),
                  ),
                  SizedBox(
                    height: 12.0.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: bmiType.color,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 6.0.sp,
                      horizontal: 12.0.sp,
                    ),
                    child: Text(
                      bmiType.bmiName,
                      textAlign: TextAlign.center,
                      style: AppTextTheme.fw600ts16(AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
