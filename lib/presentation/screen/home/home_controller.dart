import 'package:get/get.dart';

import '../../../data/model/alarm_model.dart';
import '../../../model/insight_model.dart';
import '../../../utils/insight_util.dart';
import '../../base/base_controller.dart';
import '../../route/app_route.dart';
import '../all_insight_screen.dart';

class HomeController extends BaseController {
  RxBool loadingInsight = false.obs;
  RxList<InsightModel> listInsight = RxList();

  RxList<AlarmModel> alarmList = <AlarmModel>[].obs;

  @override
  void onReady() async {
    super.onReady();

    loadingInsight.value = true;
    listInsight.value = await InsightUtil.loadInsight();
    loadingInsight.value = false;
  }

  void goToAllInsightScreen() {
    Get.to(() => const AllInsightScreen());
  }

  void goToHeartRateScreen() {
    Get.toNamed(AppRoute.heartRateScreen);
  }

  void goToBloodPressureScreen() {
    Get.toNamed(AppRoute.bloodPressureScreen);
  }

  void goToWeightBmiScreen() {
    Get.toNamed(AppRoute.weightBmiScreen);
  }

  void goToAlarmScreen() {
    Get.toNamed(AppRoute.alarmScreen);
  }
}
