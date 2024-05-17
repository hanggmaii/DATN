import '../../utils/app_config.dart';
import '../../utils/share_preference_utils.dart';
import '../hive_config/hive_config.dart';
import '../hive_config/hive_constants.dart';
import '../model/alarm_model.dart';
import '../model/blood_pressure_model.dart';
import '../model/bmi_model.dart';
import '../model/user_model.dart';

class LocalRepository {
  LocalRepository._();

  static Future<void> saveUser(UserModel user) async {
    await HiveConfig.userBox?.put(HiveKey.userModel, user);
  }

  static UserModel? getUser() {
    return HiveConfig.userBox?.get(HiveKey.userModel);
  }

  static List<AlarmModel> getAlarms() {
    return HiveConfig.alarmBox?.values.toList() ?? [];
  }

  static Future<void> removeAlarm(AlarmModel alarmModel) async {
    var alarmList = HiveConfig.alarmBox?.values.toList();
    var index = alarmList?.indexWhere((element) => element.id == alarmModel.id);

    if (index != null) {
      await HiveConfig.alarmBox?.deleteAt(index);
    }
  }

  static Future<int> addAlarm(AlarmModel alarmModel) async {
    int value = await HiveConfig.alarmBox?.add(alarmModel) ?? 0;
    return value;
  }

  static Future<void> updateAlarm(AlarmModel alarmModel) async {
    final alarmList = HiveConfig.alarmBox?.values.toList();
    final index = alarmList?.indexWhere((element) => element.id == alarmModel.id);

    if (index != null) {
      await HiveConfig.alarmBox?.putAt(index, alarmModel);
    }
  }

  static Future<void> saveBloodPressure(BloodPressureModel bloodPressureModel) async {
    await HiveConfig.bloodPressureBox?.put(bloodPressureModel.key, bloodPressureModel);
  }

  static Future<void> deleteBloodPressure(String key) async {
    await HiveConfig.bloodPressureBox?.delete(key);
  }

  static List<BloodPressureModel> getAll() {
    return HiveConfig.bloodPressureBox?.values.toList() ?? [];
  }

  static List<BloodPressureModel> filterBloodPressureDate(int start, int end) {
    return HiveConfig.bloodPressureBox?.values
            .where((bloodPress) => bloodPress.dateTime! >= start && bloodPress.dateTime! <= end)
            .toList() ??
        [];
  }

  static Future saveBMIModel(BMIModel bmi) async {
    await HiveConfig.bmiBox?.put(bmi.key, bmi);
  }

  static List<BMIModel> filterBMI(int start, int end) {
    return HiveConfig.bmiBox?.values.where((bmi) => bmi.dateTime! >= start && bmi.dateTime! <= end).toList() ?? [];
  }

  static List<BMIModel> getAllBMI() => HiveConfig.bmiBox?.values.toList() ?? [];

  static Future<bool> setWeightUnitId(int id) => SharePreferenceUtils.setInt(AppConfig.weightUnitIdKey, id);

  static int? getWeightUnitId() => SharePreferenceUtils.getInt(AppConfig.weightUnitIdKey);

  static Future<bool> setHeightUnitId(int id) => SharePreferenceUtils.setInt(AppConfig.heightUnitIdKey, id);

  static int? getHeightUnitId() => SharePreferenceUtils.getInt(AppConfig.heightUnitIdKey);

  static Future<void> updateBMI(BMIModel bmi) async {
    await HiveConfig.bmiBox?.put(bmi.key, bmi);
  }

  static Future<void> deleteBMI(String key) async {
    await HiveConfig.bmiBox?.delete(key);
  }

  static bool getAllowHeartRateFirstTime() {
    return SharePreferenceUtils.getBool("allowHeartRateFirstTime") ?? true;
  }

  static bool getAllowBloodPressureFirstTime() {
    return SharePreferenceUtils.getBool("allowBloodPressureFirstTime") ?? true;
  }

  static bool getAllowBloodSugarFirstTime() {
    return SharePreferenceUtils.getBool("allowBloodSugarFirstTime") ?? true;
  }

  static bool getAllowWeightAndBMIFirstTime() {
    return SharePreferenceUtils.getBool("allowWeightAndBMIFirstTime") ?? true;
  }

  static Future<bool> setAllowHeartRateFirstTime(bool value) async {
    return await SharePreferenceUtils.setBool("allowHeartRateFirstTime", value);
  }

  static Future<bool> setAllowBloodPressureFirstTime(bool value) async {
    return await SharePreferenceUtils.setBool("allowBloodPressureFirstTime", value);
  }

  static Future<bool> setAllowBloodSugarFirstTime(bool value) async {
    return await SharePreferenceUtils.setBool("allowBloodSugarFirstTime", value);
  }

  static Future<bool> setAllowWeightAndBMIFirstTime(bool value) async {
    return await SharePreferenceUtils.setBool("allowWeightAndBMIFirstTime", value);
  }
}
