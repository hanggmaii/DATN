import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_dialog.dart';

Future<void> showDeleteConfirmDialog(
  BuildContext context, {
  String title = "Delete Alarm",
  required Function() deleteCallback,
}) async {
  await showAppDialog(
    context,
    title,
    messageText: "Do you want to delete this alarm?",
    hideGroupButton: false,
    firstButtonText: "Delete",
    firstButtonCallback: () {
      deleteCallback.call();
      Get.back();
    },
    secondButtonText: "Cancel",
    secondButtonCallback: () {
      Get.back();
    },
  );
}
