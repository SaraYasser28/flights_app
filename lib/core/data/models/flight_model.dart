import 'package:equatable/equatable.dart';
import 'flight_segment.dart';

class FlightModel extends Equatable {
  final String id;
  final List<FlightSegment> segments;
  final int totalDuration;
  final int stops;
  final double price;
  final String type;
  final double? carbonEmissionKg;
  final String? airlineLogo;
  final String? bookingToken;
  final String? departureToken;

  const FlightModel({
    required this.id,
    required this.segments,
    required this.totalDuration,
    required this.stops,
    required this.price,
    required this.type,
    this.carbonEmissionKg,
    this.airlineLogo,
    this.bookingToken,
    this.departureToken,
  });

  /// =========================
  ///  API Data
  /// =========================
  factory FlightModel.fromApi(Map<String, dynamic> json) {
    final segmentsJson = (json['flights'] as List?) ?? [];

    final segments = segmentsJson.map((e) => FlightSegment.fromApi(e)).toList();

    if (segments.isEmpty) {
      throw Exception("Invalid flight: no segments");
    }

    final carbon = json['carbon_emissions']?['this_flight'];

    return FlightModel(
      id:
          json['booking_token'] ??
          '${segments.first.flightNumber}_${segments.first.departure.time ?? DateTime.now()}',

      segments: segments,

      totalDuration: json['total_duration'] ?? 0,

      stops: (json['layovers'] as List?)?.length ?? 0,

      price: (json['price'] as num?)?.toDouble() ?? 0.0,

      type: json['type'] ?? '',

      airlineLogo: json['airline_logo'],

      bookingToken: json['booking_token'],

      departureToken: json['departure_token'],

      carbonEmissionKg: carbon != null ? (carbon as num) / 1000 : null,
    );
  }

  /// =========================
  /// JSON for local storage
  /// =========================
  factory FlightModel.fromJson(Map<String, dynamic> json) {
    final segmentsJson = (json['segments'] as List?) ?? [];
    final segments = segmentsJson
        .map((e) => FlightSegment.fromJson(e))
        .toList();

    return FlightModel(
      id: json['id'] ?? '',
      segments: segments,
      totalDuration: json['totalDuration'] ?? 0,
      stops: json['stops'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] ?? '',
      carbonEmissionKg: json['carbonEmissionKg'] != null
          ? (json['carbonEmissionKg'] as num).toDouble()
          : null,
      airlineLogo: json['airlineLogo'],
      bookingToken: json['bookingToken'],
      departureToken: json['departureToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "segments": segments.map((e) => e.toJson()).toList(),
      "totalDuration": totalDuration,
      "stops": stops,
      "price": price,
      "type": type,
      "carbonEmissionKg": carbonEmissionKg,
      "airlineLogo": airlineLogo,
      "bookingToken": bookingToken,
      "departureToken": departureToken,
    };
  }

  /// =========================
  /// UI HELPERS
  /// =========================
  FlightSegment get firstSegment => segments.first;
  FlightSegment get lastSegment => segments.last;

  String get airline => firstSegment.airline;
  String get flightNumber => firstSegment.flightNumber;

  String get from => firstSegment.departure.code;
  String get to => lastSegment.arrival.code;

  String get fromCity => firstSegment.departure.name;
  String get toCity => lastSegment.arrival.name;

  DateTime? get departureTime => firstSegment.departure.time;
  DateTime? get arrivalTime => lastSegment.arrival.time;

  String get formattedDepartureTime {
    final t = departureTime;
    if (t == null) return '--:--';
    return "${_twoDigits(t.hour)}:${_twoDigits(t.minute)}";
  }

  String get formattedArrivalTime {
    final t = arrivalTime;
    if (t == null) return '--:--';
    return "${_twoDigits(t.hour)}:${_twoDigits(t.minute)}";
  }

  String get formattedDate {
    final t = departureTime;
    if (t == null) return '';
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
    return "${t.day} ${months[t.month - 1]} ${t.year}";
  }

  String get formattedDuration {
    final hours = totalDuration ~/ 60;
    final mins = totalDuration % 60;
    return mins == 0 ? '${hours}h' : '${hours}h ${mins}m';
  }

  String get stopsLabel {
    if (stops == 0) return "Non-stop";
    if (stops == 1) return "1 stop";
    return "$stops stops";
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  List<Object?> get props => [
    id,
    segments,
    totalDuration,
    stops,
    price,
    type,
    carbonEmissionKg,
  ];
}
