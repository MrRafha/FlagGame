import 'dart:math' as math;

import 'package:flutter/painting.dart';

class CountryHitTester {
  const CountryHitTester({this.tolerance = 6});

  final double tolerance;

  String? hitTest({
    required Offset position,
    required Map<String, Path> paths,
    required Set<String> interactiveCodes,
  }) {
    final exactMatches = paths.entries
        .where(
          (entry) =>
              interactiveCodes.contains(entry.key) &&
              entry.value.contains(position),
        )
        .toList(growable: false);
    if (exactMatches.isNotEmpty) {
      return _smallestBoundsMatch(exactMatches);
    }

    String? closestCode;
    var closestDistance = double.infinity;
    for (final entry in paths.entries) {
      if (!interactiveCodes.contains(entry.key)) continue;
      final distance = _distanceToPath(position, entry.value);
      if (distance <= tolerance && distance < closestDistance) {
        closestCode = entry.key;
        closestDistance = distance;
      }
    }
    return closestCode;
  }

  String _smallestBoundsMatch(List<MapEntry<String, Path>> matches) {
    return matches.reduce((left, right) {
      final leftArea = _area(left.value.getBounds());
      final rightArea = _area(right.value.getBounds());
      return leftArea <= rightArea ? left : right;
    }).key;
  }

  double _area(Rect rect) => rect.width * rect.height;

  double _distanceToPath(Offset point, Path path) {
    var closest = double.infinity;
    for (final metric in path.computeMetrics(forceClosed: true)) {
      for (var distance = 0.0; distance <= metric.length; distance += 4) {
        final tangent = metric.getTangentForOffset(distance);
        if (tangent == null) continue;
        final delta = tangent.position - point;
        final squared = delta.dx * delta.dx + delta.dy * delta.dy;
        if (squared < closest) closest = squared;
      }
    }
    return closest == double.infinity ? closest : math.sqrt(closest);
  }
}
