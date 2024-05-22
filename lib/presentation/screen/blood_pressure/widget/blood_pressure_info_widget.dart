import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enum/blood_pressure_type.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';

class BloodPressureInfoWidget extends StatelessWidget {
  const BloodPressureInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloodPressureTypesLength = BloodPressureType.values.length;

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      itemBuilder: (context, index) {
        final type = BloodPressureType.values[index];

        return Container(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
          decoration: BoxDecoration(
            color: type.color,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type.name,
                style: AppTextTheme.fw600ts16(AppColor.white),
              ),
              Text(
                type.messageRange,
                style: AppTextTheme.fw600ts16(AppColor.white),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20.sp,
        );
      },
      itemCount: bloodPressureTypesLength,
    );
  }
}
