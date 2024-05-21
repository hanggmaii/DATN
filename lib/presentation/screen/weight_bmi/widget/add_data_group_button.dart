import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/accept_button.dart';
import '../../../widget/reject_button.dart';
import '../weight_bmi_controller.dart';

class AddDataGroupButton extends GetView<WeightBmiController> {
  const AddDataGroupButton({
    super.key,
    this.rejectText,
    this.acceptText,
    this.acceptCallback,
    this.rejectCallback,
  });

  final String? rejectText;
  final String? acceptText;
  final Function()? acceptCallback;
  final Function()? rejectCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            AcceptButton(
              onPressButton: () => acceptCallback?.call(),
              buttonText: acceptText ?? "Ok",
            ),
            SizedBox(
              height: 12.0.sp,
            ),
            RejectButton(
              onPressButton: () => rejectCallback?.call(),
              buttonText: rejectText ?? "Cancel",
            ),
            SizedBox(
              height: 24.0.sp,
            ),
          ],
        )
      ],
    );
  }
}
