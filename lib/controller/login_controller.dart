import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

   if (username == "admin" && password == "1234") {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('logged_in', true);

  Get.offAllNamed('/main'); // langsung ke home
}
 else {
      Get.snackbar("Error", "Username / Password salah");
    }

    isLoading.value = false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
  }
}
