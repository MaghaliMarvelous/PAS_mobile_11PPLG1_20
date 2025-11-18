import 'dart:convert';
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
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// You can call with parameters or rely on the controllers.
  Future<void> register(String username, String password, String fullName, String email) async {
    // prefer explicit args if provided, otherwise read from controllers
    final String u = username.trim().isNotEmpty ? username.trim() : usernameController.text.trim();
    final String p = password.trim().isNotEmpty ? password.trim() : passwordController.text.trim();
    final String fn = fullName.trim().isNotEmpty ? fullName.trim() : fullNameController.text.trim();
    final String em = email.trim().isNotEmpty ? email.trim() : emailController.text.trim();

    // basic validation
    if (u.isEmpty) {
      Get.snackbar('Error', 'Username tidak boleh kosong!', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.TOP);
      return;
    }
    if (fn.isEmpty) {
      Get.snackbar('Error', 'Full Name tidak boleh kosong!', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.TOP);
      return;
    }
    if (em.isEmpty) {
      Get.snackbar('Error', 'Email tidak boleh kosong!', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.TOP);
      return;
    }
    if (p.isEmpty) {
      Get.snackbar('Error', 'Password tidak boleh kosong!', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.TOP);
      return;
    }
    if (!em.contains('@') || !em.contains('.')) {
      Get.snackbar('Error', 'Format email tidak valid!', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.TOP);
      return;
    }

    print('=== Data sebelum dikirim ===');
    print('Username: "$u" (length: ${u.length})');
    print('Password: "${'*' * (p.length)}" (length: ${p.length})');
    print('Full Name: "$fn" (length: ${fn.length})');
    print('Email: "$em" (length: ${em.length})');
    print('============================');

    isLoading.value = true;

    try {
      dynamic raw;
      // Try calling registerUser with arguments; if that method signature differs, fallback to original usage.
      try {
        raw = await ClientNetwork.registerUser;
      } on NoSuchMethodError catch (_) {
        // fallback: maybe registerUser is a getter that already returns a Future/Map
        raw = await ClientNetwork.registerUser;
      }

      // Normalize raw response into Map<String, dynamic>
      Map<String, dynamic> responseMap;
      if (raw == null) {
        responseMap = {'status': false, 'message': 'Null response from server'};
      } else if (raw is Map) {
        responseMap = Map<String, dynamic>.from(raw);
      } else if (raw is String) {
        try {
          final parsed = jsonDecode(raw);
          if (parsed is Map) {
            responseMap = Map<String, dynamic>.from(parsed);
          } else {
            responseMap = {'status': false, 'message': 'Unexpected JSON structure', 'raw': parsed.toString()};
          }
        } catch (e) {
          responseMap = {'status': false, 'message': 'Invalid JSON response', 'raw': raw};
        }
      } else {
        // any other type -> stringify for debugging
        responseMap = {'status': false, 'message': 'Unexpected response type: ${raw.runtimeType}', 'raw': raw.toString()};
      }

      // Debug output
      print('Register response full: $responseMap');

      final bool status = responseMap['status'] == true;
      final String message = (responseMap['message'] ?? 'No message returned').toString();

      if (status) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('registered_email', em);

        Get.snackbar(
          'Success',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

        // Clear inputs
        usernameController.clear();
        passwordController.clear();
        fullNameController.clear();
        emailController.clear();

        // navigate to login (ensure route is defined in GetMaterialApp)
        Get.offNamed(AppRoutes.login);
      } else {
        Get.snackbar(
          'Error',
          message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e, st) {
      print('Register error caught: $e\n$st');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
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