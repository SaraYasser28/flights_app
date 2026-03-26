import '../../models/flight_model.dart';
import '../../models/mock_flight_data.dart';
import '../fav/favorite_service.dart';
import 'flight_service.dart';

class FlightServiceImpl implements FlightService {
  final FavoriteService _favoriteService = FavoriteService();

  @override
  Future<List<FlightModel>> getFlights({
    String? from,
    String? to,
    DateTime? date,
    int? passengers,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var flights = List<FlightModel>.from(MockFlightData.flights);

    if (from != null && from.isNotEmpty) {
      flights = flights.where((f) => f.from == from).toList();
    }
    if (to != null && to.isNotEmpty) {
      flights = flights.where((f) => f.to == to).toList();
    }
    if (date != null) {
      flights = flights
          .where(
            (f) =>
                f.date.year == date.year &&
                f.date.month == date.month &&
                f.date.day == date.day,
          )
          .toList();
    }

    return flights;
  }

  @override
  Future<List<FlightModel>> getFavoriteFlights(String userId) async {
    return await _favoriteService.getFavoriteFlights(
      userId,
      MockFlightData.flights,
    );
  }

  @override
  Future<FlightModel?> getFlightById(String flightId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return MockFlightData.flights.firstWhere((f) => f.id == flightId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addToFavorites(String userId, String flightId) async {
    await _favoriteService.addFavorite(userId, flightId);
  }

  @override
  Future<void> removeFromFavorites(String userId, String flightId) async {
    await _favoriteService.removeFavorite(userId, flightId);
  }

  @override
  Future<bool> isFavorite(String userId, String flightId) async {
    return _favoriteService.isFavorite(userId, flightId);
  }
}
