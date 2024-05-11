import 'package:flutter/material.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import 'blood_pressure_controller.dart';

class BloodPressureScreen extends BaseScreen<BloodPressureController> {
  const BloodPressureScreen({super.key});

  @override
  Widget buildWidgets() {
    return const AppContainer();
  }
}
