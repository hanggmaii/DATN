import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/enum/bmi_type.dart';
import '../../../language/app_translation.dart';
import '../../../utils/app_image.dart';
import '../../app/app_controller.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/filter/filter_date_widget.dart';
import '../no_data_screen.dart';
import 'weight_bmi_controller.dart';
import 'widget/add_data_group_button.dart';
import 'widget/bmi_detail_widget.dart';
import 'widget/empty_widget.dart';
import 'widget/line_chart_title_widget.dart';

class WeightBmiScreen extends BaseScreen<WeightBmiController> {
  const WeightBmiScreen({super.key});

  @override
  Widget buildWidgets() {
    final AppController appController = Get.find<AppController>();

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Weight BMI",
            extendWidget: Obx(
              () => controller.bmiList.value.isEmpty
                  ? const SizedBox.shrink()
                  : FilterDateWidget(
                      startDate: controller.filterStartDate.value,
                      endDate: controller.filterEndDate.value,
                      onPressed: () => controller.onPressDateRange(
                        controller.context,
                        callback: controller.filterWeightBMI,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.bmiList.value.isEmpty) {
                return NoDataScreen(
                  icPath: AppImage.imgWeightBmi,
                  textDes: "Add your record to see statistics",
                  rejectCallback: () {
                    controller.addAlarm();
                  },
                  acceptCallback: () {
                    controller.onAddData();
                  },
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        if (controller.bmiList.isNotEmpty) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(top: 16.sp),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LineChartTitleWidget(
                                    title: '${TranslationConstants.weight.tr} (${controller.weightUnit.value.name})',
                                    minDate: controller.chartMinDate.value,
                                    maxDate: controller.chartMaxDate.value,
                                    listChartData: controller.weightChartListData,
                                    buildLeftTitle: _buildLeftTitleWeightChart,
                                    horizontalInterval: 50,
                                    selectedX: controller.chartSelectedX.value,
                                    spotIndex: controller.spotIndex.value,
                                    getTooltipItems: _getToolTipItems,
                                    onPressDot: (value, spotIndex, dateTime) {
                                      controller.chartSelectedX.value = value;
                                      controller.spotIndex.value = spotIndex;
                                      controller.currentBMI.value = controller.bmiList[spotIndex];
                                    },
                                    maxY: 300,
                                    minY: 10,
                                  ),
                                  SizedBox(
                                    height: 20.0.sp,
                                  ),
                                  Obx(
                                    () => BMIDetailWidget(
                                      date: DateFormat(
                                        'MMM dd, yyyy',
                                        appController.currentLocale.languageCode,
                                      ).format(DateTime.now()),
                                      time: DateFormat(
                                        'hh:mm a',
                                        appController.currentLocale.languageCode,
                                      ).format(
                                        DateTime.now(),
                                      ),
                                      bmi: controller.currentBMI.value.bmi ?? 0,
                                      weight: controller.currentBMI.value.weightKg.toInt(),
                                      height: controller.currentBMI.value.heightCm.toInt(),
                                      bmiType: controller.currentBMI.value.type,
                                      onEdit: controller.onEditBMI,
                                      onDelete: controller.onDeleteBMI,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0.sp,
                                  ),
                                  LineChartTitleWidget(
                                    title: TranslationConstants.bmi.tr,
                                    minDate: controller.chartMinDate.value,
                                    maxDate: controller.chartMaxDate.value,
                                    listChartData: controller.bmiChartListData,
                                    maxY: 50,
                                    minY: 5,
                                    buildLeftTitle: _buildLeftTitleBMIChart,
                                    getTooltipItems: _getToolTipItems,
                                    onPressDot: (value, spotIndex, date) {
                                      controller.chartSelectedX.value = value;
                                      controller.spotIndex.value = spotIndex;
                                      controller.currentBMI.value = controller.bmiList[spotIndex];
                                    },
                                    selectedX: controller.chartSelectedX.value,
                                    spotIndex: controller.spotIndex.value,
                                  ),
                                  SizedBox(
                                    height: 24.0.sp,
                                  ),
                                  AddDataGroupButton(
                                    rejectText: "Set alarm",
                                    acceptText: "Add data",
                                    rejectCallback: () {
                                      controller.addAlarm();
                                    },
                                    acceptCallback: () {
                                      controller.onAddData();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: EmptyWidget(
                              imagePath: AppImage.lottieWeightScale,
                              message: TranslationConstants.addYourRecordToSeeStatistics.tr,
                              imageWidth: 0.37 * Get.width,
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                );
              }
            }),
          )
        ],
      ),
    );
  }

  Widget _buildLeftTitleBMIChart(double value, TitleMeta mate) {
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 30:
        text = '30';
        break;
      case 35:
        text = '35';
        break;
      case 40:
        text = '40';
        break;
      case 45:
        text = '45';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(
      text,
      style: AppTextTheme.fw500ts12(AppColor.black),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLeftTitleWeightChart(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      case 250:
        text = '250';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(
      text,
      style: AppTextTheme.fw500ts12(AppColor.black),
      textAlign: TextAlign.center,
    );
  }

  List<LineTooltipItem?> _getToolTipItems(List<LineBarSpot> lineBarSpots) {
    return lineBarSpots.map((lineBarSpot) {
      final bmiMap = controller.bmiChartListData[lineBarSpot.spotIndex];
      final int bmi = bmiMap["value"];
      final BMIType bmiType = BMITypeEnum.getBMITypeByValue(bmi);
      return LineTooltipItem(
        bmiType.bmiName,
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }
}
