import 'package:collection/collection.dart';
import 'package:datn/extensions/int_extension.dart';
import 'package:datn/presentation/dialog/delete_confirm_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/enum/alarm_type.dart';
import '../../../data/enum/enums.dart';
import '../../../data/model/alarm_model.dart';
import '../../../data/model/bar_chart_data_model.dart';
import '../../../data/model/blood_pressure_model.dart';
import '../../../data/usecase/blood_pressure_usecase.dart.dart';
import '../../../language/app_translation.dart';
import '../../../mixin/date_time_mixin.dart';
import '../../base/base_controller.dart';
import '../../dialog/add_alarm_dialog.dart';
import '../../dialog/app_dialog.dart';
import '../../widget/snack_bar/app_snack_bar.dart';
import '../home/home_controller.dart';
import 'add_blood_pressure/add_blood_pressure_dialog.dart';

class BloodPressureController extends BaseController with DateTimeMixin {
  final HomeController _homeController = Get.find<HomeController>();

  final RxList<BloodPressureModel> bloodPressures = <BloodPressureModel>[].obs;
  final RxList<Map> bloodPressureChartData = <Map>[].obs;
  final RxInt sysMin = 0.obs;
  final RxInt sysMax = 0.obs;
  final RxInt diaMin = 0.obs;
  final RxInt diaMax = 0.obs;
  final RxInt chartGroupIndexSelected = 0.obs;
  final RxInt chartXValueSelected = 0.obs;
  final Rx<DateTime> chartMinDate = DateTime.now().obs;
  final Rx<DateTime> chartMaxDate = DateTime.now().obs;
  final Rx<BloodPressureModel> bloodPressSelected = BloodPressureModel().obs;

  @override
  void onInit() {
    filterEndDate.value = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      23,
      59,
      59,
    );
    DateTime temp = filterEndDate.value.subtract(
      const Duration(days: 7),
    );
    filterStartDate.value = DateTime(temp.year, temp.month, temp.day);
    filterBloodPressure();
    super.onInit();
  }

  Future<void> onAddData() async {
    final result = await showAppDialog(
      context,
      "",
      messageText: "",
      builder: (ctx) => const AddBloodPressureDialog(),
    );

    if (result != null && result) {
      filterBloodPressure();
    }
  }

  Future filterBloodPressure() async {
    bloodPressureChartData.clear();
    final result = BloodPressureUseCase.filterBloodPressureDate(
      filterStartDate.value.millisecondsSinceEpoch,
      filterEndDate.value.millisecondsSinceEpoch,
    );
    result.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    bloodPressures.value = result;

    if (bloodPressures.isNotEmpty) {
      bloodPressSelected.value = bloodPressures.last;
      chartXValueSelected.value = bloodPressSelected.value.dateTime!.getMillisecondDateFormat('dd/MM/yyyy');
      chartMinDate.value = DateTime.fromMillisecondsSinceEpoch(result.first.dateTime!);
      chartMaxDate.value = DateTime.fromMillisecondsSinceEpoch(result.last.dateTime!);
      final mapGroupData = groupBy(
        bloodPressures,
        (p0) => DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(p0.dateTime ?? 0)),
      );
      if (mapGroupData.isNotEmpty) {
        final lastKey = mapGroupData.keys.last;
        final lastValue = mapGroupData[lastKey];
        if (lastValue != null && lastValue.isNotEmpty) {
          chartGroupIndexSelected.value = (lastValue.length) - 1;
        }
      }
      mapGroupData.forEach((key, value) {
        final handleDate = DateFormat('dd/MM/yyyy').parse(key);
        final dataList = <BarChartDataModel>[];
        if (value.isNotEmpty) {
          for (final item in value) {
            sysMin.value = item.systolic ?? 0;
            sysMax.value = item.systolic ?? 0;
            diaMax.value = item.diastolic ?? 0;
            diaMin.value = item.diastolic ?? 0;
            dataList.add(BarChartDataModel(
              fromY: item.diastolic?.toDouble() ?? 0.0,
              toY: item.systolic?.toDouble() ?? 0.0,
            ));
          }
          bloodPressureChartData.add({"dateTime": handleDate.millisecondsSinceEpoch, "values": dataList});
        }
      });
    }
  }

  void onSelectedBloodPress(int dateTime, int groupIndex) {
    chartGroupIndexSelected.value = groupIndex;
    chartXValueSelected.value = dateTime;
    final tempData =
        bloodPressures.where((element) => element.dateTime!.getMillisecondDateFormat('dd/MM/yyyy') == dateTime).toList();
    if (tempData.isNotEmpty && tempData.length > groupIndex) {
      bloodPressSelected.value = tempData[groupIndex];
    }
  }

  void onPressDeleteData() {
    showDeleteConfirmDialog(context, deleteCallback: _onPressDeleteData);
  }

  void _onPressDeleteData() {
    BloodPressureUseCase.deleteBloodPressure(bloodPressSelected.value.key!);
    showTopSnackBar(
      context,
      message: TranslationConstants.deleteDataSuccess.tr,
      type: SnackBarType.done,
    );

    filterBloodPressure();
  }

  Future onEdit() async {
    final result = await showAppDialog(
      context,
      "",
      messageText: "",
      builder: (ctx) => AddBloodPressureDialog(
        bloodPressureModel: bloodPressSelected.value,
      ),
    );

    if (result != null && result) {
      filterBloodPressure();
    }
  }

  void addAlarm() {
    showAddAlarm(
      context: context,
      type: AlarmType.bloodPressure,
      onPressCancel: () {
        Get.back();
      },
      onPressSave: (AlarmModel item) {
        _homeController.addAlarm(item);
      },
    );
  }
}
