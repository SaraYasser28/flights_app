import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../widgets/favorite_flight_card.dart';
import '../widgets/favorite_dialog.dart';
import '../../../../core/routing/app_routes.dart';
import '../../logic/cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: const CustomAppBar(
        backgroundColor: AppColors.primary,
        title: "Favorite Flights",
        iconColor: AppColors.white,
        showBackButton: true,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.w, color: AppColors.red),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FavoritesCubit>().loadFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is FavoritesLoaded) {
            if (state.favoriteFlights.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64.w,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No favorite flights yet',
                      style: AppTextStyles.title.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Start adding flights to your favorites',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.home);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: Text(
                        'Explore Flights',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Favorites',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${state.favoriteFlights.length}',
                          style: AppTextStyles.title.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: state.favoriteFlights.length,
                    itemBuilder: (context, index) {
                      final flight = state.favoriteFlights[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
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
                                  fromCity: flight.firstSegment.departure.name,
                                  toCity: flight.firstSegment.arrival.name,
                                );
                            if (confirm == true && context.mounted) {
                              context
                                  .read<FavoritesCubit>()
                                  .removeFromFavorites(flight.id);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, AppRoutes.bookings);
          }
        },
      ),
    );
  }
}
