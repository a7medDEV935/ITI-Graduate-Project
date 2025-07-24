import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.nexScreen});
  final Widget nexScreen;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? Colors.grey.shade900 : Colors.grey.shade300;

    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/shopping cart.json'),
      splashIconSize: 400,
      nextScreen: nexScreen,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      backgroundColor: backgroundColor,
    );
  }
}
