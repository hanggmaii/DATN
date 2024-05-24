import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/model/heart_rate_model.dart';
import '../../../language/app_translation.dart';
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
import '../no_data_screen.dart';
import '../weight_bmi/widget/add_data_group_button.dart';
import 'dialog/heart_rate_option_dialog.dart';
import 'heart_rate_controller.dart';
import 'widget/app_heart_rate_chart_widget.dart';

class HeartRateScreen extends BaseScreen<HeartRateController> {
  const HeartRateScreen({super.key});

  @override
  Widget buildWidgets() {
    final AppController appController = Get.find<AppController>();

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Heart Rate",
            extendWidget: Obx(
              () => appController.listHeartRateModel.isEmpty
                  ? const SizedBox.shrink()
                  : FilterDateWidget(
                      startDate: controller.startDate.value,
                      endDate: controller.endDate.value,
                      onPressed: controller.onPressDateRange,
                    ),
            ),
          ),
          Obx(
            () => appController.listHeartRateModel.isEmpty
                ? Expanded(
                    child: NoDataScreen(
                      acceptCallback: () => showHeaderRateOptionDialog(controller.context),
                      rejectCallback: () => controller.addAlarm(),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ContainerWidget(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0.sp,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0.sp,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        TranslationConstants.average.tr,
                                        style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                                      ),
                                      SizedBox(
                                        height: 8.0.sp,
                                      ),
                                      Obx(
                                        () => Text(
                                          '${controller.hrAvg.value}',
                                          style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        TranslationConstants.min.tr,
                                        style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                                      ),
                                      SizedBox(
                                        height: 8.0.sp,
                                      ),
                                      Obx(
                                        () => Text(
                                          '${controller.hrMin.value}',
                                          style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        TranslationConstants.max.tr,
                                        style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
                                      ),
                                      SizedBox(
                                        height: 8.0.sp,
                                      ),
                                      Obx(
                                        () => Text(
                                          '${controller.hrMax.value}',
                                          style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0.sp,
                          ),
                          SizedBox(
                            height: Get.height * 0.35,
                            child: _buildChart(),
                          ),
                          SizedBox(
                            height: 16.0.sp,
                          ),
                          ContainerWidget(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0.sp,
                              vertical: 12.0.sp,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0.sp,
                            ),
                            child: Obx(() {
                              DateTime dateTime =
                                  DateTime.fromMillisecondsSinceEpoch(controller.currentHeartRateModel.value.timeStamp ?? 0);
                              int value = controller.currentHeartRateModel.value.value ?? 40;
                              String status = '';
                              Color color = AppColor.primaryColor;
                              if (value < 60) {
                                status = TranslationConstants.slow.tr;
                                color = AppColor.violet;
                              } else if (value > 100) {
                                status = TranslationConstants.fast.tr;
                                color = AppColor.red;
                              } else {
                                status = TranslationConstants.normal.tr;
                                color = AppColor.green;
                              }

                              return Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('h:mm a ').format(dateTime),
                                            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                                          ),
                                          SizedBox(height: 4.0.sp),
                                          Text(
                                            DateFormat('MMM dd, yyyy').format(dateTime),
                                            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '$value',
                                          style: AppTextTheme.fw400ts14(AppColor.primaryColor)?.copyWith(
                                            fontSize: 32.0.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '     BPM',
                                              style: AppTextTheme.fw400ts14(AppColor.defaultTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0.sp,
                                      vertical: 8.0.sp,
                                    ),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(60.0.sp),
                                    ),
                                    child: Text(
                                      status,
                                      style: AppTextTheme.fw600ts16(AppColor.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.0.sp,
                                  ),
                                  AppTouchable(
                                    width: 40.0.sp,
                                    height: 40.0.sp,
                                    padding: EdgeInsets.all(8.0.sp),
                                    onPressed: controller.onPressDeleteData,
                                    child: AppImageWidget.asset(
                                      path: AppImage.icTrash,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          SizedBox(
                            height: 48.0.sp,
                          ),
                          AddDataGroupButton(
                            acceptText: "Add data",
                            rejectText: "Set alarm",
                            acceptCallback: () => showHeaderRateOptionDialog(controller.context),
                            rejectCallback: () => controller.addAlarm(),
                          ),
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildChart() {
    return ContainerWidget(
      padding: EdgeInsets.only(
        right: 12.0.sp,
        top: 12.0.sp,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 16.0.sp,
      ),
      child: Obx(() => AppHeartRateChartWidget(
            listChartData: Get.find<AppController>().chartListData,
            minDate: controller.chartMinDate.value,
            maxDate: controller.chartMaxDate.value,
            selectedX: controller.chartSelectedX.value,
            onPressDot: (x, dateTime) {
              controller.chartSelectedX.value = x;
              HeartRateModel? checkedHeartRateModel;
              for (final item in Get.find<AppController>().chartListData) {
                if (dateTime.isAtSameMomentAs(item['date'])) {
                  checkedHeartRateModel = Get.find<AppController>()
                      .listHeartRateModelAll
                      .firstWhere((element) => item['timeStamp'] == element.timeStamp);
                  break;
                }
              }

              if (checkedHeartRateModel?.timeStamp != controller.currentHeartRateModel.value.timeStamp) {
                controller.currentHeartRateModel.value = checkedHeartRateModel!;
              }
            },
          )),
    );
  }
}
