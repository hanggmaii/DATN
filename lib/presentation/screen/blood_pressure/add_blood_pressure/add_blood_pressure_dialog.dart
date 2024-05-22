import 'package:datn/data/enum/blood_pressure_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/model/blood_pressure_model.dart';
import '../../../../language/app_translation.dart';
import '../../../../utils/app_image.dart';
import '../../../dialog/app_dialog.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_loading.dart';
import '../../../widget/app_touchable.dart';
import '../widget/scroll_blood_pressure_value_widget.dart';
import 'add_blood_pressure_controller.dart';

class AddBloodPressureDialog extends GetView<AddBloodPressureController> {
  final BloodPressureModel? bloodPressureModel;

  const AddBloodPressureDialog({
    super.key,
    this.bloodPressureModel,
  });

  void _onAddData() {
    bloodPressureModel != null ? controller.onSave() : controller.addBloodPressure();
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    if (bloodPressureModel != null) {
      controller.onEdit(bloodPressureModel!);
    }
    return AppDialog(
      firstButtonText: bloodPressureModel != null ? TranslationConstants.save.tr : TranslationConstants.add.tr,
      firstButtonCallback: () => _onAddData(),
      secondButtonText: TranslationConstants.cancel.tr,
      secondButtonCallback: () => Get.back(),
      coverScreenWidget: Obx(
        () => controller.isLoading.value ? const AppLoading() : const SizedBox(),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12.0.sp,
        horizontal: 16.0.sp,
      ),
      widgetBody: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 16.0.sp,
              ),
              AppTouchable(
                onPressed: controller.onSelectBloodPressureDate,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0.sp),
                  border: Border.all(
                    color: AppColor.borderColor,
                    width: 1.5.sp,
                  ),
                ),
                radius: 8.0.sp,
                padding: EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 12.sp,
                ),
                child: Obx(
                  () => Text(
                    controller.stringBloodPrDate.value,
                    style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                  ),
                ),
              ),
              const Spacer(),
              AppTouchable(
                onPressed: controller.onSelectBloodPressureTime,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0.sp),
                  border: Border.all(
                    color: AppColor.borderColor,
                    width: 1.5.sp,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 12.sp,
                ),
                child: Obx(
                  () => Text(
                    controller.stringBloodPrTime.value,
                    style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                  ),
                ),
              ),
              SizedBox(
                width: 16.0.sp,
              ),
            ],
          ),
          SizedBox(
            height: 24.sp,
          ),
          Obx(
            () => Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: controller.bloodPressureType.value.color,
                borderRadius: BorderRadius.circular(60),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.sp,
                horizontal: 24.sp,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  controller.bloodPressureType.value.name,
                  style: AppTextTheme.fw600ts16(AppColor.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScrollBloodPressureValueWidget(
                  title: TranslationConstants.systolic.tr,
                  childCount: 281,
                  initItem: controller.systolic.value - 20,
                  onSelectedItemChanged: controller.onSelectSys,
                  itemBuilder: (ctx, value) {
                    return Center(
                      child: Obx(
                        () => Text(
                          '${value + 20}',
                          style: TextStyle(
                            color: controller.bloodPressureType.value.color,
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.w700,
                            height: 5 / 4,
                          ),
                        ),
                      ),
                    );
                  }),
              ScrollBloodPressureValueWidget(
                  title: TranslationConstants.diastolic.tr,
                  childCount: 281,
                  initItem: controller.diastolic.value - 20,
                  onSelectedItemChanged: controller.onSelectDia,
                  itemBuilder: (ctx, value) {
                    return Center(
                      child: Obx(
                        () => Text(
                          '${value + 20}',
                          style: TextStyle(
                            color: controller.bloodPressureType.value.color,
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.w700,
                            height: 5 / 4,
                          ),
                        ),
                      ),
                    );
                  }),
              ScrollBloodPressureValueWidget(
                  title: TranslationConstants.pulse.tr,
                  initItem: controller.pulse.value - 20,
                  childCount: 181,
                  onSelectedItemChanged: controller.onSelectPules,
                  itemBuilder: (ctx, value) {
                    return Center(
                      child: Obx(
                        () => Text(
                          '${value + 20}',
                          style: TextStyle(
                            color: controller.bloodPressureType.value.color,
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.w700,
                            height: 5 / 4,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          AppTouchable(
            onPressed: controller.onShowBloodPressureInfo,
            width: Get.width,
            padding: EdgeInsets.all(8.0.sp),
            outlinedBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0.sp),
            ),
            decoration: BoxDecoration(
              color: AppColor.lightGray,
              borderRadius: BorderRadius.circular(9.0.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FittedBox(
                    child: Obx(
                      () => Text(
                        controller.bloodPressureType.value.sortMessageRange,
                        style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0.sp),
                Icon(
                  Icons.info_outline,
                  size: 22.0.sp,
                  color: AppColor.secondTextColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.sp,
          ),
          Obx(
            () => Flexible(
              child: Text(
                controller.bloodPressureType.value.message,
                style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
          Obx(
            () => Row(
              children: BloodPressureType.values
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            controller.bloodPressureType.value == e
                                ? AppImageWidget.asset(
                                    path: AppImage.icArrowDown,
                                    width: 20.0.sp,
                                    height: 12.sp,
                                    color: controller.bloodPressureType.value.color,
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
            height: 32.sp,
          )
        ],
      ),
    );
  }
}
