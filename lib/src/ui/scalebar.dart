import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

/// Display a scalebar to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
class Scalebar extends StatelessWidget {
  /// Display a scalebar to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const Scalebar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();
    final camera = controller.getCamera();
    final futureMetersPerPixel = controller.getMetersPerPixelAtLatitude(
      camera.center.lat.toDouble(),
    );
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(12),
      child: FutureBuilder<double>(
        future: futureMetersPerPixel,
        builder: (context, snapshot) {
          if (snapshot.data case final double data) {
            return CustomPaint(painter: _ScaleBarPainter(data));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ScaleBarPainter extends CustomPainter {
  _ScaleBarPainter(this.metersPerPixel);

  final double metersPerPixel;

  final _linePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 1.5;

  final _backgroundPaint = Paint()..color = Colors.white60;

  @override
  void paint(Canvas canvas, Size size) {
    final unit = metersPerPixel >= 10 ? _Unit.km : _Unit.m;
    debugPrint('metersPerPixel: $metersPerPixel, unit: ${unit.name}');
    final meters = switch (metersPerPixel) {
      >= 500000 => 50000000,
      >= 300000 => 30000000,
      >= 200000 => 20000000,
      >= 100000 => 10000000,
      >= 50000 => 5000000,
      >= 30000 => 3000000,
      >= 20000 => 2000000,
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
    final width = meters / metersPerPixel;
    canvas.drawVertices(
      Vertices.raw(
        VertexMode.triangles,
        Float32List.fromList(
          [0, -22, 0, 0, width, -22, 0, 0, width, 0, width, -22],
        ),
      ),
      BlendMode.color,
      _backgroundPaint,
    );
    canvas.drawRawPoints(
      PointMode.lines,
      Float32List.fromList(
        [0, -22, 0, 0, 0, 0, width, 0, width, 0, width, -22],
      ),
      _linePaint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        style: const TextStyle(fontSize: 12),
        text: '${meters / unit.meters} ${unit.abbreviation}',
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(5, -18));
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
