import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';

part 'text.dart';

part 'app_bar.dart';

class AppTheme {
  static TextTheme textTheme = _textTheme(
    fontFamily: 'SFPro',
    bodyColor: AppColors.textPrimary,
  );
  ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    fontFamily: 'SFPro',
    appBarTheme: _appBarTheme(
      textTheme: textTheme,
      iconColor: AppColors.textPrimary,
    ),
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
    ),
  );
  ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    textTheme: textTheme,
    fontFamily: 'SFPro',
    appBarTheme: _appBarTheme(textTheme: textTheme, iconColor: Colors.white),
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
    ),
  );
  static final AppTheme _instance = AppTheme._internal();

  static AppTheme get instance => _instance;

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
