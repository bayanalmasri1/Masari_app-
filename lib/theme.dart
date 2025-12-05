import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.pale,
    primaryColor: AppColors.teal,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),
    textTheme: GoogleFonts.cairoTextTheme().apply(
      bodyColor: AppColors.deepNavy,
      displayColor: AppColors.deepNavy,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.deepNavy,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
      titleTextStyle: GoogleFonts.cairo(
        color: AppColors.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
  );
}
