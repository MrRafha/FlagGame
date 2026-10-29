import 'dart:ui';

class CountryGeometry {
  const CountryGeometry({required this.countryCode, required this.polygons});

  final String countryCode;
  final List<List<List<Offset>>> polygons;
}
