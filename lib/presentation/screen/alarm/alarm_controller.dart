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

  @override
  void onInit() {
    super.onInit();

    alarmList.value = _homeController.alarmList;
  }

  void onPressDeleteAlarm(int index) {
    showDeleteConfirmDialog(context, deleteCallback: () {
      deleteAlarm(index);
    });
  }

  void deleteAlarm(int index) async {
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

    _homeController.alarmList.removeAt(index);
    alarmList.value = _homeController.alarmList;
  }

  @override
  void refresh() async {
    alarmList.value = await AlarmUseCase.getAlarms();
  }

  void addAlarm(AlarmModel alarmModel) async {
    try {
      await AlarmUseCase.addAlarm(alarmModel);

      refresh();

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
