import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/enum/enums.dart';
import '../../../utils/app_image.dart';
import '../../theme/app_color.dart';
import '../app_image_widget.dart';
import 'flash.dart';

void showTopSnackBar(
  BuildContext context, {
  SnackBarType type = SnackBarType.warning,
  required String message,
}) {
  showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          barrierDismissible: true,
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          child: AppSnackBarWidget(
            type: type,
            message: message,
          ),
        );
      });
}

class AppSnackBarWidget extends StatelessWidget {
  final SnackBarType type;
  final String message;

  const AppSnackBarWidget({
    super.key,
    this.type = SnackBarType.warning,
    required this.message,
  });

  String get iconPath {
    switch (type) {
      case SnackBarType.done:
        return AppImage.icDone;
      case SnackBarType.error:
        return AppImage.icCircleClose;
      default:
        return AppImage.icWarning;
    }
  }

  Color? get backgroundColor {
    switch (type) {
      case SnackBarType.done:
        return AppColor.green50;
      case SnackBarType.error:
        return AppColor.red50;
      default:
        return AppColor.orange50;
    }
  }

  Color? get textColor {
    switch (type) {
      case SnackBarType.done:
        return AppColor.green;
      case SnackBarType.error:
        return AppColor.red;
      default:
        return AppColor.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: backgroundColor!,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      padding: EdgeInsets.all(12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImageWidget.asset(
            path: iconPath,
            width: 20.sp,
            height: 20.sp,
            color: textColor,
          ),
          SizedBox(
            width: 12.sp,
          ),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
