import 'package:datn/presentation/theme/app_text_theme.dart';
import 'package:datn/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../language/app_translation.dart';
import '../theme/app_color.dart';
import '../widget/app_touchable.dart';
import 'app_dialog.dart';

class AddDataDialog extends StatelessWidget {
  final RxString rxStrDate;
  final RxString rxStrTime;
  final Widget child;
  final Function() onSelectDate;
  final Function() onSelectTime;
  final Function()? firstButtonOnPressed;
  final bool isEdit;
  final Function()? secondButtonOnPressed;
  final Widget? coverScreenWidget;
  final String? firstButtonText;
  final bool hasScroll;

  const AddDataDialog({
    super.key,
    required this.rxStrDate,
    required this.rxStrTime,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.child,
    this.isEdit = false,
    this.coverScreenWidget,
    this.firstButtonOnPressed,
    this.firstButtonText,
    this.secondButtonOnPressed,
    this.hasScroll = false,
  });

  Widget _buildDateTimeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
      child: Row(
        children: [
          SizedBox(width: 8.0.sp),
          Expanded(
            child: AppTouchable(
              onPressed: onSelectDate,
              padding: EdgeInsets.symmetric(
                vertical: 8.sp,
                horizontal: 12.sp,
              ),
              radius: 8.0.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0.sp),
                border: Border.all(
                  color: AppColor.borderColor,
                  width: 1.0.sp,
                ),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rxStrDate.value,
                      style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0.sp),
          Expanded(
            child: AppTouchable(
              onPressed: onSelectTime,
              padding: EdgeInsets.symmetric(
                vertical: 8.sp,
                horizontal: 12.sp,
              ),
              radius: 8.0.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0.sp),
                border: Border.all(
                  color: AppColor.borderColor,
                  width: 1.0.sp,
                ),
              ),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        rxStrTime.value,
                        style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(width: 8.0.sp),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      firstButtonText: isEdit ? TranslationConstants.save.tr : TranslationConstants.add.tr,
      firstButtonCallback: () {
        firstButtonOnPressed?.call() ?? Get.back;
      },
      secondButtonText: TranslationConstants.cancel.tr,
      hasScroll: hasScroll,
      secondButtonCallback: () {
        secondButtonOnPressed?.call() ?? Get.back;
      },
      coverScreenWidget: coverScreenWidget,
      widgetBody: InkWell(
        onTap: () => AppUtils.hideKeyboard(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDateTimeWidget(),
            child,
          ],
        ),
      ),
    );
  }
}
