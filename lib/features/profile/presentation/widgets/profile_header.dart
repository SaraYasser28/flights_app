import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        children: [
          SizedBox(height: 32.h),

          /// Profile Image
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 3.w),
            ),
            child: CircleAvatar(
              radius: 70.r,
              backgroundImage: AssetImage(AppImages.profilePhoto),
            ),
          ),

          const SizedBox(height: 12),

          /// Gold Member
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.white, width: 2.w),
            ),
            child: Text(
              "GOLD MEMBER",
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          /// Name
          Text(
            "John",
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 4.h),

          /// Email
          Text(
            "John@traveler.com",
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
