import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.showArrow,
    required this.onTap,
  });

  final String icon;
  final String text;
  final Color color;
  final bool showArrow;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(icon, width: 20.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.body.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            if (showArrow)
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
