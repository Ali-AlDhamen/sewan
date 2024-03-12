import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewan/theme/app_colors.dart';
import 'package:sewan/theme/design_constants.dart';

class Palette {
  static final lightModeThemeData = ThemeData(
    fontFamily: DesignConstants.fontFamily,
    scaffoldBackgroundColor: AppColors.light.background,
    primaryColor: AppColors.light.primary,
    canvasColor: Colors.transparent,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary,
      onPrimary: AppColors.light.string1,
      secondary: AppColors.light.secondary,
      onSecondary: AppColors.light.string2,
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
        color: AppColors.light.string1,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w200),
      bodyMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.light.secondary),
      labelLarge: TextStyle(fontSize: 20.sp, color: Colors.white),
      displaySmall: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w300, color: Colors.black),
      displayMedium: TextStyle(
          fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
      displayLarge: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.w900, color: Colors.black),
    ),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.light.primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.light.primary,
      foregroundColor: AppColors.light.string1,
    ),
  );

  static final darkModeThemeData = ThemeData(
    fontFamily: DesignConstants.fontFamily,
    scaffoldBackgroundColor: AppColors.dark.background,
    primaryColor: AppColors.dark.primary,
    canvasColor: Colors.transparent,
    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.primary,
      onPrimary: AppColors.dark.string1,
      secondary: AppColors.dark.secondary,
      onSecondary: AppColors.dark.string2,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.dark.string1,
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w200),
      bodyMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.dark.secondary),
      labelLarge: TextStyle(
          fontSize: 20.sp, color: const Color.fromARGB(255, 216, 216, 216)),
      displaySmall: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w300, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white),
      displayLarge: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.w900, color: Colors.white),
    ),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
  );
}
