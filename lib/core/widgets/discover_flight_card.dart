import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_icons.dart';
import '../data/models/flight_model.dart';
import '../data/models/enum/flight_class.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class DiscoverFlightCard extends StatelessWidget {
  final FlightModel flight;
  final String? bookingReference;
  final int? numberOfPassengers;
  final double? totalPrice;

  const DiscoverFlightCard({
    super.key,
    required this.flight,
    this.bookingReference,
    this.numberOfPassengers,
    this.totalPrice,
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
          /// AIRLINE ROW with Booking Info
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.airline,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (bookingReference != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          'Ref: $bookingReference',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 10.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              _buildClassBadge(),
            ],
          ),

          SizedBox(height: 16.h),

          /// ROUTE
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAirportInfo(
                code: flight.from,
                city: flight.fromCity,
                time: flight.departureTime,
              ),
              SizedBox(width: 12.w),
              Expanded(child: _buildTimeline(duration: flight.duration)),
              SizedBox(width: 12.w),
              _buildAirportInfo(
                code: flight.to,
                city: flight.toCity,
                time: flight.arrivalTime,
                alignRight: true,
              ),
            ],
          ),
          const SizedBox(height: 23),

          /// PASSENGER INFO + PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.calendar, width: 16.w),
                  SizedBox(width: 4.w),
                  Text(
                    flight.formattedDate,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 12.sp),
                  ),
                  if (numberOfPassengers != null) ...[
                    SizedBox(width: 12.w),
                    SvgPicture.asset(AppIcons.profile, width: 14.w),
                    SizedBox(width: 4.w),
                    Text(
                      '$numberOfPassengers ${numberOfPassengers == 1 ? 'passenger' : 'passengers'}',
                      style: AppTextStyles.dividerText.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalPrice != null
                        ? "\$${totalPrice!.toStringAsFixed(0)}"
                        : "\$${flight.price.toStringAsFixed(0)}",
                    style: AppTextStyles.title.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (totalPrice != null &&
                      numberOfPassengers != null &&
                      numberOfPassengers! > 1) ...[
                    Text(
                      '${flight.price.toStringAsFixed(0)} x $numberOfPassengers',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: flight.flightClass == FlightClass.business
            ? AppColors.orangeHue
            : AppColors.blueHue,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        flight.flightClass.displayName,
        style: TextStyle(
          color: flight.flightClass == FlightClass.business
              ? AppColors.orange
              : AppColors.primary,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAirportInfo({
    required String code,
    required String city,
    required String time,
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          code,
          style: AppTextStyles.title.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(city, style: AppTextStyles.dividerText.copyWith(fontSize: 12.sp)),
        SizedBox(height: 6.h),
        Text(
          time,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTimeline({required String duration}) {
    return Column(
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
                border: Border.all(color: AppColors.primary, width: 2),
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
          style: AppTextStyles.primaryLink.copyWith(fontSize: 10.sp),
        ),
      ],
    );
  }
}
