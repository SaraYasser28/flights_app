import 'package:equatable/equatable.dart';
import '../../constants/app_icons.dart';
import 'enum/flight_class.dart';

class Airport extends Equatable {
  final String code;
  final String name;
  final String city;
  final String country;
  final String iconAsset;

  const Airport({
    required this.code,
    required this.name,
    required this.city,
    required this.country,
    this.iconAsset = AppIcons.france,
  });

  @override
  List<Object?> get props => [code, name, city, country, iconAsset];
}

class FlightModel extends Equatable {
  final String id;
  final String airline;
  final String flightNumber;
  final Airport departureAirport;
  final Airport arrivalAirport;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final DateTime date;
  final double price;
  final FlightClass flightClass;
  final List<String> amenities;
  final double? carbonEmission;

  const FlightModel({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.price,
    required this.flightClass,
    this.amenities = const [],
    this.carbonEmission,
  });

  /// =========================
  ///  API Data
  /// =========================
  factory FlightModel.fromApi(Map<String, dynamic> json) {
    final segments = (json['flights'] as List?) ?? [];
    if (segments.isEmpty) {
      throw Exception("Invalid flight data");
    }

    final first = segments.first;
    final last = segments.last;

    return FlightModel(
      id:
          json['booking_token'] ??
          '${first['flight_number']}_${first['departure_airport']['time']}',

      airline: first['airline'] ?? '',
      flightNumber: first['flight_number'] ?? '',

      departureAirport: Airport(
        code: first['departure_airport']['id'] ?? '',
        name: first['departure_airport']['name'] ?? '',
        city: _extractCity(first['departure_airport']['name']),
        country: '',
        iconAsset: _getAirportIcon(first['departure_airport']['id']),
      ),

      arrivalAirport: Airport(
        code: last['arrival_airport']['id'] ?? '',
        name: last['arrival_airport']['name'] ?? '',
        city: _extractCity(last['arrival_airport']['name']),
        country: '',
        iconAsset: _getAirportIcon(last['arrival_airport']['id']),
      ),

      departureTime: first['departure_airport']['time'],
      arrivalTime: last['arrival_airport']['time'],

      duration: _formatDuration(json['total_duration']),

      date: DateTime.parse(first['departure_airport']['time']),

      price: (json['price'] as num).toDouble(),

      flightClass: _mapFlightClass(first['travel_class']),

      amenities: _extractAmenities(segments),

      carbonEmission: (json['carbon_emissions']?['this_flight'] as num?)
          ?.toDouble(),
    );
  }

  /// =========================
  ///  MOCK Data
  /// =========================
  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'] as String,
      airline: json['airline'] as String,
      flightNumber: json['flightNumber'] as String,
      departureAirport: _parseAirport(json['departureAirport']),
      arrivalAirport: _parseAirport(json['arrivalAirport']),
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      duration: json['duration'] as String,
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toDouble(),
      flightClass: FlightClass.fromString(json['flightClass'] as String),
      amenities: (json['amenities'] as List<dynamic>?)?.cast<String>() ?? [],
      carbonEmission: (json['carbonEmission'] as num?)?.toDouble(),
    );
  }

  /// =========================
  ///  HELPERS
  /// =========================

  static Airport _parseAirport(Map<String, dynamic> json) {
    return Airport(
      code: json['code'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      iconAsset: _getAirportIcon(json['code']),
    );
  }

  static String _getAirportIcon(String code) {
    switch (code) {
      default:
        return AppIcons.france;
    }
  }

  static String _extractCity(String airportName) {
    return airportName.split(' ').first;
  }

  static String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    if (mins == 0) return '${hours}h';
    return '${hours}h ${mins}m';
  }

  static FlightClass _mapFlightClass(String value) {
    switch (value.toLowerCase()) {
      case 'business':
        return FlightClass.business;
      default:
        return FlightClass.economy;
    }
  }

  static List<String> _extractAmenities(List segments) {
    final amenities = <String>[];

    for (var segment in segments) {
      final extensions = segment['extensions'] as List?;
      if (extensions != null) {
        amenities.addAll(extensions.cast<String>());
      }
    }

    return amenities;
  }

  /// =========================
  ///  JSON EXPORT
  /// =========================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airline': airline,
      'flightNumber': flightNumber,
      'departureAirport': {
        'code': departureAirport.code,
        'name': departureAirport.name,
        'city': departureAirport.city,
        'country': departureAirport.country,
      },
      'arrivalAirport': {
        'code': arrivalAirport.code,
        'name': arrivalAirport.name,
        'city': arrivalAirport.city,
        'country': arrivalAirport.country,
      },
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'duration': duration,
      'date': date.toIso8601String(),
      'price': price,
      'flightClass': flightClass.displayName,
      'amenities': amenities,
      'carbonEmission': carbonEmission,
    };
  }

  /// =========================
  ///  UI HELPERS
  /// =========================
  String get from => departureAirport.code;
  String get to => arrivalAirport.code;
  String get fromCity => departureAirport.city;
  String get toCity => arrivalAirport.city;

  String get formattedDate {
    return '${date.day} ${_getMonthAbbr(date.month)} ${date.year}';
  }

  String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  List<Object?> get props => [
    id,
    airline,
    flightNumber,
    departureAirport,
    arrivalAirport,
    departureTime,
    arrivalTime,
    duration,
    date,
    price,
    flightClass,
    amenities,
    carbonEmission,
  ];
}
