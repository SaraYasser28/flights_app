import 'package:dartz/dartz.dart';
import '../../models/flight_model.dart';

abstract class FlightRepository {
  Future<Either<String, List<FlightModel>>> getFlights({
    String? from,
    String? to,
    DateTime? date,
    int? passengers,
  });

  Future<Either<String, List<FlightModel>>> getFavoriteFlights(String userId);

  Future<Either<String, FlightModel?>> getFlightById(String flightId);

  Future<Either<String, void>> addToFavorites(String userId, String flightId);

  Future<Either<String, void>> removeFromFavorites(
    String userId,
    String flightId,
  );
}
