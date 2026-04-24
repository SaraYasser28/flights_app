# Fix Discover Flights Empty Section

## Plan
- [x] Edit `lib/core/data/services/flight/flight_service_impl.dart` — Fix silent catch, conditionally build query params, handle API error JSON.
- [x] Edit `lib/features/flight details/logic/cubit/flights_cubit.dart` — Add try-catch around `getFlights()` to emit `FlightsError`.
- [x] Edit `lib/features/home/view/screens/home_screen.dart` — Add empty state UI inside `FlightsLoaded`, show loading on `FlightsInitial`.
- [x] Edit `lib/app/app.dart` — Move `AppProviders` to a static final field outside `build()`.
- [ ] Run `flutter analyze` to verify no syntax errors.

