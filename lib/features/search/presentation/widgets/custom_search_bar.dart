import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          /// SEARCH
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.search, width: 18),
                  const SizedBox(width: 10),
                  const Text("Search flights"),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// FILTER BUTTON
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.buttonShadow,
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: AppColors.buttonShadow,
                  offset: Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Center(child: SvgPicture.asset(AppIcons.filter, width: 20)),
          ),
        ],
      ),
    );
  }
}
