import 'package:datn/data/enum/bmi_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/model/bmi_model.dart';
import '../../../../language/app_translation.dart';
import '../../../../utils/app_image.dart';
import '../../../dialog/add_data_dialog.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_loading.dart';
import '../../../widget/app_touchable.dart';
import '../../blood_pressure/widget/blood_text_field_widget.dart';
import 'add_weight_bmi_controller.dart';

class AddWeightBMIDialog extends GetView<AddWeightBMIController> {
  final BMIModel? bmiModel;

  const AddWeightBMIDialog({
    super.key,
    this.bmiModel,
  });

  @override
  Widget build(BuildContext context) {
    if (bmiModel != null) {
      controller.onEdit(bmiModel!);
    }

    return AddDataDialog(
      rxStrDate: controller.stringBloodPrDate,
      rxStrTime: controller.stringBloodPrTime,
      onSelectDate: () => controller.onSelectBMIDate(context),
      isEdit: bmiModel != null,
      hasScroll: true,
      onSelectTime: () => controller.onSelectBMITime(context),
      secondButtonOnPressed: () => Get.back(),
      firstButtonOnPressed: () {
        if (bmiModel != null) {
          controller.onSave(context);
        } else {
          controller.addBMI(context);
        }
      },
      coverScreenWidget: Obx(
        () => controller.isLoading.value ? const AppLoading() : const SizedBox(),
      ),
      child: Column(
        children: [
          SizedBox(height: 24.sp),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Weight (kg)",
                  style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 16.sp),
              Expanded(
                child: Text(
                  "Height (cm)",
                  style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          SizedBox(
            height: 68.sp,
            child: Row(
              children: [
                Expanded(
                  child: BloodTextFieldWidget(
                    controller: controller.weightController,
                    onChanged: controller.caculateBMI,
                  ),
                ),
                SizedBox(
                  width: 16.sp,
                ),
                Expanded(
                  child: BloodTextFieldWidget(
                    controller: controller.cmController,
                    onChanged: controller.caculateBMI,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: controller.bmiType.value.color,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    controller.bmiType.value.bmiName,
                    style: AppTextTheme.fw400ts14(AppColor.white),
                  ),
                ),
              ),
              SizedBox(
                height: 16.sp,
              ),
              Obx(
                () => AppTouchable(
                  onPressed: () => controller.onShowInfo(context),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  radius: 12.0.sp,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    controller.bmiType.value.message,
                    style: AppTextTheme.fw400ts14(AppColor.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 28.sp,
          ),
          Obx(
            () => Row(
              children: BMIType.values
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            controller.bmiType.value == e
                                ? AppImageWidget.asset(
                                    path: AppImage.icArrowDown,
                                    width: 20.0.sp,
                                    height: 20.0.sp,
                                    color: controller.bmiType.value.color,
                                  )
                                : SizedBox(
                                    height: 12.sp,
                                  ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Container(
                              height: 12.sp,
                              decoration: BoxDecoration(
                                color: e.color,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 30.sp,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTouchable(
                onPressed: () => controller.onPressedAge(context),
                padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
                child: Obx(
                  () => Text(
                    '${TranslationConstants.age.tr}: ${controller.age.value}',
                    style: AppTextTheme.fw400ts14(AppColor.black)?.merge(
                      const TextStyle(
                        shadows: [
                          Shadow(
                            color: AppColor.grayText2,
                            offset: Offset(0, -5),
                          ),
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.grayText2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0.sp),
              AppTouchable(
                onPressed: () => controller.onPressGender(context),
                padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
                child: Obx(() {
                  return Text(
                    controller.gender['nameEN'],
                    style: AppTextTheme.fw400ts14(AppColor.black)?.merge(
                      const TextStyle(
                        shadows: [
                          Shadow(
                            color: AppColor.grayText2,
                            offset: Offset(0, -5),
                          ),
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.grayText2,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(
            height: 36.sp,
          )
        ],
      ),
    );
  }
}
