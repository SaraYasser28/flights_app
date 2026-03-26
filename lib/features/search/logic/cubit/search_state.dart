part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final String? message;

  const SearchLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class SearchLoaded extends SearchState {
  final List<FlightModel> flights;
  final bool isSearching;
  final bool filtersApplied;

  const SearchLoaded({
    required this.flights,
    this.isSearching = false,
    this.filtersApplied = false,
  });

  @override
  List<Object?> get props => [flights, isSearching, filtersApplied];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
