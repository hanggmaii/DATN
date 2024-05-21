import 'package:collection/collection.dart';
import 'package:datn/data/usecase/bmi_usecase.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/enum/alarm_type.dart';
import '../../../data/enum/enums.dart';
import '../../../data/model/alarm_model.dart';
import '../../../data/model/bmi_model.dart';
import '../../../extensions/height_unit.dart';
import '../../../extensions/weight_unit.dart';
import '../../../language/app_translation.dart';
import '../../../mixin/date_time_mixin.dart';
import '../../base/base_controller.dart';
import '../../dialog/add_alarm_dialog.dart';
import '../../dialog/app_dialog.dart';
import '../../widget/snack_bar/app_snack_bar.dart';
import '../home/home_controller.dart';
import 'add_weight_bmi/add_weight_bmi_dialog.dart';

class WeightBmiController extends BaseController with DateTimeMixin {
  final HomeController _homeController = Get.find<HomeController>();

  RxList<BMIModel> bmiList = <BMIModel>[].obs;
  Rx<BMIModel> currentBMI = BMIModel().obs;
  RxList<Map> bmiChartListData = RxList();
  RxList<Map> weightChartListData = RxList();
  Rx<DateTime> chartMinDate = DateTime.now().obs;
  Rx<DateTime> chartMaxDate = DateTime.now().obs;
  RxInt spotIndex = 0.obs;

  RxInt chartSelectedX = 0.obs;

  final Rx<WeightUnit> weightUnit = WeightUnit.kg.obs;
  final Rx<HeightUnit> heightUnit = HeightUnit.cm.obs;

  @override
  void onInit() {
    filterWeightBMI();

    super.onInit();
  }

  void addAlarm() async {
    await showAddAlarm(
      context: context,
      type: AlarmType.weightAndBMI,
      onPressCancel: () {
        Get.back();
      },
      onPressSave: (AlarmModel item) {
        _homeController.addAlarm(item);
      },
    );
  }

  void onAddData() async {
    final result = await showAppDialog(
      context,
      "",
      messageText: "",
      builder: (context) => const AddWeightBMIDialog(),
    );

    if (result ?? false) {
      filterWeightBMI();
    }
  }

  void _generateDataChart() {
    List<Map> listDataChart = [];
    List<Map> weightDataChart = [];
    Map mapGroupData = groupBy(
      bmiList,
      (p0) => DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(p0.dateTime ?? 0),
      ),
    );
    DateTime? minDate;
    DateTime? maxDate;
    mapGroupData.forEach((key, value) {
      DateTime handleDate = DateFormat('dd/MM/yyyy').parse(key);
      if (minDate == null || minDate!.isAfter(handleDate)) {
        minDate = handleDate;
      }
      if (maxDate == null || maxDate!.isBefore(handleDate)) {
        maxDate = handleDate;
      }
      if (((value ?? []) as List).isNotEmpty) {
        BMIModel bmiModel = value[0];
        for (BMIModel item in value) {
          if ((item.dateTime ?? 0) > (bmiModel.dateTime ?? 0)) {
            bmiModel = item;
          }
        }
        listDataChart.add({
          'date': handleDate,
          'value': bmiModel.bmi,
          'timeStamp': bmiModel.dateTime,
        });
        weightDataChart.add({
          'date': handleDate,
          'value': bmiModel.weightKg,
          'timeStamp': bmiModel.dateTime,
        });
      }
    });

    bmiChartListData.value = listDataChart;
    spotIndex.value = bmiChartListData.length - 1;
    weightChartListData.value = weightDataChart;
    if (minDate != null) {
      chartMinDate.value = minDate!;
    }
    if (maxDate != null) {
      chartMaxDate.value = maxDate!;
    }
  }

  void filterWeightBMI() {
    bmiList.value = BmiUseCase.filterBMI(
      filterStartDate.value.millisecondsSinceEpoch,
      filterEndDate.value.millisecondsSinceEpoch,
    );

    if (bmiList.isNotEmpty) {
      currentBMI.value = bmiList.last;
    }

    _generateDataChart();
  }

  void onDeleteBMI() async {
    await BmiUseCase.deleteBMI(currentBMI.value.key ?? '');

    filterWeightBMI();

    if (context.mounted) {
      showTopSnackBar(
        context,
        message: TranslationConstants.deleteDataSuccess.tr,
        type: SnackBarType.done,
      );
    }
  }

  void onEditBMI() async {
    final result = await showAppDialog(
      context,
      "",
      messageText: "",
      builder: (ctx) => AddWeightBMIDialog(
        bmiModel: currentBMI.value,
      ),
    );

    if (result ?? false) {
      filterWeightBMI();
    }
  }
}
