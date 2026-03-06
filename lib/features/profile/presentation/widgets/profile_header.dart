import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        children: [
          const SizedBox(height: 32),

          /// Profile Image
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 3),
            ),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(AppImages.profilePhoto),
            ),
          ),

          const SizedBox(height: 12),

          /// Gold Member
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: const Text(
              "GOLD MEMBER",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// Name
          Text(
            "John",
            style: AppTextStyles.titleWith(
              color: Colors.white,
              size: 24,
              weight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          /// Email
          Text(
            "John@traveler.com",
            style: AppTextStyles.subtitle.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
