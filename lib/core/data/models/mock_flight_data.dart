import '../models/flight_model.dart';
import '../models/enum/flight_class.dart';

class MockFlightData {
  // Airport definitions
  static const Airport parisCDG = Airport(
    code: 'CDG',
    name: 'Charles de Gaulle Airport',
    city: 'PARIS',
    country: 'France',
  );

  static const Airport londonLHR = Airport(
    code: 'LHR',
    name: 'Heathrow Airport',
    city: 'LONDON',
    country: 'United Kingdom',
  );

  static const Airport tokyoHND = Airport(
    code: 'HND',
    name: 'Haneda Airport',
    city: 'TOKYO',
    country: 'Japan',
  );

  static const Airport frankfurtFRA = Airport(
    code: 'FRA',
    name: 'Frankfurt Airport',
    city: 'FRANKFURT',
    country: 'Germany',
  );

  static const Airport dubaiDXB = Airport(
    code: 'DXB',
    name: 'Dubai International Airport',
    city: 'DUBAI',
    country: 'UAE',
  );

  static const Airport newYorkJFK = Airport(
    code: 'JFK',
    name: 'John F. Kennedy Airport',
    city: 'NEW YORK',
    country: 'USA',
  );

  static const Airport losAngelesLAX = Airport(
    code: 'LAX',
    name: 'Los Angeles International Airport',
    city: 'LOS ANGELES',
    country: 'USA',
  );

  static const Airport madridMAD = Airport(
    code: 'MAD',
    name: 'Adolfo Suárez Madrid-Barajas Airport',
    city: 'MADRID',
    country: 'Spain',
  );

  static final List<FlightModel> flights = [
    FlightModel(
      id: 'f1',
      airline: 'British Airways',
      flightNumber: 'BA301',
      departureAirport: parisCDG,
      arrivalAirport: londonLHR,
      departureTime: '10:10',
      arrivalTime: '10:40',
      duration: '1h 30m',
      date: DateTime(2024, 6, 24),
      price: 150.00,
      flightClass: FlightClass.economy,
      amenities: ['Wi-Fi', 'USB outlets', 'On-demand video'],
      carbonEmission: 461,
    ),
    FlightModel(
      id: 'f2',
      airline: 'Air France',
      flightNumber: 'AF278',
      departureAirport: tokyoHND,
      arrivalAirport: parisCDG,
      departureTime: '08:30',
      arrivalTime: '16:20',
      duration: '7h 50m',
      date: DateTime(2024, 6, 25),
      price: 450.00,
      flightClass: FlightClass.business,
      amenities: ['Wi-Fi', 'Power outlets', 'Meals included', 'Extra legroom'],
      carbonEmission: 1200,
    ),
    FlightModel(
      id: 'f3',
      airline: 'Lufthansa',
      flightNumber: 'LH456',
      departureAirport: frankfurtFRA,
      arrivalAirport: madridMAD,
      departureTime: '14:20',
      arrivalTime: '17:00',
      duration: '2h 40m',
      date: DateTime(2024, 6, 26),
      price: 210.00,
      flightClass: FlightClass.economy,
      amenities: ['Wi-Fi for a fee', 'USB outlets'],
      carbonEmission: 320,
    ),
    FlightModel(
      id: 'f4',
      airline: 'Emirates',
      flightNumber: 'EK202',
      departureAirport: dubaiDXB,
      arrivalAirport: londonLHR,
      departureTime: '13:00',
      arrivalTime: '18:30',
      duration: '5h 30m',
      date: DateTime(2024, 6, 27),
      price: 700.00,
      flightClass: FlightClass.business,
      amenities: ['Free Wi-Fi', 'Lie-flat seats', 'Premium meals'],
      carbonEmission: 850,
    ),
    FlightModel(
      id: 'f5',
      airline: 'Delta Airlines',
      flightNumber: 'DL123',
      departureAirport: newYorkJFK,
      arrivalAirport: losAngelesLAX,
      departureTime: '09:00',
      arrivalTime: '12:30',
      duration: '3h 30m',
      date: DateTime(2024, 6, 28),
      price: 320.00,
      flightClass: FlightClass.economy,
      amenities: ['Wi-Fi', 'USB outlets', 'Entertainment system'],
      carbonEmission: 420,
    ),
    FlightModel(
      id: 'f6',
      airline: 'Qatar Airways',
      flightNumber: 'QR702',
      departureAirport: dubaiDXB,
      arrivalAirport: parisCDG,
      departureTime: '07:45',
      arrivalTime: '13:30',
      duration: '6h 45m',
      date: DateTime(2024, 6, 29),
      price: 580.00,
      flightClass: FlightClass.business,
      amenities: ['Qsuite', 'Wi-Fi', 'Fine dining', 'Lounge access'],
      carbonEmission: 680,
    ),
  ];

  static List<FlightModel> getDiscoverFlights() {
    return flights;
  }

  static List<FlightModel> getFavoriteFlights() {
    return [];
  }
}
