import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/controller/splashscreen_controller.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashscreenController());

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Loading...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
