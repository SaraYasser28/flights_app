import 'package:equatable/equatable.dart';

import '../../../../core/data/models/flight_model.dart';
import 'enum/booking_status.dart';

class BookingModel extends Equatable {
  final String id;
  final String userId;

  /// API identifier
  final String bookingToken;
  final String? departureToken;

  final FlightModel? flight;
  final DateTime bookingDate;
  final int numberOfPassengers;
  final double totalPrice;
  final BookingStatus status;
  final String? bookingReference;

  const BookingModel({
    required this.id,
    required this.userId,
    required this.bookingToken,
    this.departureToken,
    this.flight,
    required this.bookingDate,
    required this.numberOfPassengers,
    required this.totalPrice,
    required this.status,
    this.bookingReference,
  });

  factory BookingModel.fromApi(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['user_id'],
      bookingToken: json['booking_token'],
      departureToken: json['departure_token'],
      bookingDate: DateTime.parse(json['booking_date']),
      numberOfPassengers: json['passengers'],
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'] == 'upcoming'
          ? BookingStatus.upcoming
          : BookingStatus.past,
      bookingReference: json['reference'],
      flight: json['flight'] != null
          ? FlightModel.fromApi(json['flight'])
          : null,
    );
  }

  Map<String, dynamic> toApi() {
    return {
      "booking_token": bookingToken,
      "departure_token": departureToken,
      "passengers": numberOfPassengers,
    };
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    bookingToken,
    departureToken,
    bookingDate,
    numberOfPassengers,
    totalPrice,
    status,
  ];
}
