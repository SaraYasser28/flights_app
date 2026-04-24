import '../../../api/api_consumer.dart';
import '../../../constants/api_constants.dart';
import '../../models/flight_model.dart';
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
    int? travelClass,
  }) async {
    final departureId = from ?? 'CDG';
    final arrivalId = to ?? 'AUS';
    final outboundDate = date ?? DateTime.now();

    final queryParameters = <String, dynamic>{
      "engine": "google_flights",
      "api_key": ApiConstants.serpApiKey,
      "departure_id": departureId,
      "arrival_id": arrivalId,
      "outbound_date": outboundDate.toIso8601String().split('T').first,
      "adults": passengers ?? 1,
      "currency": "USD",
      "type": "2",
    };

    if (travelClass != null) {
      queryParameters["travel_class"] = travelClass;
    }

    final response = await api.get(
      ApiConstants.baseUrl,
      queryParameters: queryParameters,
    );

    if (response is Map<String, dynamic> && response.containsKey('error')) {
      throw Exception(response['error']?.toString() ?? 'API Error');
    }

    final bestFlightsJson = (response['best_flights'] as List?) ?? [];
    final otherFlightsJson = (response['other_flights'] as List?) ?? [];

    final allFlights = <FlightModel>[
      ...bestFlightsJson.map((json) => FlightModel.fromApi(json)),
      ...otherFlightsJson.map((json) => FlightModel.fromApi(json)),
    ];

    return allFlights;
  }

  @override
  Future<List<FlightModel>> getFavoriteFlights(String userId) async {
    return await _favoriteService.getFavoriteFlights(userId);
  }

  @override
  Future<void> addToFavorites(String userId, FlightModel flight) async {
    await _favoriteService.addFavorite(userId, flight);
  }

  @override
  Future<void> removeFromFavorites(String userId, FlightModel flight) async {
    await _favoriteService.removeFavorite(userId, flight.id);
  }
}
