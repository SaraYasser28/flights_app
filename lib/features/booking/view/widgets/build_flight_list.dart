import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/discover_flight_card.dart';
import '../../data/models/booking_model.dart';

class BuildFlightList extends StatelessWidget {
  const BuildFlightList({super.key, required this.bookings});

  final List<BookingModel> bookings;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_takeoff, size: 64.w, color: Colors.grey),
            SizedBox(height: 16.h),
            Text(
              'No bookings found',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your booked flights will appear here',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.flightDetails,
                arguments: booking.flight,
              );
            },
            child: DiscoverFlightCard(
              flight: booking.flight,
              bookingReference: booking.bookingReference,
              numberOfPassengers: booking.numberOfPassengers,
              totalPrice: booking.totalPrice,
            ),
          ),
        );
      },
    );
  }
}
