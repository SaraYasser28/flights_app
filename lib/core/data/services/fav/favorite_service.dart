import '../../models/flight_model.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  final Map<String, List<Map<String, dynamic>>> _store = {};

  Future<List<Map<String, dynamic>>> _get(String userId) async {
    return _store[userId] ?? [];
  }

  Future<void> _save(String userId, List<Map<String, dynamic>> data) async {
    _store[userId] = data;
  }

  Future<void> addFavorite(String userId, FlightModel flight) async {
    final data = await _get(userId);

    if (!data.any((e) => e['id'] == flight.id)) {
      data.add(flight.toJson());
    }

    await _save(userId, data);
  }

  Future<void> removeFavorite(String userId, String flightId) async {
    final data = await _get(userId);
    data.removeWhere((e) => e['id'] == flightId);
    await _save(userId, data);
  }

  Future<List<FlightModel>> getFavoriteFlights(String userId) async {
    final data = await _get(userId);
    return data.map((e) => FlightModel.fromJson(e)).toList();
  }

  bool isFavorite(String userId, String flightId) {
    return _store[userId]?.any((e) => e['id'] == flightId) ?? false;
  }
}
