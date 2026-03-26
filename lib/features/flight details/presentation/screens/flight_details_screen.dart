import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/data/models/enum/flight_class.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../booking/logic/cubit/booking_cubit.dart';
import '../../../favorites/logic/cubit/favorites_cubit.dart';
import '../../../favorites/view/widgets/favorite_dialog.dart';
import '../widgets/flight_timeline.dart';
import '../widgets/experience_chip.dart';
import '../widgets/extension_tile.dart';

class FlightDetailsScreen extends StatelessWidget {
  final FlightModel flight;

  const FlightDetailsScreen({super.key, required this.flight});

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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Image.asset(
                    _getAirlineLogo(flight.airline),
                    width: 36.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.airline,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        flight.flightNumber,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white.withValues(alpha: .8),
                        ),
                      ),
                    ],
                  ),
                ),

                /// FAVORITE BUTTON
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    final isFavorite = context
                        .read<FavoritesCubit>()
                        .isFavorite(flight.id);
                    return GestureDetector(
                      onTap: () async {
                        if (isFavorite) {
                          final confirm =
                              await FavoriteDialog.showRemoveConfirmation(
                                context,
                                fromCity: flight.fromCity,
                                toCity: flight.toCity,
                              );
                          if (confirm == true && context.mounted) {
                            context.read<FavoritesCubit>().removeFromFavorites(
                              flight.id,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Removed from favorites'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          }
                        } else {
                          context.read<FavoritesCubit>().addToFavorites(
                            flight.id,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to favorites'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppIcons.favourite,
                          width: 11.w,
                          colorFilter: ColorFilter.mode(
                            isFavorite ? AppColors.red : Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          /// BODY
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FlightTimeline(flight: flight),
                  SizedBox(height: 16.h),

                  /// FLIGHT EXPERIENCE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Flight Experience",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 48.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        ExperienceChip(
                          icon: AppIcons.aeroplane,
                          label: _getAircraftType(flight.airline),
                        ),
                        SizedBox(width: 10.w),
                        ExperienceChip(
                          icon: flight.flightClass == FlightClass.business
                              ? AppIcons.business
                              : AppIcons.economy,
                          label: flight.flightClass.displayName,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  /// EXTENSIONS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Extensions",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        if (flight.amenities.contains('Wi-Fi'))
                          const ExtensionTile(
                            icon: AppIcons.wifi,
                            text: "Wi-Fi available",
                          ),
                        if (flight.amenities.contains('USB outlets'))
                          const ExtensionTile(
                            icon: AppIcons.usb,
                            text: "In-seat power & USB outlets",
                          ),
                        if (flight.amenities.contains('On-demand video'))
                          const ExtensionTile(
                            icon: AppIcons.video,
                            text: "On-demand video entertainment",
                          ),
                        if (flight.amenities.contains('Meals included'))
                          const ExtensionTile(
                            icon: AppIcons.food,
                            text: "Complimentary meals",
                          ),
                        if (flight.amenities.contains('Extra legroom'))
                          const ExtensionTile(
                            icon: AppIcons.legroom,
                            text: "Extra legroom seats",
                          ),
                        if (flight.carbonEmission != null)
                          ExtensionTile(
                            icon: AppIcons.energySaver,
                            text:
                                "Carbon emissions estimate: ${flight.carbonEmission} kg",
                            iconColor: AppColors.green,
                          ),
                        if (flight.amenities.isEmpty) ...[
                          const ExtensionTile(
                            icon: AppIcons.legroom,
                            text: "Standard legroom (31 in)",
                          ),
                          const ExtensionTile(
                            icon: AppIcons.wifi,
                            text: "Wi-Fi available for purchase",
                          ),
                          const ExtensionTile(
                            icon: AppIcons.usb,
                            text: "USB charging ports",
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          ),

          /// PRICE + BUTTON
          Container(
            padding: EdgeInsets.all(20.w),
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
                          "\$${flight.price.toStringAsFixed(2)}",
                          style: AppTextStyles.title.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (flight.flightClass == FlightClass.economy)
                      const Text(
                        "SAVER FARE",
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Book Button
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    if (state is BookingLoading) {
                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: PrimaryButton(onTap: null, text: "Loading..."),
                      );
                    }

                    final isBooked = context
                        .read<BookingCubit>()
                        .isFlightBooked(flight.id);

                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: PrimaryButton(
                        onTap: isBooked
                            ? null
                            : () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.booking,
                                  arguments: flight,
                                );
                              },
                        text: isBooked ? "Already Booked" : "Book Flight",
                        trailingIcon: !isBooked
                            ? SvgPicture.asset(
                                "assets/icons/arrow_right.svg",
                                colorFilter: const ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAirlineLogo(String airline) {
    switch (airline.toLowerCase()) {
      case 'british airways':
        return AppImages.britishAirways;
      default:
        return AppImages.britishAirways;
    }
  }

  String _getAircraftType(String airline) {
    switch (airline.toLowerCase()) {
      case 'british airways':
        return 'Airbus A319';
      case 'air france':
        return 'Boeing 777';
      case 'lufthansa':
        return 'Airbus A320';
      case 'emirates':
        return 'Airbus A380';
      default:
        return 'Airbus A319';
    }
  }
}
