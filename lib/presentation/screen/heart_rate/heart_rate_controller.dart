import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/enum/alarm_type.dart';
import '../../../data/model/alarm_model.dart';
import '../../../data/model/heart_rate_model.dart';
import '../../../language/app_translation.dart';
import '../../../utils/share_preference_utils.dart';
import '../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../../dialog/add_alarm_dialog.dart';
import '../../dialog/app_dialog.dart';
import '../../route/app_route.dart';
import '../../theme/app_color.dart';
import '../heart_rate_tutorial_screen.dart';
import '../home/home_controller.dart';
import 'widget/app_dialog_heart_rate_widget.dart';

class HeartRateController extends BaseController {
  final HomeController _homeController = Get.find<HomeController>();
  final AppController _appController = Get.find<AppController>();

  RxBool isLoading = false.obs;
  Rx<HeartRateModel> currentHeartRateModel = HeartRateModel().obs;
  RxInt hrAvg = 0.obs;
  RxInt hrMin = 0.obs;
  RxInt hrMax = 0.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxBool isExporting = false.obs;

  Rx<DateTime> chartMinDate = DateTime.now().obs;
  Rx<DateTime> chartMaxDate = DateTime.now().obs;
  RxDouble chartSelectedX = 0.0.obs;

  @override
  void onInit() {
    endDate.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    DateTime temp = endDate.value.subtract(const Duration(days: 7));
    startDate.value = DateTime(temp.year, temp.month, temp.day);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void _initData() async {
    isLoading.value = true;

    List<String>? heartRateDataString = SharePreferenceUtils.getStringList('heartRateData');
    if ((heartRateDataString ?? []).isNotEmpty) {
      _appController.listHeartRateModelAll = heartRateDataString!
          .map(
            (e) => HeartRateModel.fromJson(jsonDecode(e)),
          )
          .toList();
      _handleData();
    }

    isLoading.value = false;
  }

  void _handleData() {
    List<HeartRateModel> listHeartRateModelTemp = [];
    for (final item in _appController.listHeartRateModelAll) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.timeStamp ?? 0);
      if (dateTime.isAfter(startDate.value) && dateTime.isBefore(endDate.value)) {
        listHeartRateModelTemp.add(item);
      }
    }
    _appController.listHeartRateModel.value = [...listHeartRateModelTemp];
    _generateDataChart();

    if (_appController.listHeartRateModel.isNotEmpty) {
      currentHeartRateModel.value = _appController.listHeartRateModel.last;
      int t = 0;
      int min = _appController.listHeartRateModel.first.value ?? 0;
      int max = _appController.listHeartRateModel.first.value ?? 0;
      for (final item in _appController.listHeartRateModel) {
        t += (item.value ?? 0);
        if ((item.value ?? 0) < min) {
          min = item.value ?? 0;
        }
        if ((item.value ?? 0) > max) {
          max = item.value ?? 0;
        }
      }
      hrAvg.value = t ~/ _appController.listHeartRateModel.length;
      hrMin.value = min;
      hrMax.value = max;
    }
    chartSelectedX.value = 0.0;
  }

  void addHeartRateData(HeartRateModel heartRateModel) async {
    _appController.listHeartRateModelAll.add(heartRateModel);
    _handleData();
    SharePreferenceUtils.setStringList(
        'heartRateData',
        _appController.listHeartRateModelAll
            .map(
              (element) => jsonEncode(element.toJson()),
            )
            .toList());
  }

  void deleteHeartRateData(HeartRateModel heartRateModel) async {
    HeartRateModel? heartRateModelTemp = _appController.listHeartRateModelAll.firstWhereOrNull(
      (element) => element.timeStamp == heartRateModel.timeStamp,
    );

    if (heartRateModelTemp != null) {
      _appController.listHeartRateModelAll.remove(heartRateModelTemp);
    }

    _handleData();

    SharePreferenceUtils.setStringList(
        'heartRateData',
        _appController.listHeartRateModelAll
            .map(
              (element) => jsonEncode(element.toJson()),
            )
            .toList());
  }

  void onPressMeasureNow() async {
    Get.toNamed(AppRoute.measureScreen);
  }

  void onPressDateRange() async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: startDate.value,
        end: endDate.value,
      ),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            onPrimary: AppColor.white,
            primary: AppColor.red,
          ),
        ),
        child: child!,
      ),
    );

    if (result != null) {
      startDate.value = DateTime(
        result.start.year,
        result.start.month,
        result.start.day,
      );
      endDate.value = DateTime(
        result.end.year,
        result.end.month,
        result.end.day,
        23,
        59,
        59,
      );
      _handleData();
    }
  }

  void onPressAddData() async {
    await showAppDialog(
      context,
      '',
      messageText: '',
      hideGroupButton: true,
      widgetBody: AppDialogHeartRateWidget(
        allowChange: true,
        inputDateTime: DateTime.now(),
        inputValue: 70,
        onPressCancel: () {
          Get.back();
        },
        onPressAdd: (dateTime, value) async {
          _addData(dateTime, value);
        },
      ),
    );
  }

  void _addData(dateTime, value) {
    if (Get.isRegistered<HeartRateController>()) {
      Get.find<HeartRateController>().addHeartRateData(HeartRateModel(
        timeStamp: dateTime.millisecondsSinceEpoch,
        value: value,
        age: _appController.currentUser.value.age ?? 30,
        genderId: _appController.currentUser.value.genderId ?? '0',
      ));
    }

    Get.back();
    showToast(TranslationConstants.addSuccess.tr);
    // _recentBPM = 0;
  }

  void _generateDataChart() {
    List<Map> listDataChart = [];
    Map mapGroupData = groupBy(
      _appController.listHeartRateModel,
      (p0) => DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(p0.timeStamp ?? 0),
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
        HeartRateModel heartRateModelData = value[0];
        for (HeartRateModel item in value) {
          if ((item.timeStamp ?? 0) > (heartRateModelData.timeStamp ?? 0)) {
            heartRateModelData = item;
          }
        }
        listDataChart.add({'date': handleDate, 'value': heartRateModelData.value, 'timeStamp': heartRateModelData.timeStamp});
      }
    });
    _appController.chartListData.value = listDataChart;
    if (minDate != null) {
      chartMinDate.value = minDate!;
    }
    if (maxDate != null) {
      chartMaxDate.value = maxDate!;
    }
  }

  Future<void> onPressDeleteData() async {
    await showAppDialog(
      context,
      TranslationConstants.deleteData.tr,
      messageText: TranslationConstants.deleteDataConfirm.tr,
      firstButtonText: TranslationConstants.delete.tr,
      firstButtonCallback: () {
        Get.back();
        deleteHeartRateData(currentHeartRateModel.value);
      },
      secondButtonText: TranslationConstants.cancel.tr,
      secondButtonCallback: Get.back,
    );
  }

  void goToHeartRateTutorial() {
    Get.to(() => const HeartRateTutorialScreen());
  }

  void addAlarm() {
    showAddAlarm(
      context: context,
      type: AlarmType.heartRate,
      onPressCancel: () {
        Get.back();
      },
      onPressSave: (AlarmModel item) {
        _homeController.addAlarm(item);
      },
    );
  }
}
