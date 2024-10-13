import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/auth_controller.dart';
import 'package:job_nect/screens/bottom_nav_screen.dart';
import 'package:job_nect/screens/onboarding_screens/onboarding_screen.dart';
import 'package:job_nect/widgets/my_network_image.dart';

import '../../controllers/app_text_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/local_settings_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/slider_controller.dart';
import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;

  @override
  void initState() {
    initializeSettings();
    initializeAppTexts();
    moveToNextScreen();
    super.initState();
  }

  Future<void> initializeAppTexts() async {
    final bool isAppTextsSaved =
        await Get.find<LocalTextController>().checkIsTextSaved();
    if (!isAppTextsSaved) {
      await Get.find<AppTextController>().getAppTexts('en');
    }
  }

  Future<void> initializeSettings() async {
    final bool isSettingSaved =
        await Get.find<LocalSettingsController>().checkIsSettingsSaved();

    if (!isSettingSaved) {
      await Get.find<SettingsController>().getSettings();
    }
    await Get.find<SliderController>().getSlides();
    loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> moveToNextScreen() async {
    bool loggedInUser = await Get.find<AuthController>().checkAuthState();

    await Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        Get.offAll(
            loggedInUser ? const BottomNavScreen() : const OnboardingScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: loading
          ? const CupertinoActivityIndicator()
          : Center(
              child: MyNetworkImage(
                  imageUrl: LocalSettingsController.setting?.lightLogo ?? ''),
            ),
    );
  }
}
