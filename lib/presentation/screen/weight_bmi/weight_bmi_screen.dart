import 'package:flutter/material.dart';

import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../no_data_screen.dart';
import 'weight_bmi_controller.dart';

class WeightBmiScreen extends BaseScreen<WeightBmiController> {
  const WeightBmiScreen({super.key});

  @override
  Widget buildWidgets() {
    return const AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Weight BMI",
          ),
          Expanded(
            child: NoDataScreen(
              icPath: AppImage.imgWeightBmi,
              textDes: "Add your record to see statistics",
            ),
          )
        ],
      ),
    );
  }
}
