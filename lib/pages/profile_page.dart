import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Center( // 👈 ini memastikan semua konten di tengah layar
        child: Column(
          mainAxisSize: MainAxisSize.min, // supaya konten pas di tengah
          crossAxisAlignment: CrossAxisAlignment.center, // horizontal center
          children: [
            // Profile photo
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://i.pinimg.com/originals/87/ea/89/87ea8952891e51553d55d90dc649bbf3.gif",
              ),
            ),
            const SizedBox(height: 16),

            // Username
            const Text(
              "Blue",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            // Email
            const Text(
              "blue@example.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Logout button
            ElevatedButton.icon(
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
          ],
        ),
      ),
    );
  }
}
