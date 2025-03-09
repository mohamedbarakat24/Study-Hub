import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:study_hub/core/constants/colors.dart';
import 'package:study_hub/core/helpers/helper_functions.dart';
import 'package:study_hub/feature/on_bording/presentation/onboarding_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return AnimatedSplashScreen(
      duration: 2500,
      splash: dark
          ? Center(
              child: Image.asset(
                "assets/images/splash/DarkStudyhub.jpg",
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Image.asset(
                "assets/images/splash/whiteStudyhub.jpg",
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
      nextScreen: const OnboardingView(),
      splashIconSize: double.infinity,
      backgroundColor: dark ? MyColors.secondary : Colors.white,
    );
  }
}
