import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/logic/cubit/auth_cubit.dart';
import '../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../features/booking/data/services/booking_service.dart';
import '../../features/booking/data/services/booking_service_impl.dart';
import '../../features/booking/logic/cubit/booking_cubit.dart';
import '../../features/favorites/logic/cubit/favorites_cubit.dart';
import '../../features/search/logic/cubit/search_cubit.dart';
import '../data/repositories/auth/auth_repository_impl.dart';
import '../data/repositories/flight/flight_repository_impl.dart';
import '../data/services/auth/auth_service.dart';
import '../data/services/auth/auth_service_impl.dart';
import '../data/services/flight/flight_service.dart';
import '../data/services/flight/flight_service_impl.dart';

class AppProviders {
  static final AppProviders _instance = AppProviders._internal();
  factory AppProviders() => _instance;

  // Services
  late final AuthService _authService;
  late final FlightService _flightService;
  late final BookingService _bookingService;

  // Repositories
  late final AuthRepositoryImpl _authRepository;
  late final FlightRepositoryImpl _flightRepository;
  late final BookingRepositoryImpl _bookingRepository;

  // User ID / mock
  static const String _userId = '1';

  AppProviders._internal() {
    _initServices();
    _initRepositories();
  }

  void _initServices() {
    _authService = AuthServiceImpl();
    _flightService = FlightServiceImpl();
    _bookingService = BookingServiceImpl();
  }

  void _initRepositories() {
    _authRepository = AuthRepositoryImpl(authService: _authService);
    _flightRepository = FlightRepositoryImpl(flightService: _flightService);
    _bookingRepository = BookingRepositoryImpl(bookingService: _bookingService);
  }

  List<BlocProvider> get providers => [
    BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(authRepository: _authRepository),
    ),
    BlocProvider<SearchCubit>(
      create: (_) => SearchCubit(repository: _flightRepository),
    ),
    BlocProvider<BookingCubit>(
      create: (_) =>
          BookingCubit(bookingRepository: _bookingRepository, userId: _userId),
    ),
    BlocProvider<FavoritesCubit>(
      create: (_) =>
          FavoritesCubit(flightRepository: _flightRepository, userId: _userId)
            ..loadFavorites(),
    ),
  ];
}
