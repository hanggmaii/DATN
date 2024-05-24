import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/model/heart_rate_model.dart';
import '../../../../language/app_translation.dart';
import '../../../../utils/app_permission.dart';
import '../../../app/app_controller.dart';
import '../../../dialog/app_dialog.dart';
import '../heart_rate_controller.dart';
import '../widget/app_dialog_heart_rate_widget.dart';
import '../widget/heart_bpm.dart';

enum MeasureScreenState { idle, measuring }

class MeasureController extends GetxController {
  late BuildContext context;
  Rx<MeasureScreenState> currentMeasureScreenState = MeasureScreenState.idle.obs;
  Timer? _timer;
  RxDouble progress = 0.0.obs;
  final int totalMiniSecondsToMeasure = 20000;
  int currentMiniSecond = 0;
  RxInt bpmAverage = 0.obs;
  List<int> _listDataBPM = [];
  int _recentBPM = 0;
  final AppController _appController = Get.find<AppController>();
  bool isShowingDialog = false;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  _initTimer() {
    if (isShowingDialog) return;
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      if (currentMiniSecond >= totalMiniSecondsToMeasure) {
        currentMeasureScreenState.value = MeasureScreenState.idle;
        currentMiniSecond = 0;
        timer.cancel();
        isShowingDialog = true;
        await showAppDialog(
          context,
          '',
          messageText: '',
          hideGroupButton: true,
          widgetBody: AppDialogHeartRateWidget(
            inputDateTime: DateTime.now(),
            inputValue: _recentBPM,
            onPressCancel: () {
              Get.back();
              _recentBPM = 0;
            },
            onPressAdd: (dateTime, value) {
              if (Get.isRegistered<HeartRateController>()) {
                Get.find<HeartRateController>().addHeartRateData(
                  HeartRateModel(
                    timeStamp: dateTime.millisecondsSinceEpoch,
                    value: value,
                    age: _appController.currentUser.value.age ?? 30,
                    genderId: _appController.currentUser.value.genderId ?? '0',
                  ),
                );
              }

              Get.back();
              Get.back();

              _recentBPM = 0;
            },
          ),
        );
        isShowingDialog = false;
      } else {
        isShowingDialog = false;
        currentMiniSecond = currentMiniSecond + 200;
        progress.value = currentMiniSecond / totalMiniSecondsToMeasure;
      }
    });
  }

  void onPressStartMeasure() async {
    AppPermission.checkPermission(
      context,
      Permission.camera,
      TranslationConstants.permissionCameraDenied01.tr,
      TranslationConstants.permissionCameraSetting01.tr,
      onGrant: () async {
        currentMeasureScreenState.value = MeasureScreenState.measuring;
        _listDataBPM = [];
        bpmAverage.value = 0;
        progress.value = 0.0;
        currentMiniSecond = 0;
      },
      onDenied: () {},
      onOther: () {},
    );
  }

  void onPressStopMeasure() {
    currentMeasureScreenState.value = MeasureScreenState.idle;
    _timer?.cancel();
    Get.back();
  }

  onBPM(int value) {
    _listDataBPM.add(value);
    int t = 0;
    int c = 0;
    for (int item in _listDataBPM) {
      if (item >= 40 && item <= 220) {
        t += item;
        c++;
      }
    }
    bpmAverage.value = ((t ~/ (c == 0 ? 1 : c)) + value) ~/ 2;
    _recentBPM = bpmAverage.value;
  }

  void onRawData(SensorValue value) {
    if (value.value > 100 || value.value < 60) {
      // finger out
      _timer?.cancel();
      _timer = null;
      _listDataBPM = [];
      bpmAverage.value = 0;
      _recentBPM = 0;
      progress.value = 0.0;
      currentMiniSecond = 0;
    } else {
      // finger ok
      if (_timer == null || _timer?.isActive != true) {
        _initTimer();
      }
    }
  }
}
