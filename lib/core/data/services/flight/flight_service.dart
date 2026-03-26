import '../../models/flight_model.dart';

abstract class FlightService {
  Future<List<FlightModel>> getFlights({
    String? from,
    String? to,
    DateTime? date,
    int? passengers,
  });

  Future<List<FlightModel>> getFavoriteFlights(String userId);

  Future<FlightModel?> getFlightById(String flightId);

  Future<void> addToFavorites(String userId, String flightId);

  Future<void> removeFromFavorites(String userId, String flightId);

  Future<bool> isFavorite(String userId, String flightId);
}
