import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.redHue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SvgPicture.asset(AppIcons.british, width: 15),
                  ),

                  const SizedBox(width: 8),

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: flightClass == "BUSINESS CLASS"
                      ? AppColors.orangeHue
                      : AppColors.blueHue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  flightClass,
                  style: TextStyle(
                    color: flightClass == "BUSINESS CLASS"
                        ? AppColors.orange
                        : AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

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
                    style: AppTextStyles.titleWith(
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fromCity,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    departureTime,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              /// TIMELINE
              Expanded(
                child: Column(
                  children: [
                    Text(
                      duration,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        const SizedBox(width: 8),

                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Non-stop",
                      style: AppTextStyles.primaryLink.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// TO
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    flightTo,
                    style: AppTextStyles.titleWith(
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    toCity,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 6),
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
                  SvgPicture.asset(AppIcons.calendar, width: 16),

                  const SizedBox(width: 4),

                  Text(
                    date,
                    style: AppTextStyles.dividerText.copyWith(fontSize: 12),
                  ),
                ],
              ),

              Text(
                price,
                style: AppTextStyles.titleWith(
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
