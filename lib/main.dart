import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'language/app_translation.dart';
import 'presentation/app/app_binding.dart';
import 'presentation/route/app_page.dart';
import 'presentation/route/app_route.dart';
import 'presentation/theme/app_theme.dart';
import 'utils/app_constants.dart';
import 'utils/share_preference_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharePreferenceUtils.init();

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
          translations: AppTranslation(),
          supportedLocales: AppConstant.availableLocales,
          locale: AppConstant.availableLocales[1],
          fallbackLocale: AppConstant.availableLocales[0],
        ),
      ),
    ),
  );
}
