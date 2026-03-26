import 'package:equatable/equatable.dart';
import 'enum/flight_class.dart';

class FlightModel extends Equatable {
  final String id;
  final String airline;
  final String flightNumber;
  final String from;
  final String to;
  final String fromCity;
  final String toCity;
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
    required this.from,
    required this.to,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.price,
    required this.flightClass,
    this.amenities = const [],
    this.carbonEmission,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'] as String,
      airline: json['airline'] as String,
      flightNumber: json['flightNumber'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      fromCity: json['fromCity'] as String,
      toCity: json['toCity'] as String,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airline': airline,
      'flightNumber': flightNumber,
      'from': from,
      'to': to,
      'fromCity': fromCity,
      'toCity': toCity,
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
    from,
    to,
    fromCity,
    toCity,
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
