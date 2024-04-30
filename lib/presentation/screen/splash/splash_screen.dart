import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import 'splash_controller.dart';

class SplashScreen extends BaseScreen<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Splash screen"),
          ],
        ),
      ),
    );
  }
}
