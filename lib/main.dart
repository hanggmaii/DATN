import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'presentation/app/app_binding.dart';
import 'presentation/route/app_page.dart';
import 'presentation/route/app_route.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AppBinding(),
          initialRoute: AppRoute.splashScreen,
          defaultTransition: Transition.fade,
          getPages: AppPage.pages,
          theme: AppTheme.theme,
          darkTheme: AppTheme.theme,
          themeMode: ThemeMode.light,
        ),
      ),
    ),
  );
}
