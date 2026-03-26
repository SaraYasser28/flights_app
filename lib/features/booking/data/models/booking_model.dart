import 'package:equatable/equatable.dart';

import '../../../../core/data/models/flight_model.dart';
import 'enum/booking_status.dart';

class BookingModel extends Equatable {
  final String id;
  final String userId;
  final FlightModel flight;
  final DateTime bookingDate;
  final int numberOfPassengers;
  final double totalPrice;
  final BookingStatus status;
  final String? bookingReference;

  const BookingModel({
    required this.id,
    required this.userId,
    required this.flight,
    required this.bookingDate,
    required this.numberOfPassengers,
    required this.totalPrice,
    required this.status,
    this.bookingReference,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      flight: FlightModel.fromJson(json['flight'] as Map<String, dynamic>),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      numberOfPassengers: json['numberOfPassengers'] as int,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
      ),
      bookingReference: json['bookingReference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'flight': flight.toJson(),
      'bookingDate': bookingDate.toIso8601String(),
      'numberOfPassengers': numberOfPassengers,
      'totalPrice': totalPrice,
      'status': status.toString().split('.').last,
      'bookingReference': bookingReference,
    };
  }

  BookingModel copyWith({
    String? id,
    String? userId,
    FlightModel? flight,
    DateTime? bookingDate,
    int? numberOfPassengers,
    double? totalPrice,
    BookingStatus? status,
    String? bookingReference,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      flight: flight ?? this.flight,
      bookingDate: bookingDate ?? this.bookingDate,
      numberOfPassengers: numberOfPassengers ?? this.numberOfPassengers,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      bookingReference: bookingReference ?? this.bookingReference,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    flight,
    bookingDate,
    numberOfPassengers,
    totalPrice,
    status,
    bookingReference,
  ];
}
