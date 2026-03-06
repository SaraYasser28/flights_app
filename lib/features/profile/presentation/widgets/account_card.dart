import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'profile_tile.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "ACCOUNT",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 25),

            /// Favorite Flights
            ProfileTile(
              icon: AppIcons.favourite,
              text: "Favorite Flights",
              color: AppColors.textPrimary,
              showArrow: true,
              onTap: () {},
            ),

            const Divider(
              height: 24,
              color: AppColors.checkBoxBorder,
              thickness: 0.4,
            ),

            /// Logout
            ProfileTile(
              icon: AppIcons.logout,
              text: "Log Out",
              color: AppColors.red,
              showArrow: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
