import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';

import '../../data/model/user_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/share_preference_utils.dart';

class AppController extends SuperController {
  Locale currentLocale = AppConstant.availableLocales[1];

  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void updateLocale(Locale locale) {
    Get.updateLocale(locale);
    currentLocale = locale;
  }

  void updateUser(UserModel userModel) async {
    currentUser.value = userModel;
    SharePreferenceUtils.setString(
      'user',
      jsonEncode(userModel.toJson()),
    );
  }

  void getUser() async {
    String? stringUser = SharePreferenceUtils.getString('user');
    if ((stringUser ?? '').isNotEmpty) {
      currentUser.value = UserModel.fromJson(
        jsonDecode(stringUser!),
      );
    }
  }
}
