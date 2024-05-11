import 'package:flutter/material.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import 'weight_bmi_controller.dart';

class WeightBmiScreen extends BaseScreen<WeightBmiController> {
  const WeightBmiScreen({super.key});

  @override
  Widget buildWidgets() {
    return const AppContainer();
  }
}
