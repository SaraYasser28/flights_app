import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/data/repositories/flight/flight_repository.dart';

part 'flights_state.dart';

class FlightsCubit extends Cubit<FlightsState> {
  final FlightRepository flightRepository;

  FlightsCubit({required this.flightRepository}) : super(FlightsInitial());

  List<FlightModel> _cachedFlights = [];

  Future<void> getFlights({String? from, String? to, DateTime? date}) async {
    emit(FlightsLoading());

    final result = await flightRepository.getFlights(
      from: from,
      to: to,
      date: date,
    );

    result.fold((error) => emit(FlightsError(error)), (flights) {
      _cachedFlights = flights;
      emit(FlightsLoaded(flights));
    });
  }

  Future<void> getFlightById(String id) async {
    emit(FlightDetailsLoading());

    try {
      final cached = _cachedFlights.where((f) => f.id == id).toList();

      if (cached.isNotEmpty) {
        emit(FlightDetailsLoaded(cached.first));
        return;
      }

      final result = await flightRepository.getFlightById(id);

      result.fold((error) => emit(FlightDetailsError(error)), (flight) {
        if (flight == null) {
          emit(FlightDetailsError("Flight not found"));
        } else {
          emit(FlightDetailsLoaded(flight));
        }
      });
    } catch (e) {
      emit(FlightDetailsError(e.toString()));
    }
  }
}
