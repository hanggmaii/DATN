import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../language/app_translation.dart';
import '../../utils/disable_glow_behavior.dart';
import '../theme/app_color.dart';
import '../widget/accept_button.dart';
import '../widget/reject_button.dart';

class AppDialogAgeWidget extends StatefulWidget {
  final int? initialAge;
  final Function()? onPressCancel;
  final Function(int value)? onPressSave;

  const AppDialogAgeWidget({
    super.key,
    this.initialAge,
    this.onPressCancel,
    this.onPressSave,
  });

  @override
  State<AppDialogAgeWidget> createState() => _AppDialogAgeWidgetState();
}

class _AppDialogAgeWidgetState extends State<AppDialogAgeWidget> {
  late FixedExtentScrollController fixedExtentScrollController;
  late int _value;

  @override
  void initState() {
    fixedExtentScrollController = FixedExtentScrollController(
      initialItem: (widget.initialAge ?? 30) - 2,
    );
    _value = widget.initialAge ?? 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0.sp,
          height: 180.0.sp,
          margin: EdgeInsets.symmetric(vertical: 24.0.sp),
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: CupertinoPicker.builder(
              scrollController: fixedExtentScrollController,
              childCount: 109,
              itemExtent: 60.0.sp,
              onSelectedItemChanged: (value) {
                _value = value + 2;
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
                return Center(
                  child: Text(
                    '${value + 2}',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 40.0.sp,
                      fontWeight: FontWeight.w700,
                      height: 5 / 4,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RejectButton(
                onPressButton: widget.onPressCancel,
                buttonText: TranslationConstants.cancel.tr,
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AcceptButton(
                buttonText: TranslationConstants.save.tr,
                onPressButton: () => widget.onPressSave!(_value),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
