import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

/// Display a scalebar to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
///
/// {@category UI}
@immutable
class MapScalebar extends StatelessWidget {
  /// Display a scalebar to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const MapScalebar({
    this.alignment = Alignment.bottomLeft,
    this.padding = const EdgeInsets.all(12),
    super.key,
  });

  /// The [Alignment] of the scalebar controls in what corner the scalebar
  /// gets drawn.
  final Alignment alignment;

  /// The [padding] of the scalebar.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    final camera = MapCamera.maybeOf(context);
    if (controller == null || camera == null) return const SizedBox.shrink();

    final latitude = camera.center.lat.toDouble();
    final theme = Theme.of(context);

    final metersPerPixel = controller.getMetersPerPixelAtLatitudeSync(latitude);
    final painter = _ScaleBarPainter(metersPerPixel, theme);
    // Use a SafeArea to ensure the widget is completely visible on devices
    // with rounded edges like iOS.
    return SafeArea(
      child: Container(
      alignment: alignment,
      padding: padding,
      child: CustomPaint(painter: painter, size: Size(painter.width, 22)),
    ),
    );
  }
}

class _ScaleBarPainter extends CustomPainter {
  _ScaleBarPainter(this.metersPerPixel, this.theme);

  final double metersPerPixel;
  final ThemeData theme;
  late final meters = switch (metersPerPixel) {
    >= 300000 => 50000000,
    >= 200000 => 30000000,
    >= 100000 => 20000000,
    >= 75000 => 10000000,
    >= 50000 => 5000000,
    >= 30000 => 3000000,
    >= 15000 => 2000000,
    >= 10000 => 1000000,
    >= 5000 => 500000,
    >= 3000 => 300000,
    >= 2000 => 200000,
    >= 1000 => 100000,
    >= 500 => 50000,
    >= 300 => 30000,
    >= 200 => 20000,
    >= 100 => 10000,
    >= 50 => 5000,
    >= 30 => 3000,
    >= 20 => 2000,
    >= 10 => 1000,
    >= 5 => 500,
    >= 3 => 300,
    >= 2 => 200,
    >= 1 => 100,
    >= 0.5 => 50,
    >= 0.3 => 30,
    >= 0.2 => 20,
    >= 0.1 => 10,
    >= 0.05 => 5,
    >= 0.03 => 3,
    >= 0.02 => 2,
    >= 0.01 => 1,
    _ => metersPerPixel * 100,
  };
  late final double width = meters / metersPerPixel;

  late final _linePaint =
      Paint()
        ..color = Colors.black
        ..strokeWidth = 1.5;

  late final _backgroundPaint = Paint()..color = Colors.white60;

  @override
  void paint(Canvas canvas, Size size) {
    final unit = metersPerPixel >= 10 ? _Unit.km : _Unit.m;
    canvas.drawVertices(
      Vertices.raw(
        VertexMode.triangles,
        Float32List.fromList([
          0,
          22,
          0,
          0,
          width,
          22,
          0,
          0,
          width,
          0,
          width,
          22,
        ]),
      ),
      BlendMode.color,
      _backgroundPaint,
    );
    canvas.drawRawPoints(
      PointMode.lines,
      Float32List.fromList([
        0,
        22,
        0,
        0,
        0,
        22,
        width,
        22,
        width,
        0,
        width,
        22,
      ]),
      _linePaint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
        text: '${(meters / unit.meters).toInt()} ${unit.abbreviation}',
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(5, 5));
  }

  @override
  bool shouldRepaint(covariant _ScaleBarPainter oldDelegate) =>
      metersPerPixel != oldDelegate.metersPerPixel;
}

enum _Unit {
  km(1000, 'km'),
  m(1, 'm');

  const _Unit(this.meters, this.abbreviation);

  final int meters;
  final String abbreviation;
}
