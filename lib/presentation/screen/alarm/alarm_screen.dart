import 'package:datn/presentation/widget/app_header.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import 'alarm_controller.dart';

class AlarmScreen extends BaseScreen<AlarmController> {
  const AlarmScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Alarm",
          ),
        ],
      ),
    );
  }
}
