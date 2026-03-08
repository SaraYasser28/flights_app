import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/presentation/widgets/discover_flight_card.dart';

class BuildFlightList extends StatelessWidget {
  const BuildFlightList({super.key, required this.flights});

  final List<Map<String, String>> flights;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: flights.length,
      itemBuilder: (context, index) {
        final flight = flights[index];

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
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
        );
      },
    );
  }
}
