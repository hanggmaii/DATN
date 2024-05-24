import 'package:datn/presentation/app/app_controller.dart';
import 'package:datn/presentation/screen/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/heart_rate_model.dart';
import '../../../../language/app_translation.dart';
import '../../../../utils/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';

class HomeGroupButtonWidget extends StatelessWidget {
  const HomeGroupButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final AppController appController = Get.find<AppController>();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 280.0.sp,
      child: Row(
        children: [
          Expanded(
            child: AppTouchable(
              onPressed: () => homeController.goToHeartRateScreen(),
              decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: BorderRadius.circular(28.0.sp),
              ),
              radius: 28.0.sp,
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.sp,
                vertical: 8.0.sp,
              ),
              margin: EdgeInsets.only(
                right: 12.0.sp,
              ),
              child: Obx(
                () {
                  if (appController.listHeartRateModel.isEmpty) {
                    return Column(
                      children: [
                        Text(
                          "Heart Rate",
                          style: AppTextTheme.titleMedium(
                            AppColor.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.0.sp,
                          ),
                          child: AppImageWidget.asset(
                            width: 108.0.sp,
                            height: 108.0.sp,
                            path: AppImage.imgHeartRate,
                          ),
                        ),
                        Text(
                          "Measure your heart rate by camera phone",
                          style: AppTextTheme.fw400ts14(
                            AppColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(48.0.sp),
                            ),
                            margin: EdgeInsets.only(
                              top: 12.0.sp,
                              bottom: 12.0.sp,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0.sp,
                            ),
                            child: Text(
                              "Measure Now",
                              style: AppTextTheme.fw600ts16(
                                AppColor.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  HeartRateModel model = appController.listHeartRateModel.last;

                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(model.timeStamp ?? 0);

                  int value = model.value ?? 40;
                  String status = '';
                  if (value < 60) {
                    status = TranslationConstants.slow.tr;
                  } else if (value > 100) {
                    status = TranslationConstants.fast.tr;
                  } else {
                    status = TranslationConstants.normal.tr;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImageWidget.asset(
                            width: 28.0.sp,
                            height: 28.0.sp,
                            path: AppImage.imgHeartRate,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Heart Rate",
                            style: AppTextTheme.titleMedium(
                              AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('hh:mm, dd/MM/yyyy').format(dateTime),
                            style: AppTextTheme.fw400ts14(AppColor.white),
                          ),
                          Text(
                            status,
                            style: AppTextTheme.fw400ts14(AppColor.white),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '$value',
                              style: AppTextTheme.fw400ts14(AppColor.white)?.copyWith(
                                fontSize: 32.0.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: ' BPM',
                                  style: AppTextTheme.fw400ts14(AppColor.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: AppTouchable(
                      width: MediaQuery.of(context).size.width,
                      onPressed: () => homeController.goToBloodPressureScreen(),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0.sp,
                      ),
                      radius: 28.0.sp,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(28.0.sp),
                        border: Border.all(
                          color: AppColor.borderColor,
                          width: 0.5.sp,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Blood pressure",
                                style: AppTextTheme.headerTextStyle,
                              ),
                              const Spacer(),
                              AppImageWidget.asset(
                                path: AppImage.imgBloodPressure,
                                width: 62.0.sp,
                                height: 62.0.sp,
                              ),
                              SizedBox(height: 8.0.sp),
                            ],
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 12.0.sp),
                Expanded(
                  child: AppTouchable(
                    onPressed: () => homeController.goToWeightBmiScreen(),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0.sp,
                    ),
                    radius: 28.0.sp,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(28.0.sp),
                      border: Border.all(
                        color: AppColor.borderColor,
                        width: 0.5.sp,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Weight and BMI",
                              style: AppTextTheme.headerTextStyle,
                            ),
                            const Spacer(),
                            AppImageWidget.asset(
                              path: AppImage.imgWeightBmi,
                              width: 62.0.sp,
                              height: 62.0.sp,
                            ),
                            SizedBox(height: 8.0.sp),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
