import 'package:flights_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExtensionTile extends StatelessWidget {
  final String icon;
  final String text;
  final Color? iconColor;

  const ExtensionTile({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              iconColor ?? AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
