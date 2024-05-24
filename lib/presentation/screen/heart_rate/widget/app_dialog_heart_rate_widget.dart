import 'package:datn/presentation/widget/accept_button.dart';
import 'package:datn/presentation/widget/reject_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../language/app_translation.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_image.dart';
import '../../../../utils/disable_glow_behavior.dart';
import '../../../app/app_controller.dart';
import '../../../dialog/app_dialog.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';

class AppDialogHeartRateWidget extends StatefulWidget {
  final DateTime? inputDateTime;
  final int? inputValue;
  final Function()? onPressCancel;
  final Function(DateTime dateTime, int value)? onPressAdd;
  final bool? allowChange;

  const AppDialogHeartRateWidget({
    super.key,
    this.inputDateTime,
    this.inputValue,
    required this.onPressCancel,
    required this.onPressAdd,
    this.allowChange,
  });

  @override
  State<AppDialogHeartRateWidget> createState() => _AppDialogHeartRateWidgetState();
}

class _AppDialogHeartRateWidgetState extends State<AppDialogHeartRateWidget> {
  DateTime? _dateTime;
  int? _value;
  String _date = '';
  String _time = '';
  String _restingHeartRateValue = '';
  String _restingHeartRateStatus = '';
  Color _restingHeartRateColor = AppColor.primaryColor;
  String _restingHeartRateMessage = '';
  late FixedExtentScrollController fixedExtentScrollController;

  @override
  void initState() {
    _dateTime = widget.inputDateTime;
    _value = (widget.inputValue ?? 0) < AppConstant.minHeartRate
        ? AppConstant.minHeartRate
        : (widget.inputValue ?? 0) > AppConstant.maxHeartRate
            ? AppConstant.maxHeartRate
            : widget.inputValue;
    _updateDateTimeString(widget.inputDateTime);
    _updateStatusByValue(widget.inputValue ?? 0);
    fixedExtentScrollController = FixedExtentScrollController(initialItem: 30);
    super.initState();
  }

  _updateDateTimeString(DateTime? dateTime) {
    if (dateTime != null) {
      setState(() {
        _date = DateFormat('MMM dd, yyyy').format(dateTime);
        _time = DateFormat('h:mm a').format(dateTime);
      });
    }
  }

  _updateStatusByValue(int value) {
    if ((_value ?? 0) < 60) {
      _restingHeartRateValue = '< 60';
      _restingHeartRateStatus = TranslationConstants.slow.tr;
      _restingHeartRateMessage = TranslationConstants.rhSlowMessage.tr;
      _restingHeartRateColor = AppColor.violet;
    } else if ((_value ?? 0) > 100) {
      _restingHeartRateValue = '> 100';
      _restingHeartRateStatus = TranslationConstants.fast.tr;
      _restingHeartRateMessage = TranslationConstants.rhFastMessage.tr;
      _restingHeartRateColor = AppColor.red;
    } else {
      _restingHeartRateValue = '60 - 100';
      _restingHeartRateStatus = TranslationConstants.normal.tr;
      _restingHeartRateMessage = TranslationConstants.rhNormalMessage.tr;
      _restingHeartRateColor = AppColor.green;
    }
  }

