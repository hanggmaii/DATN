import 'package:datn/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/enum/blood_pressure_type.dart';
import '../../../../data/enum/enums.dart';
import '../../../../data/model/blood_pressure_model.dart';
import '../../../../data/usecase/blood_pressure_usecase.dart.dart';
import '../../../../language/app_translation.dart';
import '../../../../mixin/date_time_mixin.dart';
import '../../../app/app_controller.dart';
import '../../../dialog/app_dialog.dart';
import '../../../widget/snack_bar/app_snack_bar.dart';
import '../widget/blood_pressure_info_widget.dart';

class AddBloodPressureController extends GetxController with DateTimeMixin {
  late BuildContext context;

  RxString stringBloodPrDate = "".obs;
  RxString stringBloodPrTime = "".obs;
  Rx<BloodPressureType> bloodPressureType = BloodPressureType.normal.obs;
  RxInt systolic = 100.obs;
  RxInt diastolic = 70.obs;
  RxInt pulse = 40.obs;
  Rx<DateTime> bloodPressureDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  final _appController = Get.find<AppController>();

  BloodPressureModel? _bloodPressure;

  @override
  void onInit() {
    _updateDateTimeString(bloodPressureDate.value);

    super.onInit();
  }

  void onEdit(BloodPressureModel bloodPressureModel) {
    _bloodPressure = bloodPressureModel;
    bloodPressureDate.value = DateTime.fromMillisecondsSinceEpoch(_bloodPressure!.dateTime!);
    _updateDateTimeString(bloodPressureDate.value);
    systolic.value = _bloodPressure?.systolic ?? 0;
    diastolic.value = _bloodPressure?.diastolic ?? 0;
    bloodPressureType.value = _bloodPressure?.bloodType ?? BloodPressureType.normal;
    pulse.value = _bloodPressure?.pulse ?? 0;
  }

  _updateDateTimeString(DateTime? dateTime) {
    if (dateTime != null) {
      stringBloodPrTime.value = DateFormat(
        'h:mm a',
        _appController.currentLocale.languageCode,
      ).format(dateTime);
      stringBloodPrDate.value = DateFormat(
        'MMM dd, yyyy',
        _appController.currentLocale.languageCode,
      ).format(dateTime);
    }
  }

  void onShowBloodPressureInfo() {
    showAppDialog(
      context,
      TranslationConstants.bloodPressure.tr,
      messageText: '',
      widgetBody: const BloodPressureInfoWidget(),
      firstButtonText: TranslationConstants.ok.tr,
    );
  }

  Future onSelectBloodPressureDate() async {
    final result = await onSelectDate(context: context, initialDate: bloodPressureDate.value);
    if (result != null) {
      bloodPressureDate.value = bloodPressureDate.value.update(
        year: result.year,
        month: result.month,
        day: result.day,
      );
      _updateDateTimeString(bloodPressureDate.value);
    }
  }

  Future onSelectBloodPressureTime() async {
    final dateTime = bloodPressureDate.value;
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
    if (result != null) {
      bloodPressureDate.value = bloodPressureDate.value.update(
        hour: result.hour,
        minute: result.minute,
      );
      _updateDateTimeString(bloodPressureDate.value);
    }
  }

  void onSelectSys(int newSys) {
    final sys = newSys + 20;
    systolic.value = sys;
    if (sys < 90) {
      bloodPressureType.value = BloodPressureType.hypotension;
    } else if ((sys >= 90 && sys <= 119)) {
      bloodPressureType.value = BloodPressureType.normal;
    } else if ((sys >= 120 && sys <= 129)) {
      bloodPressureType.value = BloodPressureType.elevated;
    } else if ((sys >= 130 && sys <= 139)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage1;
    } else if ((sys >= 140 && sys <= 180)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage2;
    } else {
      bloodPressureType.value = BloodPressureType.hypertensionCrisis;
    }
  }

  void onSelectDia(int newDia) {
    final dia = newDia + 20;
    diastolic.value = dia;
    if (dia < 60) {
      bloodPressureType.value = BloodPressureType.hypotension;
    } else if ((dia >= 60 && dia <= 79)) {
      final sys = systolic.value;
      if ((sys >= 90 && sys <= 119)) {
        bloodPressureType.value = BloodPressureType.normal;
      }
      if ((sys >= 120 && sys <= 129)) {
        bloodPressureType.value = BloodPressureType.elevated;
      }
    } else if ((dia >= 80 && dia <= 89)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage1;
    } else if ((dia >= 90 && dia <= 120)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage2;
    } else {
      bloodPressureType.value = BloodPressureType.hypertensionCrisis;
    }
  }

  void onSelectPules(int newPules) {
    pulse.value = newPules + 20;
  }

  Future addBloodPressure() async {
    isLoading.value = true;
    final bloodPres = BloodPressureModel(
      key: bloodPressureDate.value.toIso8601String(),
      systolic: systolic.value,
      diastolic: diastolic.value,
      pulse: pulse.value,
      type: bloodPressureType.value.id,
      dateTime: bloodPressureDate.value.millisecondsSinceEpoch,
    );

    await BloodPressureUseCase.saveBloodPressure(bloodPres);

    isLoading.value = false;

    _showSnackBar(TranslationConstants.addDataSuccess.tr);

    Get.back(result: true);
  }

  Future<void> onSave() async {
    isLoading.value = true;
    _bloodPressure?.systolic = systolic.value;
    _bloodPressure?.diastolic = diastolic.value;
    _bloodPressure?.pulse = pulse.value;
    _bloodPressure?.type = bloodPressureType.value.id;
    _bloodPressure?.dateTime = bloodPressureDate.value.millisecondsSinceEpoch;

    await BloodPressureUseCase.saveBloodPressure(_bloodPressure!);

    isLoading.value = false;

    _showSnackBar(TranslationConstants.editDataSuccess.tr);

    Get.back(result: true);
  }

  void _showSnackBar(String message) {
    showTopSnackBar(
      context,
      message: message,
      type: SnackBarType.done,
    );
  }
}
