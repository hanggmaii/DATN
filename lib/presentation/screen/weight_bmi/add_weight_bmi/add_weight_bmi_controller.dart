import 'dart:math';

import 'package:datn/data/usecase/bmi_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enum/bmi_type.dart';
import '../../../../data/enum/enums.dart';
import '../../../../data/model/bmi_model.dart';
import '../../../../data/model/user_model.dart';
import '../../../../extensions/height_unit.dart';
import '../../../../extensions/weight_unit.dart';
import '../../../../language/app_translation.dart';
import '../../../../mixin/add_date_time_mixin.dart';
import '../../../../mixin/date_time_mixin.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/convert_utils.dart';
import '../../../app/app_controller.dart';
import '../../../dialog/app_dialog.dart';
import '../../../dialog/app_dialog_age_widget.dart';
import '../../../dialog/app_dialog_gender_widget.dart';
import '../../../theme/app_color.dart';
import '../../../widget/snack_bar/app_snack_bar.dart';
import '../weight_bmi_controller.dart';
import '../widget/bmi_info_widget.dart';

class AddWeightBMIController extends GetxController with AddDateTimeMixin, DateTimeMixin {
  final AppController _appController = Get.find<AppController>();
  final WeightBmiController _weightBMIController = Get.find<WeightBmiController>();

  Rx<WeightUnit> weightUnit = WeightUnit.kg.obs;
  Rx<HeightUnit> heightUnit = HeightUnit.cm.obs;

  Rx<BMIType> bmiType = BMIType.normal.obs;

  final TextEditingController cmController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inchController = TextEditingController();

  Rx<DateTime> bmiDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  RxInt bmi = 0.obs;
  BMIModel currentBMI = BMIModel();
  RxInt age = (Get.find<AppController>().currentUser.value.age ?? 30).obs;
  RxMap gender = AppConstant.listGender
      .firstWhere((element) => element['id'] == Get.find<AppController>().currentUser.value.genderId,
          orElse: () => AppConstant.listGender[0])
      .obs;

  AddWeightBMIController();

  @override
  void onInit() {
    updateDateTimeString(DateTime.now());
    weightController.text = '65.00';
    cmController.text = "170.0";
    ftController.text = '5\'';
    inchController.text = '7\'';
    caculateBMI();
    weightUnit.value = _weightBMIController.weightUnit.value;
    heightUnit.value = _weightBMIController.heightUnit.value;
    super.onInit();
  }

  void onSelectBMIDate(BuildContext context) async {
    final result = await onSelectDate(
      context: context,
      initialDate: bloodPressureDate,
      primaryColor: AppColor.primaryColor,
    );
    onSelectAddDate(result);
  }

