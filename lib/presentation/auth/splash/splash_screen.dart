import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/auth/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return const Scaffold();
  }
}
 