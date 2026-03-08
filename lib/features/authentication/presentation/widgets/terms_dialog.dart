import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/primary_button.dart';

class TermsDialog extends StatelessWidget {
  final String title;
  final String content;

  const TermsDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Container(
        padding: EdgeInsets.all(20.w),
        constraints: BoxConstraints(maxHeight: 0.7.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: AppColors.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AppIcons.close,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: AppColors.inputBorder, thickness: 1),
            SizedBox(height: 16.h),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: AppTextStyles.body.copyWith(height: 1.5),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: PrimaryButton(
                text: "Close",
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
