import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/disable_glow_behavior.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';

class ScrollBloodPressureValueWidget extends StatelessWidget {
  final Function(int) onSelectedItemChanged;
  final Widget Function(BuildContext context, int value) itemBuilder;
  final String title;
  final int childCount;
  final int? initItem;

  const ScrollBloodPressureValueWidget({
    super.key,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    required this.title,
    required this.childCount,
    this.initItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            title,
            style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
          ),
        ),
        SizedBox(
          height: 18.sp,
        ),
        SizedBox(
          width: 100.0.sp,
          height: 140.0.sp,
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: CupertinoPicker.builder(
              scrollController: FixedExtentScrollController(initialItem: initItem ?? 20),
              childCount: childCount,
              itemExtent: 60.0.sp,
              onSelectedItemChanged: onSelectedItemChanged,
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: const Color(0xFFCACACA), width: 2.0.sp),
                  ),
                ),
              ),
              itemBuilder: itemBuilder,
            ),
          ),
        ),
      ],
    );
  }
}
