import 'package:flights_app/core/constants/app_icons.dart';
import 'package:flights_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String? title;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Color iconColor;

  const CustomAppBar({
    super.key,
    required this.backgroundColor,
    this.title,
    this.centerTitle = true,
    this.showBackButton = true,
    this.onBack,
    this.iconColor = AppColors.backIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      leading: showBackButton
          ? IconButton(
              icon: SvgPicture.asset(
                AppIcons.backIcon,
                width: 16.w,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.title.copyWith(
                color: iconColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
