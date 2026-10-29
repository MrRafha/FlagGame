import 'package:flutter/material.dart';
import '../data/geojson_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/country_geometry.dart';
import 'country_hit_tester.dart';
import 'country_path_builder.dart';
import 'map_definition.dart';
import 'map_projection.dart';
import 'world_map_painter.dart';

class InteractiveMap extends StatefulWidget {
  const InteractiveMap({
    super.key,
    this.onCountrySelected,
    this.resolvedCodes = const {},
    this.labels = const {},
    this.mapDefinition = MapDefinition.world,
    this.interactiveCodes = const {},
    this.allowZoom = true,
  });

  final ValueChanged<String>? onCountrySelected;
  final Set<String> resolvedCodes;
  final Map<String, String> labels;
  final MapDefinition mapDefinition;
  final Set<String> interactiveCodes;
  final bool allowZoom;

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final _mapKey = GlobalKey();
  static const _hitTester = CountryHitTester();

  late final Future<List<CountryGeometry>> _geometry = const GeoJsonRepository()
      .load();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<List<CountryGeometry>>(
      future: _geometry,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${l10n.mapLoadError} ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            final geometries = snapshot.data!
                .map(_geometryInViewport)
                .whereType<CountryGeometry>()
                .toList(growable: false);
            final paths = _buildPaths(geometries, constraints.biggest);
            final map = DragTarget<String>(
              onAcceptWithDetails: (details) {
                final renderObject = _mapKey.currentContext?.findRenderObject();
                if (renderObject is! RenderBox) return;
                final viewportPosition = renderObject.globalToLocal(
                  details.offset,
                );
                final country = _hitTester.hitTest(
                  position: viewportPosition,
                  paths: paths,
                  interactiveCodes: widget.interactiveCodes,
                );
                if (country != null) {
                  widget.onCountrySelected?.call(country);
                }
              },
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  key: _mapKey,
                  fit: StackFit.expand,
                  children: [
                    CustomPaint(
                      painter: WorldMapPainter(
                        paths: paths,
                        labels: widget.labels,
                        resolvedCodes: widget.resolvedCodes,
                      ),
                      child: const SizedBox.expand(),
                    ),
                    IgnorePointer(
                      child: CustomPaint(painter: _BorderPainter(paths: paths)),
                    ),
                  ],
                );
              },
            );
            return widget.allowZoom
                ? InteractiveViewer(
                    minScale: 1,
                    maxScale: 4,
                    boundaryMargin: const EdgeInsets.all(80),
                    child: map,
                  )
                : map;
          },
        );
      },
    );
  }

  CountryGeometry? _geometryInViewport(CountryGeometry geometry) {
    final polygons = geometry.polygons
        .where(
          (polygon) => polygon.any(
            (ring) => ring.any(
              (point) =>
                  point.dx >= widget.mapDefinition.longitudeRange.min &&
                  point.dx <= widget.mapDefinition.longitudeRange.max &&
                  point.dy >= widget.mapDefinition.latitudeRange.min &&
                  point.dy <= widget.mapDefinition.latitudeRange.max,
            ),
          ),
        )
        .toList(growable: false);
    return polygons.isEmpty
        ? null
        : CountryGeometry(
            countryCode: geometry.countryCode,
            polygons: polygons,
          );
  }

  Map<String, Path> _buildPaths(List<CountryGeometry> geometries, Size size) {
    final projection = MapProjection(
      bounds: Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
      longitudeRange: widget.mapDefinition.longitudeRange,
      latitudeRange: widget.mapDefinition.latitudeRange,
    );
    final builder = CountryPathBuilder();
    return {
      for (final geometry in geometries)
        geometry.countryCode: builder.buildPolygon(
          geometry.polygons
              .expand(
                (polygon) => polygon.map(
                  (ring) => ring
                      .map((point) => projection.project(point.dx, point.dy))
                      .toList(growable: false),
                ),
              )
              .toList(growable: false),
        ),
    };
  }
}

class _BorderPainter extends CustomPainter {
  const _BorderPainter({required this.paths});

  final Map<String, Path> paths;

  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = const Color(0xFF49615D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    for (final path in paths.values) {
      canvas.drawPath(path, border);
    }
  }

  @override
  bool shouldRepaint(_BorderPainter oldDelegate) => oldDelegate.paths != paths;
}
