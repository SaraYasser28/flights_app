import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';

import '../../../booking/logic/cubit/booking_cubit.dart';
import '../../../favorites/logic/cubit/favorites_cubit.dart';
import '../../../favorites/view/widgets/favorite_dialog.dart';

import '../../logic/cubit/flights_cubit.dart';
import '../widgets/flight_timeline.dart';
import '../widgets/experience_chip.dart';
import '../widgets/extension_tile.dart';

class FlightDetailsScreen extends StatelessWidget {
  final String flightId;
  final FlightModel? flight;

  const FlightDetailsScreen({super.key, required this.flightId, this.flight});

  @override
  Widget build(BuildContext context) {
    if (flight != null) {
      return _buildScaffold(context, flight!);
    }
    return _buildScaffold(context, null);
  }

  Widget _buildScaffold(BuildContext context, FlightModel? initialFlight) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: const CustomAppBar(
        backgroundColor: AppColors.primary,
        title: "Flight Details",
        iconColor: AppColors.white,
      ),
      body: initialFlight != null
          ? _buildContent(context, initialFlight)
          : BlocBuilder<FlightsCubit, FlightsState>(
              builder: (context, state) {
                if (state is FlightDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is FlightDetailsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is FlightDetailsLoaded) {
                  return _buildContent(context, state.flight);
                }

                return const SizedBox();
              },
            ),
    );
  }

  /// =========================
  ///  MAIN UI
  /// =========================
  Widget _buildContent(BuildContext context, FlightModel flight) {
    final amenities = flight.segments.isNotEmpty
        ? flight.segments.first.amenities
        : [];

    final travelClass = flight.firstSegment.travelClass.toUpperCase();
    final isEconomy = travelClass.contains('ECONOMY');

    return Column(
      children: [
        /// =========================
        /// AIRLINE HEADER
        /// =========================
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
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              /// FAVORITE
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final isFavorite = context.read<FavoritesCubit>().isFavorite(
                    flight.id,
                  );

                  return GestureDetector(
                    onTap: () async {
                      if (isFavorite) {
                        final confirm =
                            await FavoriteDialog.showRemoveConfirmation(
                              context,
                              fromCity: flight.firstSegment.departure.name,
                              toCity: flight.firstSegment.arrival.name,
                            );

                        if (confirm == true && context.mounted) {
                          context.read<FavoritesCubit>().removeFromFavorites(
                            flight.id,
                          );
                        }
                      } else {
                        context.read<FavoritesCubit>().addToFavorites(flight);
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

        /// =========================
        /// BODY
        /// =========================
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FlightTimeline(flight: flight),
                SizedBox(height: 16.h),

                /// EXPERIENCE
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
                        icon: isEconomy ? AppIcons.economy : AppIcons.business,
                        label: flight.firstSegment.travelClass.toUpperCase(),
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
                      if (amenities.any(
                        (a) => a.toLowerCase().contains('wi-fi'),
                      ))
                        const ExtensionTile(
                          icon: AppIcons.wifi,
                          text: "Wi-Fi available",
                        ),
                      if (amenities.any((a) => a.toLowerCase().contains('usb')))
                        const ExtensionTile(
                          icon: AppIcons.usb,
                          text: "USB outlets available",
                        ),
                      if (amenities.any(
                        (a) => a.toLowerCase().contains('video'),
                      ))
                        const ExtensionTile(
                          icon: AppIcons.video,
                          text: "On-demand entertainment",
                        ),
                      if (amenities.any(
                        (a) => a.toLowerCase().contains('meal'),
                      ))
                        const ExtensionTile(
                          icon: AppIcons.food,
                          text: "Complimentary meals",
                        ),
                      if (amenities.any(
                        (a) => a.toLowerCase().contains('legroom'),
                      ))
                        const ExtensionTile(
                          icon: AppIcons.legroom,
                          text: "Extra legroom seats",
                        ),
                      if (flight.carbonEmissionKg != null)
                        ExtensionTile(
                          icon: AppIcons.energySaver,
                          text:
                              "Carbon emissions: ${flight.carbonEmissionKg!.toStringAsFixed(0)} kg",
                          iconColor: AppColors.green,
                        ),
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
                  if (isEconomy)
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

              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  final isBooked = context.read<BookingCubit>().isFlightBooked(
                    flight.id,
                  );

                  return SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: PrimaryButton(
                      onTap: isBooked
                          ? null
                          : () {
                              Navigator.pushNamed(
                                context,
                                '/booking',
                                arguments: flight,
                              );
                            },
                      text: isBooked ? "Already Booked" : "Book Flight",
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// HELPERS
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
      case 'emirates':
        return 'Airbus A380';
      case 'lufthansa':
        return 'Airbus A320';
      case 'air france':
        return 'Boeing 777';
      default:
        return 'Airbus A319';
    }
  }
}
