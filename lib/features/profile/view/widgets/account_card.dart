import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../authentication/logic/cubit/auth_cubit.dart';
import 'profile_tile.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              "ACCOUNT",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 25.h),

            /// Favorite Flights
            ProfileTile(
              icon: AppIcons.favourite,
              text: "Favorite Flights",
              color: AppColors.textPrimary,
              showArrow: true,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.favorites);
              },
            ),
            Divider(
              height: 24.h,
              color: AppColors.checkBoxBorder,
              thickness: 0.4,
            ),

            /// Logout
            ProfileTile(
              icon: AppIcons.logout,
              text: "Log Out",
              color: AppColors.red,
              showArrow: false,
              onTap: () {
                _showLogoutConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Log Out',
          style: AppTextStyles.title.copyWith(fontSize: 18.sp),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.body.copyWith(color: AppColors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().signOut();
            },
            child: Text(
              'Log Out',
              style: AppTextStyles.body.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
