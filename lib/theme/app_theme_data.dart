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
  textTheme: TextTheme(
    // Chips
    labelLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 17,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Title в карточке
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Subtitle в карточке
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 19,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Дата в карточке
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 17,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Title в деталке новости
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 33,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Subtitle в деталке
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 27,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Source
    labelMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 19,
      height: 1.0,
      letterSpacing: 0,
      textBaseline: TextBaseline.alphabetic,
    ),

    // Дата в деталке новости
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 19,
      height: 1.0,
      letterSpacing: 0,
    ),

    // Описание в деталке новости
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      height: 1.0,
      letterSpacing: 0,
    ),
  ),
);
