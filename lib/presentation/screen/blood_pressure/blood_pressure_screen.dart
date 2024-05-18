import 'package:flutter/material.dart';

import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../no_data_screen.dart';
import 'blood_pressure_controller.dart';

class BloodPressureScreen extends BaseScreen<BloodPressureController> {
  const BloodPressureScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Column(
        children: [
          const AppHeader(
            title: "Blood pressure",
          ),
          Expanded(
            child: NoDataScreen(
              icPath: AppImage.imgBloodPressure,
              textDes: "Add your record to see statistics",
              rejectCallback: () => controller.addAlarm(),
            ),
          )
        ],
      ),
    );
  }
}
