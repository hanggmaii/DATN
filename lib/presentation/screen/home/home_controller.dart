import 'package:get/get.dart';

import '../../../data/enum/enums.dart';
import '../../../data/model/alarm_model.dart';
import '../../../data/usecase/alarm_usecase.dart';
import '../../../language/app_translation.dart';
import '../../../model/insight_model.dart';
import '../../../utils/app_log.dart';
import '../../../utils/insight_util.dart';
import '../../base/base_controller.dart';
import '../../route/app_route.dart';
import '../../widget/snack_bar/app_snack_bar.dart';
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

    alarmList.value = await AlarmUseCase.getAlarms();

    loadingInsight.value = false;
  }

  void addAlarm(AlarmModel alarmModel) async {
    try {
      await AlarmUseCase.addAlarm(alarmModel);

      alarmList.add(alarmModel);

      AppLog.debug("Add alarm success");

      if (context.mounted) {
        showTopSnackBar(
          context,
          message: TranslationConstants.addAlarmSuccess.tr,
          type: SnackBarType.done,
        );
      }
    } on Exception catch (_) {
      if (context.mounted) {
        showTopSnackBar(
          context,
          message: TranslationConstants.addAlarmFailed.tr,
          type: SnackBarType.error,
        );
      }
    }
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
