enum FlightClass {
  economy,
  business;

  String get displayName {
    switch (this) {
      case FlightClass.economy:
        return 'ECONOMY CLASS';
      case FlightClass.business:
        return 'BUSINESS CLASS';
    }
  }

  static FlightClass fromString(String value) {
    switch (value.toUpperCase()) {
      case 'BUSINESS CLASS':
        return FlightClass.business;
      default:
        return FlightClass.economy;
    }
  }
}
