import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      final registeredUsername = prefs.getString('registered_username');
      final registeredPassword = prefs.getString('registered_password');

      if (registeredUsername == null || registeredPassword == null) {
        Get.snackbar("Error", "Belum ada akun terdaftar");
        return;
      }

      if (username == registeredUsername && password == registeredPassword) {
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', 'dummy_token_123');

        Get.offAllNamed(AppRoutes.splash);
      } else {
        Get.snackbar("Error", "Username / Password salah");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }
}
