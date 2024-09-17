import 'package:flutter/material.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.gray1,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: const AppBarTheme(
    color: AppColors.primaryColor,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: AppColors.gray4),
    bodyText2: TextStyle(color: AppColors.gray3),
    headline1: TextStyle(
      color: AppColors.black,
      fontSize: 50,
      fontWeight: FontWeight.w500,
    ),
  ),
  colorScheme: const ColorScheme(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    surface: Colors.white,
    background: AppColors.gray1,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.black,
    onBackground: AppColors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ).copyWith(secondary: AppColors.secondaryColor),
);
