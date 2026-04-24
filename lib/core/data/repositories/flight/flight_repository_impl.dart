import 'package:dartz/dartz.dart';
import '../../models/flight_model.dart';
import '../../services/flight/flight_service.dart';
import 'flight_repository.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightService _flightService;

  FlightRepositoryImpl({required FlightService flightService})
    : _flightService = flightService;

  @override
  Future<Either<String, List<FlightModel>>> getFlights({
    String? from,
    String? to,
    DateTime? date,
    int? passengers,
    int? travelClass,
  }) async {
    try {
      final flights = await _flightService.getFlights(
        from: from,
        to: to,
        date: date,
        passengers: passengers,
        travelClass: travelClass,
      );
      return Right(flights);
    } catch (e) {
      return Left('Flights error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<FlightModel>>> getFavoriteFlights(
    String userId,
  ) async {
    try {
      final flights = await _flightService.getFavoriteFlights(userId);
      return Right(flights);
    } catch (e) {
      return Left('Favorites error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> addToFavorites(
    String userId,
    FlightModel flight,
  ) async {
    try {
      await _flightService.addToFavorites(userId, flight);
      return const Right(null);
    } catch (e) {
      return Left('Add favorite failed');
    }
  }

  @override
  Future<Either<String, void>> removeFromFavorites(
    String userId,
    FlightModel flight,
  ) async {
    try {
      await _flightService.removeFromFavorites(userId, flight);
      return const Right(null);
    } catch (e) {
      return Left('Remove favorite failed');
    }
  }
}
