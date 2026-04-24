import 'package:flutter/material.dart';
import '../../features/authentication/view/screens/sign_in_screen.dart';
import '../../features/authentication/view/screens/sign_up_screen.dart';
import '../../features/booking/view/screens/booking_screen.dart';
import '../../features/booking/view/screens/bookings_screen.dart';
import '../../features/favorites/view/screens/favorite_screen.dart';
import '../../features/flight details/presentation/screens/flight_details_screen.dart';
import '../../features/home/view/screens/home_screen.dart';
import '../../features/profile/view/screens/profile_screen.dart';
import '../../features/search/view/screens/search_screen.dart';
import '../data/models/flight_model.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());

      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case AppRoutes.bookings:
        return MaterialPageRoute(builder: (_) => const BookingsScreen());

      case AppRoutes.booking:
        final flight = settings.arguments as FlightModel;
        return MaterialPageRoute(builder: (_) => BookingScreen(flight: flight));

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.flightDetails:
        final flight = settings.arguments as FlightModel;
        return MaterialPageRoute(
          builder: (_) =>
              FlightDetailsScreen(flightId: flight.id, flight: flight),
        );

      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
