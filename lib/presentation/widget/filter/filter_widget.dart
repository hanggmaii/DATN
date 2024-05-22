import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_image.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../app_image_widget.dart';
import '../app_touchable.dart';

class FilterWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const FilterWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      height: 40.0.sp,
      width: Get.width,
      margin: EdgeInsets.fromLTRB(
        16.0.sp,
        12.0.sp,
        16.0.sp,
        0,
      ),
      onPressed: onPressed,
      outlinedBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(87.0.sp),
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.0.sp),
        border: Border.all(
          color: AppColor.borderColor,
          width: 1.5.sp,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.0.sp),
          AppImageWidget.asset(
            path: AppImage.icFilter,
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
