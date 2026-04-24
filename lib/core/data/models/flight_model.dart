import 'package:equatable/equatable.dart';
import '../../constants/app_icons.dart';
import 'enum/flight_class.dart';

class Airport {
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

  // Helper getters for backward compatibility
  String get from => departureAirport.code;
  String get to => arrivalAirport.code;
  String get fromCity => departureAirport.city;
  String get toCity => arrivalAirport.city;

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

  String get formattedDate {
    return '${date.month} ${_getMonthAbbr(date.month)} ${date.day}';
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
