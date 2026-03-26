import '../../../../core/data/models/flight_model.dart';
import '../models/booking_model.dart';

abstract class BookingService {
  Future<List<BookingModel>> getUserBookings(
    String userId, {
    bool upcoming = true,
  });

  Future<BookingModel> bookFlight(
    String userId,
    String flightId,
    int passengers,
    FlightModel flight,
  );

  Future<BookingModel> getBookingById(String bookingId);
}