  void onSelectBMITime(BuildContext context) async {
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(
        hour: bloodPressureDate.hour,
        minute: bloodPressureDate.minute,
      ),
    );
    onSelectAddTime(result);
  }

  // void onSelectWeightUnit() {
  //   final double weight = weightController.text.toDouble;
  //   if (weightUnit.value == WeightUnit.kg) {
  //     weightUnit.value = WeightUnit.lb;
  //     weightController.text = ConvertUtils.convertKgToLb(weight).toStringAsFixed(2);
  //   } else {
  //     weightUnit.value = WeightUnit.kg;
  //     weightController.text = ConvertUtils.convertLbToKg(weight).toStringAsFixed(2);
  //   }
  // }
  //
  // void onSelectHeightUnit() {
  //   if (heightUnit.value == HeightUnit.cm) {
  //     heightUnit.value = HeightUnit.ftIn;
  //     final heightCm = cmController.text.toDouble;
  //     ftController.text = '${ConvertUtils.convertCmToFeet(heightCm)}\'';
  //     inchController.text = '${ConvertUtils.convertCmToInches(heightCm)}\"';
  //   } else {
  //     heightUnit.value = HeightUnit.cm;
  //     final feet = ftController.text.toInt;
  //     final inches = inchController.text.toInt;
  //     cmController.text = ConvertUtils.convertFtAndInToCm(feet, inches).toStringAsFixed(2);
  //   }
  // }

  void onShowInfo(BuildContext context) {
    showAppDialog(
      context,
      '',
      messageText: '',
      builder: (context) => const BMIINfoWidget(),
    );
  }

  void onPressedAge(BuildContext context) {
    age.value = age.value < 2
        ? 2
        : age.value > 110
            ? 110
            : age.value;
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      messageText: '',
      hideGroupButton: true,
      widgetBody: AppDialogAgeWidget(
        initialAge: age.value,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(
            UserModel(
              age: value,
              genderId: _appController.currentUser.value.genderId ?? '0',
            ),
          );
          age.value = value;
        },
      ),
    );
  }

  void onPressGender(BuildContext context) {
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      messageText: '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: gender,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();

          if (value == gender) {
            return;
          }

          _appController.updateUser(
            UserModel(
              age: _appController.currentUser.value.age ?? 30,
              genderId: value['id'] ?? '0',
            ),
          );

          gender.value = value;
        },
      ),
    );
  }

  double _getWeight() {
    final weight = weightController.text;
    if (weight.isEmpty) {
      weightController.text = '0.0';
    }

    return double.parse(weightController.text.isNotEmpty ? weightController.text : '0.0');
  }

  double _getHeight() {
    if (cmController.text.isEmpty) {
      cmController.text = '0.0';
    }

    return ConvertUtils.convertCmToM(
      double.parse(cmController.text.isNotEmpty ? cmController.text : '0.0'),
    );
  }

  void caculateBMI() {
    double weight = _getWeight();
    double height = _getHeight();

    if (weight != 0 && height != 0) {
      bmi.value = (weight / pow(height, 2)).round();
    }

    bmiType.value = BMITypeEnum.getBMITypeByValue(bmi.value);
  }

  Future<void> addBMI(BuildContext context) async {
    isLoading.value = true;
    _weightBMIController.weightUnit.value = weightUnit.value;
    _weightBMIController.heightUnit.value = heightUnit.value;
    Map? initialGender =
        AppConstant.listGender.firstWhereOrNull((element) => element['id'] == (_appController.currentUser.value.genderId ?? '0'));
    final bmiDateTime = DateTime(
        bloodPressureDate.year, bloodPressureDate.month, bloodPressureDate.day, bloodPressureDate.hour, bloodPressureDate.minute);
    final bmiModel = BMIModel(
      key: bmiDateTime.toIso8601String(),
      weight: _getWeight(),
      weightUnitId: weightUnit.value.id,
      typeId: bmiType.value.id,
      dateTime: bmiDateTime.millisecondsSinceEpoch,
      age: age.value,
      height: _getHeight(),
      heightUnitId: heightUnit.value.id,
      gender: initialGender!['id'] ?? '0',
      bmi: bmi.value,
    );
    await BmiUseCase.saveBMI(bmiModel);
    isLoading.value = false;

    if (context.mounted) {
      showTopSnackBar(
        context,
        message: TranslationConstants.addDataSuccess.tr,
        type: SnackBarType.done,
      );
    }

    Get.back(result: true);
  }

  void onEdit(BMIModel bmiModel) {
    currentBMI = bmiModel;
    bloodPressureDate = DateTime.fromMillisecondsSinceEpoch(bmiModel.dateTime!);
    updateDateTimeString(bloodPressureDate);
    weightUnit.value = bmiModel.weightUnit;

    weightController.text = '${bmiModel.weightKg}';

    final height = bmiModel.heightCm;
    cmController.text = '$height';

    bmiType.value = bmiModel.type;
    age.value = bmiModel.age ?? 30;
    gender.value = AppConstant.listGender.firstWhere(
      (element) => element['id'] == bmiModel.gender,
      orElse: () => AppConstant.listGender[0],
    );
    bmi.value = bmiModel.bmi ?? 0;
  }

  Future<void> onSave(BuildContext context) async {
    isLoading.value = true;

    currentBMI.weight = _getWeight();
    currentBMI.weightUnitId = weightUnit.value.id;
    currentBMI.typeId = bmiType.value.id;
    final bmiDateTime = DateTime(
      bloodPressureDate.year,
      bloodPressureDate.month,
      bloodPressureDate.day,
      bloodPressureDate.hour,
      bloodPressureDate.minute,
    );
    currentBMI.dateTime = bmiDateTime.millisecondsSinceEpoch;
    currentBMI.age = age.value;
    currentBMI.height = _getHeight();
    currentBMI.heightUnitId = heightUnit.value.id;
    currentBMI.gender = gender['id'];
    currentBMI.bmi = bmi.value;
    await BmiUseCase.updateBMI(currentBMI);
    isLoading.value = false;

    if (context.mounted) {
      showTopSnackBar(
        context,
        message: TranslationConstants.editDataSuccess.tr,
        type: SnackBarType.done,
      );
    }

    Get.back(result: true);
  }
}
