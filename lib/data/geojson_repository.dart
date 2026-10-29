import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/country_geometry.dart';

class GeoJsonRepository {
  const GeoJsonRepository({AssetBundle? bundle}) : _bundle = bundle;

  final AssetBundle? _bundle;

  Future<List<CountryGeometry>> load({
    String assetPath = 'assets/geo/world.geojson',
  }) async {
    final bundle = _bundle ?? rootBundle;
    final decoded = jsonDecode(await bundle.loadString(assetPath));
    if (decoded is! Map<String, dynamic> ||
        decoded['type'] != 'FeatureCollection' ||
        decoded['features'] is! List) {
      throw const FormatException('GeoJSON precisa ser uma FeatureCollection.');
    }

    return (decoded['features'] as List)
        .map(_parseFeature)
        .whereType<CountryGeometry>()
        .toList(growable: false);
  }

  CountryGeometry? _parseFeature(dynamic value) {
    if (value is! Map<String, dynamic>) return null;
    final properties = value['properties'];
    final geometry = value['geometry'];
    if (properties is! Map || geometry is! Map) return null;
    final code = properties['ISO3166-1-Alpha-2'];
    final type = geometry['type'];
    final coordinates = geometry['coordinates'];
    if (code is! String || coordinates is! List) return null;

    final polygons = switch (type) {
      'Polygon' => [_parsePolygon(coordinates)],
      'MultiPolygon' =>
        coordinates
            .whereType<List>()
            .map(_parsePolygon)
            .toList(growable: false),
      _ => const <List<List<Offset>>>[],
    };
    return polygons.isEmpty
        ? null
        : CountryGeometry(countryCode: code, polygons: polygons);
  }

  List<List<Offset>> _parsePolygon(List<dynamic> rings) {
    return rings
        .whereType<List>()
        .map(
          (ring) => ring
              .whereType<List>()
              .where((point) => point.length >= 2)
              .map(
                (point) => Offset(
                  (point[0] as num).toDouble(),
                  (point[1] as num).toDouble(),
                ),
              )
              .toList(growable: false),
        )
        .where((ring) => ring.length >= 3)
        .toList(growable: false);
  }
}
