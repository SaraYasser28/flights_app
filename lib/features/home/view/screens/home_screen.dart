import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/discover_flight_card.dart';
import '../../../authentication/logic/cubit/auth_cubit.dart';
import '../../../favorites/logic/cubit/favorites_cubit.dart';
import '../../../favorites/view/widgets/favorite_dialog.dart';
import '../../../favorites/view/widgets/favorite_flight_card.dart';
import '../../../flight details/logic/cubit/flights_cubit.dart';
import '../../../search/view/widgets/custom_search_bar.dart';
import '../../../../core/data/models/flight_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.bookings);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.profile);
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String userName = "Guest";
                    if (state is AuthAuthenticated) {
                      userName = state.user.fullName.split(' ').first;
                    }

                    return Container(
                      color: AppColors.primary,
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24.r,
                                backgroundImage: const AssetImage(
                                  AppImages.profilePhoto,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello, $userName",
                                    style: AppTextStyles.title.copyWith(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Where are we flying today?",
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.search);
                  },
                  child: const CustomSearchBar(isInteractive: false),
                ),
                SizedBox(height: 24.h),

                /// Favorite Flights Section
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    List<FlightModel> favoriteFlights = [];
                    if (state is FavoritesLoaded) {
                      favoriteFlights = state.favoriteFlights;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Favorite Flights",
                                style: AppTextStyles.title.copyWith(
                                  fontSize: 18.sp,
                                ),
                              ),
                              if (favoriteFlights.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.favorites,
                                    );
                                  },
                                  child: Text(
                                    "See all",
                                    style: AppTextStyles.primaryLink,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        if (favoriteFlights.isEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            padding: EdgeInsets.symmetric(
                              vertical: 24.h,
                              horizontal: 16.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: AppColors.inputBorder),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: AppColors.grey,
                                  size: 28.w,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No favourites yet",
                                        style: AppTextStyles.title.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "Flights you save will appear here",
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.grey,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          SizedBox(
                            height: 290.h,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              scrollDirection: Axis.horizontal,
                              itemCount: favoriteFlights.length,
                              itemBuilder: (context, index) {
                                final flight = favoriteFlights[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: FavoriteFlightCard(
                                    flight: flight,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.flightDetails,
                                        arguments: flight,
                                      );
                                    },
                                    isFavorite: true,
                                    onFavoriteTap: () async {
                                      final confirm =
                                          await FavoriteDialog.showRemoveConfirmation(
                                            context,
                                            fromCity: flight.from,
                                            toCity: flight.to,
                                          );
                                      if (confirm == true && context.mounted) {
                                        context
                                            .read<FavoritesCubit>()
                                            .removeFromFavorites(flight.id);
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Removed from favorites',
                                              ),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  },
                ),

                /// Discover Flights Section
                BlocBuilder<FlightsCubit, FlightsState>(
                  builder: (context, state) {
                    if (state is FlightsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is FlightsError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is FlightsLoaded) {
                      final flights = state.flights;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Text(
                              "Discover Flights",
                              style: AppTextStyles.title.copyWith(
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: flights.length,
                            itemBuilder: (context, index) {
                              final flight = flights[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.flightDetails,
                                      arguments: flight,
                                    );
                                  },
                                  child: DiscoverFlightCard(flight: flight),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
