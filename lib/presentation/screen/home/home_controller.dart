import 'package:get/get.dart';

import '../../../model/insight_model.dart';
import '../../../utils/insight_util.dart';
import '../../base/base_controller.dart';
import '../all_insight_screen.dart';

class HomeController extends BaseController {
  RxBool loadingInsight = false.obs;
  RxList<InsightModel> listInsight = RxList();

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
}
