import '../../models/flight_model.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  // In-memory storage for favorites
  final Map<String, Set<String>> _userFavorites = {};

  Set<String> getFavorites(String userId) {
    return _userFavorites[userId] ?? {};
  }

  Future<void> addFavorite(String userId, String flightId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!_userFavorites.containsKey(userId)) {
      _userFavorites[userId] = {};
    }
    _userFavorites[userId]!.add(flightId);
  }

  Future<void> removeFavorite(String userId, String flightId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_userFavorites.containsKey(userId)) {
      _userFavorites[userId]!.remove(flightId);
    }
  }

  bool isFavorite(String userId, String flightId) {
    return _userFavorites[userId]?.contains(flightId) ?? false;
  }

  Future<List<FlightModel>> getFavoriteFlights(
    String userId,
    List<FlightModel> allFlights,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final favoriteIds = getFavorites(userId);
    return allFlights
        .where((flight) => favoriteIds.contains(flight.id))
        .toList();
  }
}
