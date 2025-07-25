import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }
  void _loadTheme() async {
    final theme = await SharedPreferences.getInstance();
    bool isDarkMode = theme.getBool('isDarkMode') ?? false;
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
    final theme = await SharedPreferences.getInstance();
    bool isDarkMode = state == ThemeMode.dark;
    await theme.setBool('isDarkMode', !isDarkMode);
    emit(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
