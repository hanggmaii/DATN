import 'package:datn/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_theme.dart';
import 'app_touchable.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
    this.buttonText = "Add data",
    this.onPressButton,
  });

  final String buttonText;
  final Function()? onPressButton;

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      width: MediaQuery.of(context).size.width * 0.65,
      onPressed: () => onPressButton?.call(),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(60.0.sp),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12.0.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: AppTextTheme.fw600ts16(Colors.white),
          ),
        ],
      ),
    );
  }
}
