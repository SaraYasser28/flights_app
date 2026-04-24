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
