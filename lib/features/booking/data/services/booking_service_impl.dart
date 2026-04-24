import '../../../../core/data/models/flight_model.dart';
import '../models/booking_model.dart';
import '../models/enum/booking_status.dart';
import 'booking_service.dart';

class BookingServiceImpl implements BookingService {
  static final List<BookingModel> _mockBookings = [];

  @override
  Future<List<BookingModel>> getUserBookings(
    String userId, {
    bool upcoming = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockBookings
        .where(
          (b) =>
              b.userId == userId &&
              (upcoming
                  ? b.status == BookingStatus.upcoming
                  : b.status == BookingStatus.past),
        )
        .toList();
  }

  @override
  Future<BookingModel> bookFlight(
    String userId,
    String flightId,
    int passengers,
    FlightModel flight,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    final existingBooking = _mockBookings.any(
      (b) => b.userId == userId && b.flight!.id == flightId,
    );

    if (existingBooking) {
      throw Exception('Flight already booked');
    }

    final newBooking = BookingModel(
      id: 'b${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      flight: flight,
      bookingDate: DateTime.now(),
      numberOfPassengers: passengers,
      totalPrice: flight.price * passengers,
      status: BookingStatus.upcoming,
      bookingReference:
          'SK${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      bookingToken:
          flight.bookingToken ??
          'token_${DateTime.now().millisecondsSinceEpoch}',
    );

    _mockBookings.add(newBooking);
    return newBooking;
  }

  @override
  Future<BookingModel> getBookingById(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final booking = _mockBookings.firstWhere(
      (b) => b.id == bookingId,
      orElse: () => throw Exception('Booking not found'),
    );
    return booking;
  }
}
