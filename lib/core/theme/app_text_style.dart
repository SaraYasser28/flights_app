import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';

  // =========================
  // AUTH TITLE
  // =========================
  static TextStyle get authTitle => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 30,
    height: 37.5 / 30,
    color: AppColors.textPrimary,
  );

  static TextStyle authTitleWith({
    Color? color,
    double? size,
    FontWeight? weight,
  }) {
    return authTitle.copyWith(color: color, fontSize: size, fontWeight: weight);
  }

  // =========================
  // AUTH SUBTITLE
  // =========================
  static TextStyle get authSubtitle => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    color: AppColors.textSecondary,
  );

  // =========================
  // INPUT LABEL
  // =========================
  static TextStyle get inputLabel => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  // =========================
  // INPUT HINT
  // =========================
  static TextStyle get inputHint => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1,
    color: AppColors.textMuted,
  );

  // =========================
  // DIVIDER TEXT
  // =========================
  static TextStyle get dividerText => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.textSecondary,
  );

  // =========================
  // PRIMARY LINK
  // =========================
  static TextStyle get primaryLink => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.primary,
  );

  // =========================
  // BODY
  // =========================
  static TextStyle get body => const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );
}
