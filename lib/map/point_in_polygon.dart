import 'dart:ui';

bool pointInPolygon(Offset point, List<Offset> polygon) {
  var inside = false;
  for (
    var index = 0, previous = polygon.length - 1;
    index < polygon.length;
    previous = index++
  ) {
    final currentPoint = polygon[index];
    final previousPoint = polygon[previous];
    final intersects =
        currentPoint.dy > point.dy != previousPoint.dy > point.dy &&
        point.dx <
            (previousPoint.dx - currentPoint.dx) *
                    (point.dy - currentPoint.dy) /
                    (previousPoint.dy - currentPoint.dy) +
                currentPoint.dx;
    if (intersects) {
      inside = !inside;
    }
  }
  return inside;
}
