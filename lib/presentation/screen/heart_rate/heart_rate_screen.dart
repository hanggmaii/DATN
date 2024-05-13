import 'package:datn/presentation/widget/app_header.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import '../no_data_screen.dart';
import 'dialog/heart_rate_option_dialog.dart';
import 'heart_rate_controller.dart';

class HeartRateScreen extends BaseScreen<HeartRateController> {
  const HeartRateScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Column(
        children: [
          const AppHeader(
            title: "Heart Rate",
          ),
          Expanded(
            child: NoDataScreen(
              acceptCallback: () => showHeaderRateOptionDialog(controller.context),
            ),
          )
        ],
      ),
    );
  }
}
