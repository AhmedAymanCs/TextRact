import 'package:flutter/material.dart';
import 'package:textract/core/constants/color_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: ColorManager.indigoPrimary,
      secondary: ColorManager.purplePrimary,
      surface: ColorManager.backgroundWhite,
      onPrimary: ColorManager.textLight,
      onSecondary: ColorManager.textPrimary,
    ),
    scaffoldBackgroundColor: ColorManager.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.backgroundWhite,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorManager.textPrimary),
      titleTextStyle: TextStyle(
        color: ColorManager.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.indigoPrimary,
        foregroundColor: ColorManager.textLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.backgroundGray,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorManager.gray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: ColorManager.indigoPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorManager.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    cardTheme: CardThemeData(
      color: ColorManager.backgroundWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: ColorManager.indigoPrimary,
      secondary: ColorManager.purplePrimary,
      surface: ColorManager.backgroundSlate,
      onPrimary: ColorManager.textLight,
      onSecondary: ColorManager.textPrimary,
    ),
    scaffoldBackgroundColor: ColorManager.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.backgroundSlate,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorManager.textLight),
      titleTextStyle: TextStyle(
        color: ColorManager.textLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.indigoPrimary,
        foregroundColor: ColorManager.textLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.backgroundSlate,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorManager.gray500),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: ColorManager.indigoPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorManager.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    cardTheme: CardThemeData(
      color: ColorManager.backgroundSlate,
      elevation: 4,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
