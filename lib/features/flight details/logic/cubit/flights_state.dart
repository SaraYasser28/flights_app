part of 'flights_cubit.dart';

abstract class FlightsState {}

class FlightsInitial extends FlightsState {}

class FlightsLoading extends FlightsState {}

class FlightsLoaded extends FlightsState {
  final List<FlightModel> flights;

  FlightsLoaded(this.flights);
}

class FlightsError extends FlightsState {
  final String message;

  FlightsError(this.message);
}

class FlightDetailsLoading extends FlightsState {}

class FlightDetailsLoaded extends FlightsState {
  final FlightModel flight;
  FlightDetailsLoaded(this.flight);
}

class FlightDetailsError extends FlightsState {
  final String message;

  FlightDetailsError(this.message);
}
