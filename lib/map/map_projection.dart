import 'dart:math' as math;

import 'package:flutter/painting.dart';

class MapProjection {
  const MapProjection({
    required this.bounds,
    required this.longitudeRange,
    required this.latitudeRange,
  });

  final Rect bounds;
  final ({double min, double max}) longitudeRange;
  final ({double min, double max}) latitudeRange;

  Offset project(double longitude, double latitude) {
    final longitudeSpan = longitudeRange.max - longitudeRange.min;
    final latitudeSpan = latitudeRange.max - latitudeRange.min;
    final scale = math.min(
      bounds.width / longitudeSpan,
      bounds.height / latitudeSpan,
    );
    final mapWidth = longitudeSpan * scale;
    final mapHeight = latitudeSpan * scale;
    final left = bounds.left + (bounds.width - mapWidth) / 2;
    final top = bounds.top + (bounds.height - mapHeight) / 2;
    final x = (longitude - longitudeRange.min) * scale;
    final y = (latitudeRange.max - latitude) * scale;
    return Offset(x + left, y + top);
  }

  double distanceInRadians(double degrees) => degrees * math.pi / 180;
}
