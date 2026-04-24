import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/theme/app_colors.dart';

class FlightTimeline extends StatelessWidget {
  final FlightModel flight;

  const FlightTimeline({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    final departure = flight.firstSegment.departure;
    final arrival = flight.lastSegment.arrival;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Timeline Column
          SizedBox(
            width: 40.w,
            child: Column(
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
                SizedBox(height: 4.h),
                Container(
                  height: 100.h,
                  width: 1.5.w,
                  color: AppColors.inputBorder,
                ),
                SizedBox(height: 4.h),

                /// ARRIVAL ICON
                Container(
                  padding: EdgeInsets.all(10.w),
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
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flight.formattedDepartureTime,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${departure.name}, ${departure.code}',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12.sp,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        departure.code,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    flight.formattedDuration,
                    style: const TextStyle(color: AppColors.grey),
                  ),
                ),
                SizedBox(height: 24.h),

                /// Arrival
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flight.formattedArrivalTime,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${arrival.name}, ${arrival.code}',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12.sp,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        arrival.code,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
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
