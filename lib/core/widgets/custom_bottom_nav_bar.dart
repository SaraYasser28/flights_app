import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_icons.dart';

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
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.booked),
          label: "Booked",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.profile),
          label: "Profile",
        ),
      ],
    );
  }
}
