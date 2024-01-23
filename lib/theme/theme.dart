import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'colors.dart';

ThemeData myTheme = ThemeData(
  primaryColor: AppColors.red,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  cardColor: AppColors.white,
  hoverColor: AppColors.primaryLightColor,
  iconTheme: const IconThemeData(color: AppColors.white, size: 24),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    elevation: 10,
    centerTitle: false,
    titleSpacing: 0,
    iconTheme: const IconThemeData(
      color: AppColors.textColor,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: AppColors.textColor,
      fontWeight: FontWeight.normal,
      fontSize: 18,
    ),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontSize: 28,
      color: AppColors.textColor,
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.bold,
    ),
  ),
  primaryTextTheme: TextTheme(
    labelLarge: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: AppColors.textColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 12,
      color: AppColors.textColor,
    ),
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: AppColors.textColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 22,
      color: AppColors.textColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: AppColors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: AppColors.textColor,
    ),
    titleMedium: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: AppColors.textColor,
    ),
    titleSmall: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: AppColors.textColor,
    ),
    bodySmall: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: AppColors.black,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.blueGrey[900]),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey[900]!.toMaterialColor(),
  ).copyWith(
    background: AppColors.backgroundColor,
    error: AppColors.red,
  ),
);
