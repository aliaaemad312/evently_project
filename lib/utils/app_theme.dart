
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';


class AppTheme{
  static final ThemeData lightTheme=ThemeData(
    primaryColor: AppColors.primaryLight,
      focusColor: AppColors.whiteBgColor,
    dividerColor: AppColors.blackColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.whiteBgColor,
      ),
      scaffoldBackgroundColor: AppColors.whiteBgColor,
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Black,
          headlineMedium: AppStyles.medium16Primary,
        headlineSmall: AppStyles.medium16White,
        titleMedium: AppStyles.medium16Black,
        bodyMedium: AppStyles.medium16Grey
      ),
    appBarTheme: AppBarTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
        ),
      backgroundColor: AppColors.primaryLight
    ),



  );

  static final ThemeData darkTheme=ThemeData(
    primaryColor: AppColors.primaryDark,
      focusColor: AppColors.primaryLight,
      dividerColor: AppColors.whiteBgColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.whiteBgColor,
      ),
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20White,
          headlineMedium: AppStyles.medium16White,
          headlineSmall: AppStyles.medium16White,
        titleMedium: AppStyles.medium16White,
          bodyMedium: AppStyles.medium16White
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
        ),
      )



  );
}