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
  }) async {
    try {
      final flights = await _flightService.getFlights(
        from: from,
        to: to,
        date: date,
        passengers: passengers,
      );
      return Right(flights);
    } catch (e) {
      return Left('Failed to load flights: ${e.toString()}');
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
      return Left('Failed to load favorite flights: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, FlightModel?>> getFlightById(String flightId) async {
    try {
      final flight = await _flightService.getFlightById(flightId);
      return Right(flight);
    } catch (e) {
      return Left('Failed to load flight: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> addToFavorites(
    String userId,
    String flightId,
  ) async {
    try {
      await _flightService.addToFavorites(userId, flightId);
      return const Right(null);
    } catch (e) {
      return Left('Failed to add to favorites: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> removeFromFavorites(
    String userId,
    String flightId,
  ) async {
    try {
      await _flightService.removeFromFavorites(userId, flightId);
      return const Right(null);
    } catch (e) {
      return Left('Failed to remove from favorites: ${e.toString()}');
    }
  }
}
