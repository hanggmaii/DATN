import 'package:get/get.dart';

import '../../base/base_controller.dart';
import '../../route/app_route.dart';

class SplashController extends BaseController {
  @override
  void onReady() {
    super.onReady();

    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        Get.offAndToNamed(AppRoute.homeScreen);
      },
    );
  }
}
