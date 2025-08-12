import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';

final appThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'Satoshi',
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.inactiveButton,
    secondary: Colors.white,
    onSecondary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  ),
);
