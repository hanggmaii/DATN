import '../model/insight_model.dart';
import 'app_constants.dart';
import 'app_utils.dart';

class InsightUtil {
  InsightUtil._();

  static Future<List<InsightModel>> loadInsight() async {
    final insights = await AppUtils.parseJsonFromAsset(AppConstant.insightAsset) as List<dynamic>;
    List<InsightModel> answer = InsightModel.fromJsonArray(insights);
    return answer;
  }
}
