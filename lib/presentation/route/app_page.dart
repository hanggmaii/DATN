import 'package:get/get.dart';

import '../screen/blood_pressure/blood_pressure_binding.dart';
import '../screen/blood_pressure/blood_pressure_screen.dart';
import '../screen/heart_rate/heart_rate_binding.dart';
import '../screen/heart_rate/heart_rate_screen.dart';
import '../screen/home/home_binding.dart';
import '../screen/home/home_screen.dart';
import '../screen/splash/splash_binding.dart';
import '../screen/splash/splash_screen.dart';
import '../screen/weight_bmi/weight_bmi_binding.dart';
import '../screen/weight_bmi/weight_bmi_screen.dart';
import 'app_route.dart';

class AppPage {
  AppPage._();

  static final pages = [
    GetPage(
      name: AppRoute.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoute.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoute.heartRateScreen,
      page: () => const HeartRateScreen(),
      binding: HeartRateBinding(),
    ),
    GetPage(
      name: AppRoute.bloodPressureScreen,
      page: () => const BloodPressureScreen(),
      binding: BloodPressureBinding(),
    ),
    GetPage(
      name: AppRoute.weightBmiScreen,
      page: () => const WeightBmiScreen(),
      binding: WeightBmiBinding(),
    ),
  ];
}
