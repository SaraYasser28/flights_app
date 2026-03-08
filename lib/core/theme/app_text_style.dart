import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';

  // =========================
  // TITLE
  // =========================
  static TextStyle get title => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
    height: 37.5 / 30,
    color: AppColors.textPrimary,
  );

  // =========================
  // SUBTITLE
  // =========================
  static TextStyle get subtitle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 24 / 16,
    color: AppColors.textSecondary,
  );

  // =========================
  // INPUT LABEL
  // =========================
  static TextStyle get inputLabel => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  // =========================
  // INPUT HINT
  // =========================
  static TextStyle get inputHint => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1,
    color: AppColors.textMuted,
  );

  // =========================
  // DIVIDER TEXT
  // =========================
  static TextStyle get dividerText => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    height: 20 / 14,
    color: AppColors.textSecondary,
  );

  // =========================
  // PRIMARY LINK
  // =========================
  static TextStyle get primaryLink => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    height: 20 / 14,
    color: AppColors.primary,
  );

  // =========================
  // BODY
  // =========================
  static TextStyle get body => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );
}
