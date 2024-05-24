import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';

class ContainerWidget extends StatelessWidget {
  final Widget? child;
  final double? radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? shadowOpacity;
  final double? width;
  final double? height;

  const ContainerWidget({
    super.key,
    this.child,
    this.radius,
    this.padding,
    this.margin,
    this.shadowOpacity,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(radius ?? 10.0.sp),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(shadowOpacity ?? 0.15),
            offset: const Offset(0, 0),
            blurRadius: 10.0.sp,
          ),
        ],
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
