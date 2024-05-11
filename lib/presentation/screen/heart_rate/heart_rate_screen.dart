import 'package:flutter/material.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import 'heart_rate_controller.dart';

class HeartRateScreen extends BaseScreen<HeartRateController> {
  const HeartRateScreen({super.key});

  @override
  Widget buildWidgets() {
    return const AppContainer();
  }
}