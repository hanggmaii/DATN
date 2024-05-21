import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../language/app_translation.dart';
import '../../utils/app_constants.dart';
import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';
import '../widget/accept_button.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_touchable.dart';
import '../widget/reject_button.dart';

class AppDialogGenderWidget extends StatefulWidget {
  final Map? initialGender;
  final Function()? onPressCancel;
  final Function(Map value)? onPressSave;

  const AppDialogGenderWidget({
    super.key,
    this.initialGender,
    this.onPressCancel,
    this.onPressSave,
  });

  @override
  State<AppDialogGenderWidget> createState() => _AppDialogGenderWidgetState();
}

class _AppDialogGenderWidgetState extends State<AppDialogGenderWidget> {
  late Map _value;

  @override
  void initState() {
    _value = widget.initialGender ?? AppConstant.listGender[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.0.sp),
        Row(
          children: [
            for (int i = 0; i < AppConstant.listGender.length; i++)
              Expanded(
                child: AppTouchable(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0.sp,
                    vertical: 12.0.sp,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 2.0.sp,
                    horizontal: 8.0.sp,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppConstant.listGender[i]['id'] == _value['id'] ? AppColor.primaryColor : AppColor.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0.sp),
                  ),
                  radius: 10.0.sp,
                  onPressed: () {
                    setState(() {
                      _value = AppConstant.listGender[i];
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          AppImageWidget.asset(
                            path: AppConstant.listGender[i]['icon'],
                            width: 48.0.sp,
                            height: 48.0.sp,
                          ),
                          Text(
                            AppConstant.listGender[i]['nameEN'],
                            style: AppTextTheme.fw600ts16(
                              AppConstant.listGender[i]['id'] == _value['id'] ? AppColor.primaryColor : AppColor.black,
                            ),
                          ),
                          SizedBox(
                            height: 24.0.sp,
                          ),
                          AppConstant.listGender[i]['id'] == _value['id']
                              ? Container(
                                  width: 20.0.sp,
                                  height: 20.0.sp,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0.sp),
                                    color: AppColor.transparent,
                                    border: Border.all(
                                      color: AppColor.primaryColor,
                                      width: 2.0.sp,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColor.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 20.0.sp,
                                  height: 20.0.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0.sp),
                                    border: Border.all(
                                      color: AppColor.borderColor,
                                      width: 2.0.sp,
                                    ),
                                    color: AppColor.transparent,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.0.sp),
        Row(
          children: [
            Expanded(
              child: RejectButton(
                onPressButton: widget.onPressCancel,
                buttonText: TranslationConstants.cancel.tr,
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AcceptButton(
                onPressButton: () => widget.onPressSave?.call(_value),
                buttonText: TranslationConstants.save.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
