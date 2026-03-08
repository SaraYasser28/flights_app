import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../widgets/account_card.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,

      appBar: const CustomAppBar(
        backgroundColor: AppColors.primary,
        title: "Profile",
        iconColor: AppColors.white,
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, AppRoutes.home);
          } else if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.bookings);
          }
        },
      ),

      body: Column(
        children: [
          ProfileHeader(),
          SizedBox(height: 24.h),
          AccountCard(),
        ],
      ),
    );
  }
}