  _onPressDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            onPrimary: AppColor.white,
            primary: AppColor.red,
          ),
        ),
        child: child!,
      ),
    );
    if (result != null) {
      _dateTime = DateTime(result.year, result.month, result.day, _dateTime?.hour ?? 0, _dateTime?.minute ?? 0);
      _updateDateTimeString(_dateTime);
    }
  }

  void _onPressTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _dateTime?.hour ?? 0, minute: _dateTime?.minute ?? 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            onPrimary: AppColor.white,
            primary: AppColor.red,
          ),
        ),
        child: child!,
      ),
    );

    if (result != null) {
      _dateTime = DateTime(
        _dateTime?.year ?? 2000,
        _dateTime?.month ?? 1,
        _dateTime?.day ?? 1,
        result.hour,
        result.minute,
      );
      _updateDateTimeString(_dateTime);
    }
  }

  void _onPressHint() {
    showAppDialog(
      context,
      TranslationConstants.heartRate.tr,
      messageText: '',
      firstButtonText: 'Ok',
      widgetBody: Column(
        children: [
          SizedBox(height: 8.0.sp),
          Container(
            height: 39.0.sp,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            margin: EdgeInsets.all(12.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.sp),
              color: AppColor.red,
            ),
            child: Row(
              children: [
                Text(
                  TranslationConstants.fast.tr,
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                ),
                const Spacer(),
                Text(
                  '${TranslationConstants.heartRate.tr} > 100',
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                ),
              ],
            ),
          ),
          Container(
            height: 32.0.sp,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 12.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.sp),
              color: AppColor.green,
            ),
            child: Row(
              children: [
                Text(TranslationConstants.normal.tr, style: AppTextTheme.fw600ts16(AppColor.defaultTextColor)),
                const Spacer(),
                Text('${TranslationConstants.heartRate.tr} 60 - 100', style: AppTextTheme.fw600ts16(AppColor.defaultTextColor)),
              ],
            ),
          ),
          Container(
            height: 39.0.sp,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 24.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.sp),
              color: AppColor.violet,
            ),
            child: Row(
              children: [
                Text(
                  TranslationConstants.slow.tr,
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                ),
                const Spacer(),
                Text(
                  '${TranslationConstants.heartRate.tr} < 60',
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthBar = Get.width / 4.1 * 3;

    int range = AppConstant.maxHeartRate - AppConstant.minHeartRate;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.sp, horizontal: 12.0.sp),
          child: Row(
            children: [
              AppTouchable(
                onPressed: widget.allowChange == true ? _onPressDate : null,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0.sp),
                  border: Border.all(
                    color: AppColor.borderColor,
                    width: 1.5.sp,
                  ),
                ),
                radius: 8.0.sp,
                padding: EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 12.sp,
                ),
                child: Text(
                  _date,
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                ),
              ),
              const Spacer(),
              AppTouchable(
                onPressed: widget.allowChange == true ? _onPressTime : null,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0.sp),
                  border: Border.all(
                    color: AppColor.borderColor,
                    width: 1.5.sp,
                  ),
                ),
                radius: 8.0.sp,
                padding: EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 12.sp,
                ),
                child: Text(
                  _time,
                  style: AppTextTheme.fw600ts16(AppColor.defaultTextColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.0.sp),
        widget.allowChange == true
            ? SizedBox(
                width: 100.0.sp,
                height: 140.0.sp,
                child: ScrollConfiguration(
                  behavior: DisableGlowBehavior(),
                  child: CupertinoPicker.builder(
                    scrollController: fixedExtentScrollController,
                    childCount: 180,
                    itemExtent: 60.0.sp,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _value = value + 40;
                      });
                      _updateStatusByValue(value + 40);
                    },
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: const Color(0xFFCACACA),
                            width: 2.0.sp,
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, value) {
                      Color color = AppColor.primaryColor;
                      if (value + 40 < 60) {
                        color = AppColor.violet;
                      } else if (value + 40 > 100) {
                        color = AppColor.red;
                      } else {
                        color = AppColor.green;
                      }
                      return Center(
                        child: Text(
                          '${value + 40}',
                          style: TextStyle(
                            color: color,
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.w700,
                            height: 5 / 4,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : Text(
                '${_value ?? 0}',
                style: TextStyle(
                  fontSize: 80.0.sp,
                  fontWeight: FontWeight.w700,
                  color: _restingHeartRateColor,
                  height: 5 / 4,
                ),
              ),
        SizedBox(height: 4.0.sp),
        Text(
          'BPM',
          style: TextStyle(
            fontSize: 30.0.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
            height: 37.5 / 30,
          ),
        ),
        SizedBox(height: 20.0.sp),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 8.0.sp),
          decoration: BoxDecoration(
            color: _restingHeartRateColor,
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
          child: Text(
            _restingHeartRateStatus,
            style: AppTextTheme.fw600ts16(AppColor.white),
          ),
        ),
        SizedBox(height: 32.0.sp),
        AppTouchable(
          onPressed: _onPressHint,
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
          outlinedBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0.sp),
          ),
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(9.0.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${TranslationConstants.restingHeartRate.tr} $_restingHeartRateValue',
                style: AppTextTheme.fw400ts14(AppColor.secondTextColor),
              ),
              SizedBox(width: 4.0.sp),
              Icon(
                Icons.info_outline,
                size: 18.0.sp,
                color: AppColor.secondTextColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Text(
            _restingHeartRateMessage,
            textAlign: TextAlign.center,
            style: AppTextTheme.fw400ts14(AppColor.secondTextColor)?.merge(
              const TextStyle(
                height: 17.5 / 14,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0.sp),
        SizedBox(
          width: widthBar + 20.0.sp,
          child: Row(
            children: [
              SizedBox(width: widthBar * ((_value ?? 40) - 40) / range),
              AppImageWidget.asset(
                path: AppImage.icArrowDown,
                width: 20.0.sp,
                color: _restingHeartRateColor,
              ),
            ],
          ),
        ),
        SizedBox(
          width: widthBar,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.violet,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              SizedBox(width: 2.0.sp),
              Expanded(
                flex: 2,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              SizedBox(width: 2.0.sp),
              Expanded(
                flex: 6,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0.sp),
        Row(
          children: [
            Expanded(
              child: RejectButton(
                buttonText: TranslationConstants.cancel.tr,
                onPressButton: widget.onPressCancel,
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AcceptButton(
                onPressButton: () => widget.onPressAdd!(_dateTime ?? DateTime.now(), _value ?? 0),
                buttonText: TranslationConstants.add.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
