import 'package:equatable/equatable.dart';

class Airport extends Equatable {
  final String code;
  final String name;
  final DateTime? time;

  const Airport({required this.code, required this.name, this.time});

  String get city {
    if (name.isEmpty) return '';

    final cleaned = name
        .replaceAll('International Airport', '')
        .replaceAll('Airport', '')
        .trim();
    // Split on spaces and dashes
    final parts = cleaned.split(RegExp(r'[\s\-–—]+'));
    if (parts.isEmpty) return '';
    return parts.first;
  }

  factory Airport.fromApi(Map<String, dynamic> json) {
    return Airport(
      code: json['id'] ?? '',
      name: json['name'] ?? '',
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
    );
  }

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "name": name, "time": time?.toIso8601String()};
  }

  @override
  List<Object?> get props => [code, name, time];
}
