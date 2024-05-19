import 'package:datn/presentation/dialog/delete_confirm_dialog.dart';
import 'package:get/get.dart';

import '../../../data/enum/enums.dart';
import '../../../data/model/alarm_model.dart';
import '../../../data/usecase/alarm_usecase.dart';
import '../../../language/app_translation.dart';
import '../../../utils/app_log.dart';
import '../../base/base_controller.dart';
import '../../dialog/edit_alarm.dart';
import '../../widget/snack_bar/app_snack_bar.dart';
import '../home/home_controller.dart';

class AlarmController extends BaseController {
  final HomeController _homeController = Get.find<HomeController>();
  RxList<AlarmModel> alarmList = <AlarmModel>[].obs;

  RxBool isShowBackground = false.obs;

  @override
  void onInit() {
    super.onInit();

    alarmList.value = _homeController.alarmList;
  }

  void showBackground() {
    isShowBackground.value = true;
  }

  void hideBackground() {
    isShowBackground.value = false;
  }

  void onPressDeleteAlarm(int index) {
    showDeleteConfirmDialog(context, deleteCallback: () {
      deleteAlarm(index);
    });
  }

  void deleteAlarm(int index) async {
    showLoading();

    AlarmModel alarmModel = alarmList[index];

    try {
      await AlarmUseCase.removeAlarm(alarmModel);

      refresh();

      if (context.mounted) {
        showTopSnackBar(
          context,
          message: TranslationConstants.deleteAlarmSuccess.tr,
          type: SnackBarType.done,
        );
      }
    } on Exception catch (_) {
      if (context.mounted) {
        showTopSnackBar(
          context,
          message: TranslationConstants.deleteAlarmFailed.tr,
          type: SnackBarType.error,
        );
      }
    }

    hideLoading();
  }

  void addAlarm(AlarmModel alarmModel) async {
    _homeController.addAlarm(alarmModel);
  }

  @override
  void refresh() {
    super.refresh();

    _homeController.refresh();
    alarmList.value = _homeController.alarmList;
  }

  void updateAlarm(AlarmModel alarmModel) async {
    AppLog.debug("updateAlarm.alarmModel.id: ${alarmModel.id}");

    for (final AlarmModel model in alarmList) {
      AppLog.debug("updateAlarm.model: ${model.id}");
    }

    try {
      await AlarmUseCase.updateAlarm(alarmModel);
      refresh();

      if (context.mounted) {
        showTopSnackBar(
          context,
          message: TranslationConstants.updateAlarmSuccess.tr,
          type: SnackBarType.done,
        );
      }
    } on Exception catch (_) {
      if (context.mounted) {
        showTopSnackBar(
          context,
          message: TranslationConstants.updateAlarmFailed.tr,
          type: SnackBarType.error,
        );
      }
    }
  }

  void onPressEditAlarm(AlarmModel alarmModel) {
    showEditAlarm(
      context: context,
      alarmModel: alarmModel,
      onPressSave: (alarmModel) {
        updateAlarm(alarmModel);
        Get.back();
      },
    );
  }
}
