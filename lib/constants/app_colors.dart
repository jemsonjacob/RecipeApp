import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.cyanAccent;
  static const Color secondary = Colors.deepPurple;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color errorRed = Color(0xFFB3261E);

  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;

  static const lightBackground = Color(0xFFFFF8F0);
  static const darkBackground = Color(0xFF121212);

  static const darkSurface = Color(0xFF1E1E1E);
  static const darkSurfaceVariant = Color(0xFF2A2A2A);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      error: errorRed,
      surface: surfaceColor,
    ),
  );

  //dark
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.black,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
    ),
    cardColor: AppColors.darkSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
    ),
  );
}
