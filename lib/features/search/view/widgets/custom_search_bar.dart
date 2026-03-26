import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onFilterTap;
  final bool isInteractive;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: isInteractive
                  ? TextField(
                      controller: controller,
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: "Search flights",
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: SvgPicture.asset(
                          AppIcons.search,
                          width: 18.w,
                          fit: BoxFit.scaleDown,
                        ),
                        border: InputBorder.none,
                      ),
                    )
                  : Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.search,
                          width: 18.w,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Search flights",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              height: 56.h,
              width: 56.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24.r),
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
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.filter,
                  width: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
