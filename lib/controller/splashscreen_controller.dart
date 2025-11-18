import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), checkLoginStatus);
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    final token = prefs.getString("token");

    if (isLoggedIn && token != null && token.isNotEmpty) {
      Get.offAllNamed("/navbar");
    } else {
      Get.offAllNamed("/login");
    }
  }
}
