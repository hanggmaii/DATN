import 'dart:convert';

import 'package:flutter/services.dart';

import 'app_log.dart';

class AppUtils {
  AppUtils._();

  static Future<dynamic> parseJsonFromAsset(String assetPath) async {
    AppLog.debug("Loading from $assetPath");
    final stringData = await rootBundle.loadString(assetPath);
    return jsonDecode(stringData);
  }
}
