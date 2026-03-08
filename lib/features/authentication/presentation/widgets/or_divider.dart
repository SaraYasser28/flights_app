import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.inputBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text("OR CONTINUE WITH", style: AppTextStyles.dividerText),
        ),
        const Expanded(child: Divider(color: AppColors.inputBorder)),
      ],
    );
  }
}
