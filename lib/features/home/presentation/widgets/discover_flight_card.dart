import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class DiscoverFlightCard extends StatelessWidget {
  final String airline;
  final String flightFrom;
  final String flightTo;

  final String fromCity;
  final String toCity;

  final String departureTime;
  final String arrivalTime;

  final String duration;
  final String date;
  final String price;
  final String flightClass;

  const DiscoverFlightCard({
    super.key,
    required this.airline,
    required this.flightFrom,
    required this.flightTo,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.price,
    required this.flightClass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          /// AIRLINE ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.redHue,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: SvgPicture.asset(AppIcons.british, width: 15.w),
                  ),

                  SizedBox(width: 8.w),

                  Text(
                    airline,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              /// CLASS BADGE
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: flightClass == "BUSINESS CLASS"
                      ? AppColors.orangeHue
                      : AppColors.blueHue,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  flightClass,
                  style: TextStyle(
                    color: flightClass == "BUSINESS CLASS"
                        ? AppColors.orange
                        : AppColors.primary,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// ROUTE
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// FROM
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    flightFrom,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    fromCity,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    departureTime,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(width: 12.w),

              /// TIMELINE
              Expanded(
                child: Column(
                  children: [
                    Text(
                      duration,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            color: AppColors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        SizedBox(width: 8.w),

                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      "Non-stop",
                      style: AppTextStyles.primaryLink.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              /// TO
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    flightTo,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    toCity,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 10.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    arrivalTime,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 23),

          /// DATE + PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.calendar, width: 16.w),

                  SizedBox(width: 4.w),

                  Text(
                    date,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 12.sp),
                  ),
                ],
              ),

              Text(
                price,
                style: AppTextStyles.title.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
