import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_image.dart';
import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';
import '../widget/accept_button.dart';
import '../widget/app_image_widget.dart';
import '../widget/reject_button.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({
    super.key,
    this.icPath = AppImage.imgHeartRate,
    this.textDes = "Measure now or\nadd your record to see statistics",
    this.acceptCallback,
    this.rejectCallback,
    this.rejectText = "Set alarm",
    this.acceptText = "Add data",
  });

  final String icPath;
  final String textDes;
  final String rejectText;
  final String acceptText;
  final Function()? acceptCallback;
  final Function()? rejectCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        AppImageWidget.asset(
          path: icPath,
          width: 232.0.sp,
          height: 232.0.sp,
        ),
        Text(
          textDes,
          textAlign: TextAlign.center,
          style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
        ),
        const Spacer(),
        AcceptButton(
          onPressButton: () => acceptCallback?.call(),
          buttonText: acceptText,
        ),
        SizedBox(
          height: 12.0.sp,
        ),
        RejectButton(
          onPressButton: () => rejectCallback?.call(),
          buttonText: rejectText,
        ),
        SizedBox(
          height: 24.0.sp,
        ),
      ],
    );
  }
}
