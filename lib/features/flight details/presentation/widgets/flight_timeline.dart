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
                  _getAirportIcon(flight.from),
                  width: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                height: 75.h,
                width: 1.5.w,
                color: AppColors.inputBorder,
              ),
              SizedBox(height: 4),

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
                          flight.departureTime,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getAirportName(flight.from, flight.fromCity),
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                    Text(flight.from),
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    flight.duration.toUpperCase(),
                    style: const TextStyle(color: AppColors.grey),
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
                          flight.arrivalTime,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getAirportName(flight.to, flight.toCity),
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                    Text(flight.to),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAirportName(String code, String city) {
    switch (code) {
      case 'CDG':
        return 'Charles de Gaulle Airport, $city';
      case 'LHR':
        return 'Heathrow Airport, $city';
      case 'HND':
        return 'Haneda Airport, $city';
      case 'FRA':
        return 'Frankfurt Airport, $city';
      case 'DXB':
        return 'Dubai International Airport, $city';
      case 'JFK':
        return 'John F. Kennedy Airport, $city';
      case 'LAX':
        return 'Los Angeles International Airport, $city';
      case 'MAD':
        return 'Adolfo Suárez Madrid–Barajas Airport, $city';
      default:
        return '$city Airport';
    }
  }

  String _getAirportIcon(String code) {
    switch (code) {
      case 'CDG':
        return AppIcons.france;
      default:
        return AppIcons.france;
    }
  }
}
