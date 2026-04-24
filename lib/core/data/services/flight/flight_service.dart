import '../../models/flight_model.dart';

abstract class FlightService {
  Future<List<FlightModel>> getFlights({
    String? from,
    String? to,
    DateTime? date,
    int? passengers,
    int? travelClass,
  });

  Future<List<FlightModel>> getFavoriteFlights(String userId);

  Future<void> addToFavorites(String userId, FlightModel flight);

  Future<void> removeFromFavorites(String userId, FlightModel flight);
}
