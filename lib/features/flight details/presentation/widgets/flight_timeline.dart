import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';

class FlightTimeline extends StatelessWidget {
  const FlightTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Timeline
          Column(
            children: [
              /// DEPARTURE ICON
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.blueHue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.france,
                  width: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              Container(height: 60.h, width: 2.w, color: AppColors.inputBorder),

              /// ARRIVAL ICON
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.landing,
                  width: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 16.w),

          /// Flight Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Departure
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10:40 AM",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Charles de Gaulle Airport, Paris",
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                    Text("CDG"),
                  ],
                ),

                SizedBox(height: 24.h),

                const Center(
                  child: Text(
                    "1H 30M FLIGHT",
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),

                SizedBox(height: 24.h),

                /// Arrival
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10:40 AM",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Heathrow Airport, London",
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                    Text("LHR"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
