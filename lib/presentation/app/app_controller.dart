import 'dart:ui';

import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class AppController extends SuperController {
  Locale currentLocale = AppConstant.availableLocales[1];

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void updateLocale(Locale locale) {
    Get.updateLocale(locale);
    currentLocale = locale;
  }
}
