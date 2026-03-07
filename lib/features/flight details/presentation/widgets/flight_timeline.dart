import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';

class FlightTimeline extends StatelessWidget {
  const FlightTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Timeline
          Column(
            children: [
              /// DEPARTURE ICON
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.blueHue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.france,
                  width: 18,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              Container(height: 60, width: 2, color: AppColors.inputBorder),

              /// ARRIVAL ICON
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.landing,
                  width: 18,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          /// Flight Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Departure
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10:40 AM",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Charles de Gaulle Airport, Paris",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Text("CDG"),
                  ],
                ),

                const SizedBox(height: 24),

                const Center(
                  child: Text(
                    "1H 30M FLIGHT",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 24),

                /// Arrival
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10:40 AM",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Heathrow Airport, London",
                          style: TextStyle(color: Colors.grey),
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
