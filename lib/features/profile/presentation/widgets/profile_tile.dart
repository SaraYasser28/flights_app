import 'package:flutter/material.dart';
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
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(icon, width: 20),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),

        if (showArrow)
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      ],
    );
  }
}
