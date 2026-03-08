import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../../../search/presentation/widgets/custom_search_bar.dart';
import '../widgets/favorite_flight_card.dart';
import '../widgets/discover_flight_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final favoriteFlights = [
    {
      "image": AppImages.paris,
      "route": "Paris to London",
      "duration": "Direct • 1h 20m",
      "price": "\$150",
    },
    {
      "image": AppImages.paris,
      "route": "London to Rome",
      "duration": "Direct • 2h 10m",
      "price": "\$180",
    },
  ];
  static final discoverFlights = [
    {
      "airline": "British Airways",
      "from": "CDG",
      "to": "LHR",
      "fromCity": "PARIS",
      "toCity": "LONDON",
      "departureTime": "10:10",
      "arrivalTime": "10:40",
      "duration": "90 min",
      "date": "Jun 24, 2024",
      "price": "\$150",
      "class": "ECONOMY CLASS",
    },
    {
      "airline": "Air France",
      "from": "HND",
      "to": "CDG",
      "fromCity": "TOKYO",
      "toCity": "PARIS",
      "departureTime": "08:30",
      "arrivalTime": "16:20",
      "duration": "12h 50m",
      "date": "Jun 25, 2024",
      "price": "\$450",
      "class": "BUSINESS CLASS",
    },
    {
      "airline": "Lufthansa",
      "from": "FRA",
      "to": "MAD",
      "fromCity": "FRANKFURT",
      "toCity": "MADRID",
      "departureTime": "14:20",
      "arrivalTime": "17:00",
      "duration": "2h 40m",
      "date": "Jun 26, 2024",
      "price": "\$210",
      "class": "ECONOMY CLASS",
    },
  ];

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
                Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
                  child: Column(
                    children: [
                      /// Profile Row
                      Row(
                        children: [
                          CircleAvatar(radius: 24.r),
                          SizedBox(width: 12.w),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, John",
                                style: AppTextStyles.title.copyWith(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Where are we flying today?",
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                const CustomSearchBar(),
                SizedBox(height: 24.h),

                /// Favorite Flights Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Favorite Flights",
                        style: AppTextStyles.title.copyWith(fontSize: 18.sp),
                      ),
                      Text("See all", style: AppTextStyles.primaryLink),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// Favorite Flights Cards
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: favoriteFlights.length,
                    itemBuilder: (context, index) {
                      final flight = favoriteFlights[index];

                      return Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: FavoriteFlightCard(
                          image: flight["image"]!,
                          route: flight["route"]!,
                          duration: flight["duration"]!,
                          price: flight["price"]!,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                /// Discover Flights Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "Discover Flights",
                    style: AppTextStyles.title.copyWith(fontSize: 18.sp),
                  ),
                ),

                SizedBox(height: 16.h),

                /// Discover Flights Cards
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: discoverFlights.length,
                  itemBuilder: (context, index) {
                    final flight = discoverFlights[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.flightDetails);
                        },
                        child: DiscoverFlightCard(
                          airline: flight["airline"]!,
                          flightFrom: flight["from"]!,
                          flightTo: flight["to"]!,
                          fromCity: flight["fromCity"]!,
                          toCity: flight["toCity"]!,
                          departureTime: flight["departureTime"]!,
                          arrivalTime: flight["arrivalTime"]!,
                          duration: flight["duration"]!,
                          date: flight["date"]!,
                          price: flight["price"]!,
                          flightClass: flight["class"]!,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
