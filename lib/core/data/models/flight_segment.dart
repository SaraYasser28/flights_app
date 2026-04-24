import 'airport.dart';

class FlightSegment {
  final Airport departure;
  final Airport arrival;
  final int duration;
  final String airline;
  final String flightNumber;
  final String airplane;
  final String travelClass;
  final List<String> amenities;
  final double? carbonEmissionsKg;
  final String? airlineLogo;

  const FlightSegment({
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.airline,
    required this.flightNumber,
    required this.airplane,
    required this.travelClass,
    required this.amenities,
    this.carbonEmissionsKg,
    this.airlineLogo,
  });

  factory FlightSegment.fromApi(Map<String, dynamic> json) {
    final extensions = (json['extensions'] as List?)?.cast<String>() ?? [];
    double? carbonKg;
    for (final ext in extensions) {
      final match = RegExp(
        r'Carbon emissions estimate:\s*([\d.]+)\s*kg',
      ).firstMatch(ext);
      if (match != null) {
        carbonKg = double.tryParse(match.group(1)!);
        break;
      }
    }

    return FlightSegment(
      departure: Airport.fromApi(json['departure_airport']),
      arrival: Airport.fromApi(json['arrival_airport']),
      duration: json['duration'] ?? 0,
      airline: json['airline'] ?? '',
      flightNumber: json['flight_number'] ?? '',
      airplane: json['airplane'] ?? '',
      travelClass: json['travel_class'] ?? '',
      amenities: extensions,
      carbonEmissionsKg: carbonKg,
      airlineLogo: json['airline_logo'],
    );
  }

  factory FlightSegment.fromJson(Map<String, dynamic> json) {
    return FlightSegment(
      departure: Airport.fromJson(json['departure']),
      arrival: Airport.fromJson(json['arrival']),
      duration: json['duration'] ?? 0,
      airline: json['airline'] ?? '',
      flightNumber: json['flightNumber'] ?? '',
      airplane: json['airplane'] ?? '',
      travelClass: json['travelClass'] ?? '',
      amenities: (json['amenities'] as List?)?.cast<String>() ?? [],
      carbonEmissionsKg: json['carbonEmissionsKg'] != null
          ? (json['carbonEmissionsKg'] as num).toDouble()
          : null,
      airlineLogo: json['airlineLogo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "departure": departure.toJson(),
      "arrival": arrival.toJson(),
      "duration": duration,
      "airline": airline,
      "flightNumber": flightNumber,
      "airplane": airplane,
      "travelClass": travelClass,
      "amenities": amenities,
      "carbonEmissionsKg": carbonEmissionsKg,
      "airlineLogo": airlineLogo,
    };
  }
}
