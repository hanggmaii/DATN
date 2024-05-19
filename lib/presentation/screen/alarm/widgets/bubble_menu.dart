import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_touchable.dart';

class Bubble {
  const Bubble({
    required this.title,
    this.iconColor,
    required this.onPress,
  });

  final Color? iconColor;
  final String title;
  final void Function() onPress;
}

class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item, {super.key});

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0.sp,
        vertical: 14.0.sp,
      ),
      margin: EdgeInsets.only(top: 12.0.sp),
      width: 180.0.sp,
      onPressed: item.onPress,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(60.0.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
          ),
        ],
      ),
    );
  }
}
