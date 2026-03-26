import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final String? prefixIcon;
  final bool isPassword;
  final Widget? suffix;
  final bool showLabel;

  const InputTextField({
    super.key,
    this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.suffix,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(label, style: AppTextStyles.inputLabel),
          SizedBox(height: 8.h),
        ],
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            border: Border.all(color: AppColors.inputBorder),
            borderRadius: BorderRadius.circular(24.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                SvgPicture.asset(prefixIcon!, width: 14.w),
                SizedBox(width: 16.w),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: AppTextStyles.inputHint,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(17.h),
                  ),
                ),
              ),
              ?suffix,
            ],
          ),
        ),
      ],
    );
  }
}
