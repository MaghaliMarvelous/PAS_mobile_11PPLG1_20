import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/client_network.dart';
import '../routes/routes.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  var isLoading = false.obs;

  Future<void> register() async {
    final u = usernameController.text.trim();
    final p = passwordController.text.trim();
    final fn = fullNameController.text.trim();
    final em = emailController.text.trim();

    if (u.isEmpty || fn.isEmpty || em.isEmpty || p.isEmpty) {
      Get.snackbar('Error', 'Semua field wajib diisi!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final responseMap = await ClientNetwork.registerUser(
        username: u,
        password: p,
        fullName: fn,
        email: em,
      );

      final bool status = responseMap['status'] == true;
      final String message =
          (responseMap['message'] ?? 'No message returned').toString();

      if (status) {
        final prefs = await SharedPreferences.getInstance();
        // ✅ simpan username + password
        await prefs.setString('registered_username', u);
        await prefs.setString('registered_password', p);

        Get.snackbar('Success', message,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        usernameController.clear();
        passwordController.clear();
        fullNameController.clear();
        emailController.clear();

        Get.offNamed(AppRoutes.login);
      } else {
        Get.snackbar('Error', message,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
