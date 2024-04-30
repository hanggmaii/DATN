import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    fontFamily: AppTextTheme.fontFamily,
    brightness: Brightness.light,
    textTheme: AppTextTheme.textTheme(AppColor.defaultTextColor),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
    ),
  );
}
