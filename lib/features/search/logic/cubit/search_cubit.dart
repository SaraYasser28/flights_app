import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/data/repositories/flight/flight_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FlightRepository _repository;
  List<FlightModel> _allFlights = [];
  RangeValues? _currentPriceRange;
  String? _currentAirline;
  int? _currentTravelClass;

  SearchCubit({required FlightRepository repository})
    : _repository = repository,
      super(SearchInitial());

  Map<String, dynamic> getCurrentFilters() {
    return {
      'priceRange': _currentPriceRange,
      'airline': _currentAirline,
      'travelClass': _currentTravelClass,
    };
  }

  double getMaxPrice() {
    if (_allFlights.isEmpty) return 1000;
    return _allFlights.map((f) => f.price).reduce((a, b) => a > b ? a : b);
  }

  Future<void> loadFlights() async {
    emit(SearchLoading());
    await Future.delayed(const Duration(milliseconds: 800));

    final result = await _repository.getFlights();

    result.fold((error) => emit(SearchError(error)), (flights) {
      _allFlights = flights;
      _sortFlightsAscending();
      emit(SearchLoaded(flights: _allFlights));
    });
  }

  void searchFlights(String query) {
    if (query.isEmpty) {
      emit(SearchLoaded(flights: _allFlights));
      return;
    }

    emit(SearchLoading());
    Future.delayed(const Duration(milliseconds: 500), () {
      final filteredFlights = _allFlights.where((flight) {
        final searchLower = query.toLowerCase();
        final fromCity = flight.firstSegment.departure.name.toLowerCase();
        final toCity = flight.lastSegment.arrival.name.toLowerCase();
        return flight.airline.toLowerCase().contains(searchLower) ||
            fromCity.contains(searchLower) ||
            toCity.contains(searchLower) ||
            flight.from.toLowerCase().contains(searchLower) ||
            flight.to.toLowerCase().contains(searchLower);
      }).toList();

      _sortFlightsAscending(filteredFlights);
      emit(SearchLoaded(flights: filteredFlights, isSearching: true));
    });
  }

  void applyFilters({
    RangeValues? priceRange,
    String? airline,
    int? travelClass,
  }) async {
    _currentPriceRange = priceRange;
    _currentAirline = airline;
    _currentTravelClass = travelClass;

    emit(SearchLoading());
    await Future.delayed(const Duration(milliseconds: 600));

    var filteredFlights = List<FlightModel>.from(_allFlights);

    if (priceRange != null) {
      filteredFlights = filteredFlights
          .where(
            (f) => f.price >= priceRange.start && f.price <= priceRange.end,
          )
          .toList();
    }

    if (airline != null && airline.isNotEmpty) {
      filteredFlights = filteredFlights
          .where((f) => f.airline.toLowerCase().contains(airline.toLowerCase()))
          .toList();
    }

    if (travelClass != null) {
      filteredFlights = filteredFlights.where((f) {
        final segmentClass = f.firstSegment.travelClass.toLowerCase();
        if (travelClass == 1) {
          return segmentClass.contains('economy');
        } else if (travelClass == 3) {
          return segmentClass.contains('business');
        }
        return true;
      }).toList();
    }

    _sortFlightsAscending(filteredFlights);
    emit(SearchLoaded(flights: filteredFlights, filtersApplied: true));
  }

  void clearFilters() async {
    _currentPriceRange = null;
    _currentAirline = null;
    _currentTravelClass = null;

    emit(SearchLoading());
    await Future.delayed(const Duration(milliseconds: 400));

    _sortFlightsAscending(_allFlights);
    emit(SearchLoaded(flights: _allFlights));
  }

  void _sortFlightsAscending([List<FlightModel>? flights]) {
    final flightsToSort = flights ?? _allFlights;
    flightsToSort.sort((a, b) => a.price.compareTo(b.price));

    if (flights == null) {
      _allFlights = flightsToSort;
    }
  }

  void sortByPriceAscending() async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(SearchLoading());
      await Future.delayed(const Duration(milliseconds: 300));

      final sortedFlights = List<FlightModel>.from(currentState.flights)
        ..sort((a, b) => a.price.compareTo(b.price));
      emit(
        SearchLoaded(
          flights: sortedFlights,
          isSearching: currentState.isSearching,
          filtersApplied: currentState.filtersApplied,
        ),
      );
    }
  }

  void sortByPriceDescending() async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(SearchLoading());
      await Future.delayed(const Duration(milliseconds: 300));

      final sortedFlights = List<FlightModel>.from(currentState.flights)
        ..sort((a, b) => b.price.compareTo(a.price));
      emit(
        SearchLoaded(
          flights: sortedFlights,
          isSearching: currentState.isSearching,
          filtersApplied: currentState.filtersApplied,
        ),
      );
    }
  }

  void sortByDuration() async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(SearchLoading());
      await Future.delayed(const Duration(milliseconds: 300));

      final sortedFlights = List<FlightModel>.from(currentState.flights)
        ..sort((a, b) => a.totalDuration.compareTo(b.totalDuration));
      emit(
        SearchLoaded(
          flights: sortedFlights,
          isSearching: currentState.isSearching,
          filtersApplied: currentState.filtersApplied,
        ),
      );
    }
  }
}
