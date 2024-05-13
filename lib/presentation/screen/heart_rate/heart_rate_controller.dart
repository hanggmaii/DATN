import 'package:get/get.dart';

import '../../base/base_controller.dart';
import '../heart_rate_tutorial_screen.dart';

class HeartRateController extends BaseController {
  void goToHeartRateTutorial() {
    Get.to(() => const HeartRateTutorialScreen());
  }

  void goToAddAlarm() {
    
  }
}