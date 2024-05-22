import 'package:datn/data/enum/blood_pressure_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_image.dart';
import '../../app/app_controller.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/container_widget.dart';
import '../../widget/filter/filter_date_widget.dart';
import '../../widget/home_bar_chart.dart';
import '../no_data_screen.dart';
import '../weight_bmi/widget/add_data_group_button.dart';
import 'blood_pressure_controller.dart';
import 'widget/systolic_diastolic_widget.dart';

class BloodPressureScreen extends BaseScreen<BloodPressureController> {
  const BloodPressureScreen({super.key});

  @override
  Widget buildWidgets() {
    final AppController appController = Get.find<AppController>();

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Blood pressure",
            extendWidget: Obx(
              () => FilterDateWidget(
                startDate: controller.filterStartDate.value,
                endDate: controller.filterEndDate.value,
                onPressed: () => controller.onPressDateRange(
                  controller.context,
                  callback: controller.filterBloodPressure,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.bloodPressures.isEmpty) {
                  return NoDataScreen(
                    icPath: AppImage.imgBloodPressure,
                    textDes: "Add your record to see statistics",
                    rejectCallback: () => controller.addAlarm(),
                    acceptCallback: () => controller.onAddData(),
                  );
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0.sp,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.sp,
                      ),
                      Obx(
                        () => SystolicDiastolicWidget(
                          systolicMin: controller.sysMin.value,
                          systolicMax: controller.sysMax.value,
                          diastolicMin: controller.diaMin.value,
                          diastolicMax: controller.diaMax.value,
                        ),
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      ContainerWidget(
                        padding: EdgeInsets.all(7.sp).copyWith(top: 10.sp),
                        height: 0.65 * Get.width,
                        width: double.maxFinite,
                        child: Obx(
                          () => HomeBarChart(
                            minDate: controller.chartMinDate.value,
                            maxDate: controller.chartMaxDate.value,
                            listChartData: controller.bloodPressureChartData,
                            currentSelected: controller.chartXValueSelected.value,
                            onSelectChartItem: controller.onSelectedBloodPress,
                            groupIndexSelected: controller.chartGroupIndexSelected.value,
                            minY: 10,
                            maxY: 350,
                            horizontalInterval: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0.sp,
                      ),
                      ContainerWidget(
                        child: AppTouchable(
                          radius: 10.0.sp,
                          onPressed: controller.onEdit,
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0.sp,
                              horizontal: 12.0.sp,
                            ),
                            child: Obx(
                              () => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 12.0.sp,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('hh:mm a ', appController.currentLocale.languageCode).format(
                                              DateTime.fromMillisecondsSinceEpoch(controller.bloodPressSelected.value.dateTime!),
                                            ),
                                            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                                          ),
                                          Text(
                                            DateFormat(
                                              'MMM dd, yyyy',
                                              appController.currentLocale.languageCode,
                                            ).format(
                                              DateTime.fromMillisecondsSinceEpoch(controller.bloodPressSelected.value.dateTime!),
                                            ),
                                            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0.sp,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Systolic',
                                                style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                                              ),
                                              Text(
                                                '${controller.bloodPressSelected.value.systolic}',
                                                style: AppTextTheme.fw600ts16(AppColor.primaryColor)?.copyWith(
                                                  fontSize: 24.0.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 16.0.sp,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Diastolic',
                                                style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                                              ),
                                              Text(
                                                '${controller.bloodPressSelected.value.diastolic}',
                                                style: AppTextTheme.fw600ts16(AppColor.primaryColor)?.copyWith(
                                                  fontSize: 24.0.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16.0.sp,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppTouchable(
                                          width: 40.0.sp,
                                          height: 40.0.sp,
                                          padding: EdgeInsets.all(8.0.sp),
                                          onPressed: controller.onPressDeleteData,
                                          child: AppImageWidget.asset(
                                            path: AppImage.icTrash,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.0.sp,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: controller.bloodPressSelected.value.bloodType.color,
                                            borderRadius: BorderRadius.circular(60),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6.0.sp,
                                            horizontal: 12.0.sp,
                                          ),
                                          child: Text(
                                            controller.bloodPressSelected.value.bloodType.name,
                                            style: AppTextTheme.fw600ts16(AppColor.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48.0.sp,
                      ),
                      AddDataGroupButton(
                        acceptText: "Add data",
                        rejectText: "Set alarm",
                        rejectCallback: () => controller.addAlarm(),
                        acceptCallback: () => controller.onAddData(),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
