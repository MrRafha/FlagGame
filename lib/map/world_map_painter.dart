import 'package:flutter/material.dart';

class WorldMapPainter extends CustomPainter {
  const WorldMapPainter({
    required this.paths,
    required this.labels,
    required this.resolvedCodes,
  });

  final Map<String, Path> paths;
  final Map<String, String> labels;
  final Set<String> resolvedCodes;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFE7F1F4),
    );
    final fill = Paint()..style = PaintingStyle.fill;
    final border = Paint()
      ..color = const Color(0xFF49615D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    for (final entry in paths.entries) {
      fill.color = resolvedCodes.contains(entry.key)
          ? const Color(0xFFFFC857)
          : const Color(0xFFCFE2D2);
      canvas
        ..drawPath(entry.value, fill)
        ..drawPath(entry.value, border);
      final label = labels[entry.key];
      final bounds = entry.value.getBounds();
      if (label != null) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Color(0xFF202820),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: 100);
        textPainter.paint(
          canvas,
          Offset(
            bounds.center.dx - textPainter.width / 2,
            bounds.center.dy - textPainter.height / 2,
          ),
        );
      }
      if (!resolvedCodes.contains(entry.key)) continue;
      final checkPainter = TextPainter(
        text: const TextSpan(
          text: '✓',
          style: TextStyle(
            color: Color(0xFF27643B),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      checkPainter.paint(
        canvas,
        Offset(bounds.right - checkPainter.width - 4, bounds.top + 4),
      );
    }
  }

  @override
  bool shouldRepaint(WorldMapPainter oldDelegate) {
    return oldDelegate.paths != paths ||
        oldDelegate.labels != labels ||
        oldDelegate.resolvedCodes != resolvedCodes;
  }
}
