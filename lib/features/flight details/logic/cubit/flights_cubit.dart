import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/data/repositories/flight/flight_repository.dart';

part 'flights_state.dart';

class FlightsCubit extends Cubit<FlightsState> {
  final FlightRepository repository;

  FlightsCubit(this.repository) : super(FlightsInitial());

  Future<void> getFlights({String? from, String? to, DateTime? date}) async {
    emit(FlightsLoading());

    final result = await repository.getFlights(from: from, to: to, date: date);

    result.fold(
      (error) => emit(FlightsError(error)),
      (flights) => emit(FlightsLoaded(flights)),
    );
  }
}
