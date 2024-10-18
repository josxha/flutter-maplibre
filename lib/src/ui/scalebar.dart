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

  final _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final meters = metersPerPixel * 200;
    canvas.drawLine(Offset.zero, const Offset(200, 0), _paint);

    final textPainter = TextPainter(
      text: TextSpan(
        // style: TextStyle(color: Colors.blue[800]),
        text: '${meters.toStringAsFixed(0)} m',
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(0, -20));
  }

  @override
  bool shouldRepaint(covariant _ScaleBarPainter oldDelegate) =>
      metersPerPixel != oldDelegate.metersPerPixel;
}
