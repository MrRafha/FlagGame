import '../models/country.dart';

class MapDefinition {
  const MapDefinition({
    required this.name,
    required this.longitudeRange,
    required this.latitudeRange,
  });

  final String name;
  final ({double min, double max}) longitudeRange;
  final ({double min, double max}) latitudeRange;

  static const world = MapDefinition(
    name: 'world',
    longitudeRange: (min: -180, max: 180),
    latitudeRange: (min: -60, max: 85),
  );

  static const america = MapDefinition(
    name: 'america',
    longitudeRange: (min: -170, max: -30),
    latitudeRange: (min: -56, max: 72),
  );

  static const europe = MapDefinition(
    name: 'europe',
    longitudeRange: (min: -12, max: 45),
    latitudeRange: (min: 34, max: 72),
  );

  static const africa = MapDefinition(
    name: 'africa',
    longitudeRange: (min: -20, max: 55),
    latitudeRange: (min: -36, max: 38),
  );

  static const asia = MapDefinition(
    name: 'asia',
    longitudeRange: (min: 25, max: 180),
    latitudeRange: (min: -10, max: 80),
  );

  static const oceania = MapDefinition(
    name: 'oceania',
    longitudeRange: (min: 105, max: 180),
    latitudeRange: (min: -50, max: 10),
  );

  static MapDefinition forContinent(Continent? continent) {
    return switch (continent) {
      Continent.africa => africa,
      Continent.america => america,
      Continent.asia => asia,
      Continent.europe => europe,
      Continent.oceania => oceania,
      null => world,
    };
  }
}
