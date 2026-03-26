part of 'booking_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingModel> upcomingBookings;
  final List<BookingModel> pastBookings;

  const BookingLoaded({
    required this.upcomingBookings,
    required this.pastBookings,
  });

  @override
  List<Object?> get props => [upcomingBookings, pastBookings];
}

class BookingDetailsLoaded extends BookingState {
  final BookingModel booking;

  const BookingDetailsLoaded(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingSuccess extends BookingState {
  final BookingModel booking;

  const BookingSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}
