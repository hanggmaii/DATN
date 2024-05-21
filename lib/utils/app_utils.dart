import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../presentation/theme/app_color.dart';
import 'app_log.dart';

class AppUtils {
  AppUtils._();

  static Future<dynamic> parseJsonFromAsset(String assetPath) async {
    AppLog.debug("Loading from $assetPath");
    final stringData = await rootBundle.loadString(assetPath);
    return jsonDecode(stringData);
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColor.black.withOpacity(0.9),
      textColor: AppColor.white,
      fontSize: 16.0,
    );
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
