import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_image.dart';
import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';
import '../widget/app_image_widget.dart';
import 'weight_bmi/widget/add_data_group_button.dart';

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
        AddDataGroupButton(
          acceptText: acceptText,
          rejectText: rejectText,
          acceptCallback: acceptCallback,
          rejectCallback: rejectCallback,
        ),
      ],
    );
  }
}
