import 'dart:math';

import 'package:datn/presentation/widget/reject_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../data/enum/bmi_type.dart';
import '../../../../../language/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/accept_button.dart';

class BMIINfoWidget extends StatelessWidget {
  const BMIINfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bmiTypeLength = BMIType.values.length;
    double width = MediaQuery.of(context).size.width;
    var dialogWidth = min<double>(width * 0.86, 400);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: dialogWidth,
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(10.0.sp),
              margin: EdgeInsets.symmetric(vertical: 20.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TranslationConstants.bmi.tr,
                    textAlign: TextAlign.center,
                    style: AppTextTheme.fw600ts16(AppColor.black),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.sp,
                        horizontal: 20.sp,
                      ),
                      itemBuilder: (context, index) {
                        final type = BMIType.values[index];

                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.sp,
                            horizontal: 12.sp,
                          ),
                          decoration: BoxDecoration(
                            color: type.color,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type.bmiName,
                                style: AppTextTheme.fw600ts16(AppColor.white),
                              ),
                              Text(
                                type.message,
                                style: AppTextTheme.fw600ts16(AppColor.white),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.sp,
                        );
                      },
                      itemCount: bmiTypeLength,
                    ),
                  ),
                  RejectButton(
                    buttonText: "Close",
                    onPressButton: Get.back,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
