import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';

class BloodTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const BloodTextFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  State<StatefulWidget> createState() => _BloodTextFieldWidgetState();
}

class _BloodTextFieldWidgetState extends State<BloodTextFieldWidget> {
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if (focus.hasFocus == false) {
        if (widget.onChanged != null) {
          widget.onChanged!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double borderRadius = 8.0.sp;

    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: AppColor.borderColor,
        width: 1.0.sp,
      ),
    );

    return Material(
      color: AppColor.borderColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Center(
          child: TextFormField(
            focusNode: focus,
            controller: widget.controller,
            cursorColor: AppColor.primaryColor,
            textAlign: TextAlign.center,
            maxLines: null,
            expands: true,
            inputFormatters: widget.inputFormatters,
            style: AppTextTheme.fw400ts14(AppColor.defaultTextColor)?.copyWith(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            onChanged: (value) => widget.onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.white,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.sp,
              ),
              disabledBorder: border,
              enabledBorder: border,
              focusedBorder: border,
              border: border,
            ),
          ),
        ),
      ),
    );
  }
}
