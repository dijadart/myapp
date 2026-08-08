import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get font24BlackBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle get font18DarkBlueSemiBold => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBlue,
  );

  static TextStyle get font18DarkBlueBold => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
  );

  static TextStyle get font16WhiteSemiBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
 static TextStyle get font32WhiteBold => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static TextStyle get font14BlueSemiBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.purple,
  );

  static TextStyle get font14GrayRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.gray,
  );

  static TextStyle get font14DarkBlueMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBlue,
  );

  static TextStyle get font13GrayRegular => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.gray,
  );
  static TextStyle font14Weight600({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.textColor,
    );
  }

  static TextStyle font16Weight500({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.textColor,
    );
  }
}