import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/model/insight_model.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';
import '../../insight_detail_screen.dart';

class InsightWidget extends StatelessWidget {
  const InsightWidget({
    super.key,
    required this.data,
    this.showViewDetail = false,
  });

  final InsightModel data;
  final bool showViewDetail;

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: () {
        Get.to(
          () => InsightDetailScreen(data: data),
        );
      },
      margin: EdgeInsets.symmetric(
        vertical: 8.0.sp,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8.0.sp,
        horizontal: 6.0.sp,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.0.sp),
      ),
      radius: 12.0.sp,
      child: Row(
        children: [
          AppImageWidget.asset(
            path: data.icon,
            width: 44.0.sp,
            height: 44.0.sp,
          ),
          SizedBox(
            width: 12.0.sp,
          ),
          Expanded(
            child: !showViewDetail
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: AppTextTheme.fw600ts14(AppColor.defaultTextColor),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 8.0.sp,
                      ),
                      Text(
                        "View detail",
                        style: AppTextTheme.fw400ts12(AppColor.primaryColor),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
