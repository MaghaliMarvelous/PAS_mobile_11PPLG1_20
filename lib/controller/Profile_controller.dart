import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';

class ProfileController extends StatelessWidget {
  const ProfileController({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.logout),
          label: const Text(
            "Logout",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            loginCtrl.logout();
          },
        ),
      ),
    );
  }
}
