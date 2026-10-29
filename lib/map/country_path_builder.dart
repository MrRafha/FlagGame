import 'package:flutter/painting.dart';

class CountryPathBuilder {
  Path buildPolygon(List<List<Offset>> rings) {
    final path = Path()..fillType = PathFillType.evenOdd;
    for (final ring in rings) {
      if (ring.isEmpty) continue;
      path.moveTo(ring.first.dx, ring.first.dy);
      for (final point in ring.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      path.close();
    }
    return path;
  }
}
