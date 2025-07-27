import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'core/constants/app_strings.dart';
import 'core/di/dependency_injection.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'app.dart';
import 'core/services/notifications_service.dart';
import 'firebase_options.dart';
import 'features/onBoarding/ui/onboarding_screen.dart';

bool isOnboardingComplete = false;

Future<void> checkOnboardingComplete() async {
  isOnboardingComplete =
      await SharedPrefHelper.getBool(AppStrings.onboardingComplete) ?? false;
}

Future<void> checkCurrentThemeMode() async {
  final brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;
  await SharedPrefHelper.setData("isDarkMode", isDarkMode);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  await checkOnboardingComplete();
  await checkCurrentThemeMode();
  await NotificationService.initNotifications();
  log("🔒 Notification Permission Granted: ${NotificationService.permissionGranted}");

  Widget nextScreen = isOnboardingComplete ? MyApp() : OnboardingScreen();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppLocale.english),
        Locale(AppLocale.arabic),
        Locale(AppLocale.german),
        Locale(AppLocale.french),
        Locale(AppLocale.spanish),
        Locale(AppLocale.italian),
        Locale(AppLocale.japanese),
        Locale(AppLocale.korean),
        Locale(AppLocale.chinese),
      ],
      path: 'assets/l10n',
      saveLocale: true,
      fallbackLocale: const Locale(AppLocale.english),
      startLocale: const Locale(AppLocale.english),
      child: RootApp(nextScreen: nextScreen),
    ),
  );
}
