import 'package:dartz/dartz.dart';
import '../../../../core/data/models/flight_model.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';
import 'booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingService _bookingService;

  BookingRepositoryImpl({required BookingService bookingService})
    : _bookingService = bookingService;

  @override
  Future<Either<String, List<BookingModel>>> getUserBookings(
    String userId, {
    bool upcoming = true,
  }) async {
    try {
      final bookings = await _bookingService.getUserBookings(
        userId,
        upcoming: upcoming,
      );
      return Right(bookings);
    } catch (e) {
      return Left('Failed to load bookings: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, BookingModel>> bookFlight(
    String userId,
    String flightId,
    int passengers,
    FlightModel flight,
  ) async {
    try {
      final booking = await _bookingService.bookFlight(
        userId,
        flightId,
        passengers,
        flight,
      );
      return Right(booking);
    } catch (e) {
      return Left('Failed to book flight: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, BookingModel>> getBookingById(String bookingId) async {
    try {
      final booking = await _bookingService.getBookingById(bookingId);
      return Right(booking);
    } catch (e) {
      return Left('Failed to get booking: ${e.toString()}');
    }
  }
}
