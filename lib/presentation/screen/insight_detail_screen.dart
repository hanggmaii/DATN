import 'package:datn/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/insight_model.dart';
import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';

class InsightDetailScreen extends StatelessWidget {
  const InsightDetailScreen({
    super.key,
    required this.data,
  });

  final InsightModel data;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Detail",
          ),
          Text(
            data.title,
            style: AppTextTheme.fw600ts16(
              AppColor.defaultTextColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                16.0.sp,
                12.0.sp,
                16.0.sp,
                0,
              ),
              itemCount: data.contents.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  data.contents[index],
                  style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
