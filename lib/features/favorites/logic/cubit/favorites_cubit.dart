import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/data/repositories/flight/flight_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FlightRepository _flightRepository;
  final String _userId;
  Set<String> _favoriteIds = {};

  FavoritesCubit({
    required FlightRepository flightRepository,
    required String userId,
  }) : _flightRepository = flightRepository,
       _userId = userId,
       super(FavoritesInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());

    final result = await _flightRepository.getFavoriteFlights(_userId);

    result.fold((error) => emit(FavoritesError(error)), (flights) {
      _favoriteIds = flights.map((f) => f.id).toSet();
      emit(FavoritesLoaded(favoriteFlights: flights));
    });
  }

  bool isFavorite(String flightId) {
    return _favoriteIds.contains(flightId);
  }

  Future<void> addToFavorites(String flightId) async {
    final result = await _flightRepository.addToFavorites(_userId, flightId);
    result.fold((error) => emit(FavoritesError(error)), (_) => loadFavorites());
  }

  Future<void> removeFromFavorites(String flightId) async {
    final result = await _flightRepository.removeFromFavorites(
      _userId,
      flightId,
    );
    result.fold((error) => emit(FavoritesError(error)), (_) => loadFavorites());
  }

  Future<void> toggleFavorite(String flightId) async {
    final isCurrentlyFavorite = _favoriteIds.contains(flightId);
    if (isCurrentlyFavorite) {
      await removeFromFavorites(flightId);
    } else {
      await addToFavorites(flightId);
    }
  }
}
