import 'package:hive/hive.dart';

import '../hive_config/hive_constants.dart';

part 'alarm_type.g.dart';

class AlarmTypeEnum {
  static AlarmType getBloodPressureTypeById(int? id) {
    if (id == null) {
      return AlarmType.heartRate;
    } else {
      return AlarmType.values.firstWhere((type) => type.id == id, orElse: () => AlarmType.heartRate);
    }
  }
}

@HiveType(typeId: HiveTypeConstants.alarmType)
enum AlarmType {
  @HiveField(0)
  heartRate,
  @HiveField(1)
  bloodPressure,
  @HiveField(2)
  bloodSugar,
  @HiveField(3)
  weightAndBMI,
}

extension AlarmTypeExtension on AlarmType {
  // String get notificationRoute {
  //   switch (this) {
  //     case AlarmType.heartRate:
  //       return AppRoute.heartBeatScreen;
  //     case AlarmType.bloodPressure:
  //       return AppRoute.bloodPressureScreen;
  //     case AlarmType.bloodSugar:
  //       return AppRoute.bloodSugar;
  //     case AlarmType.weightAndBMI:
  //       return AppRoute.weightBMI;
  //   }
  // }

  static AlarmType fromString(String str) {
    try {
      return AlarmType.values.where((element) => element.toString() == "AlarmType.$str").first;
    } on StateError catch (_) {
      return AlarmType.heartRate;
    }
  }

  int get id {
    switch (this) {
      case AlarmType.heartRate:
        return 0;
      case AlarmType.bloodPressure:
        return 1;
      case AlarmType.bloodSugar:
        return 2;
      case AlarmType.weightAndBMI:
        return 3;
    }
  }
}
