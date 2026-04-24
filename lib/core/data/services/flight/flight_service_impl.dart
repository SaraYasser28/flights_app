import '../../../api/api_consumer.dart';
import '../../../constants/api_constants.dart';
import '../../models/flight_model.dart';
import '../../models/mock_flight_data.dart';
import '../fav/favorite_service.dart';
import 'flight_service.dart';

class FlightServiceImpl implements FlightService {
  final FavoriteService _favoriteService = FavoriteService();
  final ApiConsumer api;
  FlightServiceImpl({required this.api});

  @override
  Future<List<FlightModel>> getFlights({
    String? from,
    String? to,
    DateTime? date,
    int? passengers,
  }) async {
    final response = await api.get(
      ApiConstants.baseUrl,
      queryParameters: {
        "api_key": ApiConstants.serpApiKey,
        "departure_id": from,
        "arrival_id": to,
        "outbound_date": date?.toIso8601String().split('T').first,
        "adults": passengers ?? 1,
        "currency": "USD",
      },
    );

    final flightsJson = response['best_flights'] ?? [];

    return flightsJson
        .map<FlightModel>((json) => FlightModel.fromApi(json))
        .toList();
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
