import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';
import 'app_touchable.dart';

class AppWeekdaysPicker extends StatelessWidget {
  AppWeekdaysPicker({
    super.key,

    /// must have length of 7
    List<bool>? initialWeekDays,

    /// will be ignored when @enableSelection is false
    /// and must be provided when @enableSelection is true
    this.onSelectedWeekdaysChanged,
    this.enableSelection = false,
  })  : assert(enableSelection == false || initialWeekDays!.length == 7),
        initialWeekDays = initialWeekDays ?? List<bool>.generate(7, (_) => false);

  final bool? enableSelection;
  final List<bool> initialWeekDays;
  final void Function(List<bool>)? onSelectedWeekdaysChanged;

  static const weekDayNames = ["M", "T", "W", "T", "F", "S", "S"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 302.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int index = 0; index < weekDayNames.length; index++)
            AppTouchable(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              rippleColor: AppColor.whiteTextColor,
              onPressed: enableSelection == true
                  ? () {
                      _onPressed(index);
                    }
                  : null,
              child: Column(
                children: [
                  Text(
                    weekDayNames[index],
                    style: AppTextTheme.fw600ts14(AppColor.black),
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Icon(
                    initialWeekDays[index] ? Icons.check_circle_rounded : Icons.circle_rounded,
                    size: 20.sp,
                    color: initialWeekDays[index] ? AppColor.primaryColor : AppColor.gray,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  void _onPressed(index) {
    final changedWeekDays = [...initialWeekDays];
    changedWeekDays[index] = !changedWeekDays[index];
    if (onSelectedWeekdaysChanged != null) onSelectedWeekdaysChanged!(changedWeekDays);
  }
}
