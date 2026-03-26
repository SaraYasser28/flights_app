import 'package:dartz/dartz.dart';
import '../../../../core/data/models/flight_model.dart';
import '../models/booking_model.dart';

abstract class BookingRepository {
  Future<Either<String, List<BookingModel>>> getUserBookings(
    String userId, {
    bool upcoming = true,
  });

  Future<Either<String, BookingModel>> bookFlight(
    String userId,
    String flightId,
    int passengers,
    FlightModel flight,
  );

  Future<Either<String, BookingModel>> getBookingById(String bookingId);
}
