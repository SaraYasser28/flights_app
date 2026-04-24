import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/booking_repository.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _bookingRepository;
  final String _userId;
  final Set<String> _bookedFlightIds = {};
  bool _isInitialized = false;

  BookingCubit({
    required BookingRepository bookingRepository,
    required String userId,
  }) : _bookingRepository = bookingRepository,
       _userId = userId,
       super(BookingInitial()) {
    loadBookings();
  }

  Future<void> loadBookings() async {
    emit(BookingLoading());

    final upcomingResult = await _bookingRepository.getUserBookings(
      _userId,
      upcoming: true,
    );

    final pastResult = await _bookingRepository.getUserBookings(
      _userId,
      upcoming: false,
    );

    upcomingResult.fold((error) => emit(BookingError(error)), (upcoming) {
      pastResult.fold((error) => emit(BookingError(error)), (past) {
        _bookedFlightIds.clear();
        for (var booking in [...upcoming, ...past]) {
          _bookedFlightIds.add(booking.flight!.id);
        }
        _isInitialized = true;
        emit(BookingLoaded(upcomingBookings: upcoming, pastBookings: past));
      });
    });
  }

  bool isFlightBooked(String flightId) {
    if (!_isInitialized) {
      return false;
    }
    return _bookedFlightIds.contains(flightId);
  }

  Future<void> bookFlight({
    required String flightId,
    required int passengers,
    required FlightModel flight,
  }) async {
    // Check if already booked
    if (isFlightBooked(flightId)) {
      emit(BookingError('This flight is already booked'));
      return;
    }

    emit(BookingLoading());

    final result = await _bookingRepository.bookFlight(
      _userId,
      flightId,
      passengers,
      flight,
    );

    result.fold((error) => emit(BookingError(error)), (booking) {
      _bookedFlightIds.add(booking.flight!.id);
      emit(BookingSuccess(booking));
      // Reload bookings to update the list
      loadBookings();
    });
  }

  Future<void> getBookingDetails(String bookingId) async {
    emit(BookingLoading());

    final result = await _bookingRepository.getBookingById(bookingId);

    result.fold(
      (error) => emit(BookingError(error)),
      (booking) => emit(BookingDetailsLoaded(booking)),
    );
  }
}
