import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_icons.dart';
import '../theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.home,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? AppColors.primary : AppColors.textMuted,
              BlendMode.srcIn,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.booked,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? AppColors.primary : AppColors.textMuted,
              BlendMode.srcIn,
            ),
          ),
          label: "Booked",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.profile,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? AppColors.primary : AppColors.textMuted,
              BlendMode.srcIn,
            ),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
