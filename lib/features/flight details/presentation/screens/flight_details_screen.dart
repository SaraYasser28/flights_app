import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/flight_timeline.dart';
import '../widgets/experience_chip.dart';
import '../widgets/extension_tile.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        title: "Flight Details",
        iconColor: AppColors.white,
      ),

      body: Column(
        children: [
          /// AIRLINE INFO
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(AppImages.britishAirways, width: 36),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "British Airways",
                        style: AppTextStyles.titleWith(
                          color: AppColors.white,
                          size: 18,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "BA 301",
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white.withValues(alpha: .8),
                        ),
                      ),
                    ],
                  ),
                ),

                /// FAVORITE BUTTON
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.favourite,
                    width: 11,
                    colorFilter: const ColorFilter.mode(
                      AppColors.red,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// BODY
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const FlightTimeline(),

                  const SizedBox(height: 16),

                  /// FLIGHT EXPERIENCE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Flight Experience",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: const [
                        ExperienceChip(
                          icon: AppIcons.aeroplane,
                          label: "Airbus A319",
                        ),
                        SizedBox(width: 10),
                        ExperienceChip(
                          icon: AppIcons.economy,
                          label: "Economy Class",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// EXTENSIONS
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Extensions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const ExtensionTile(
                          icon: AppIcons.legroom,
                          text: "Average legroom (31 in)",
                        ),
                        const ExtensionTile(
                          icon: AppIcons.wifi,
                          text: "Wi-Fi for a fee",
                        ),
                        const ExtensionTile(
                          icon: AppIcons.usb,
                          text: "In-seat power & USB outlets",
                        ),
                        const ExtensionTile(
                          icon: AppIcons.video,
                          text: "On-demand video",
                        ),
                        ExtensionTile(
                          icon: AppIcons.energySaver,
                          text: "Carbon emissions estimate: 461 kg",
                          iconColor: AppColors.green,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

          /// PRICE + BUTTON
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TOTAL PRICE",
                          style: TextStyle(color: AppColors.grey),
                        ),
                        Text(
                          "€142.00",
                          style: AppTextStyles.title.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Text(
                      "SAVER FARE",
                      style: TextStyle(
                        color: AppColors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: PrimaryButton(
                    onTap: () {},
                    text: "Book Flight",
                    trailingIcon: SvgPicture.asset(
                      "assets/icons/arrow_right.svg",
                      colorFilter: ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
