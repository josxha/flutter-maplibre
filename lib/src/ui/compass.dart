import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// A compass for flutter_map that shows the map rotation and allows to reset
/// the rotation back to 0.
class Compass extends StatelessWidget {
  /// Use this constructor if you want to customize your compass.
  const Compass({
    this.child,
    super.key,
    this.rotationOffset = 0,
    this.rotationDuration = const Duration(milliseconds: 200),
    this.rotateNorthOnPressed = true,
    this.onPressed,
    this.hideIfRotatedNorth = false,
    this.alignment = Alignment.topRight,
    this.padding = const EdgeInsets.all(10),
    this.radius = 22,
  });

  /// Override the compass widget.
  final Widget? child;

  /// Sometimes icons are rotated itself. Use this to fix the rotation offset.
  final double rotationOffset;

  /// Overrides the default behaviour for a tap or click event
  ///
  /// This will override the default behaviour.
  final VoidCallback? onPressed;

  /// Rotate the map to 0 bearing when clicked.
  ///
  /// Defaults to true.
  final bool rotateNorthOnPressed;

  /// Set to true to hide the compass while the map is not rotated.
  ///
  /// Defaults to false (always visible).
  final bool hideIfRotatedNorth;

  /// The [Alignment] of the compass on the map.
  ///
  /// Default to [Alignment.topRight].
  final Alignment alignment;

  /// The padding of the compass
  ///
  /// Defaults to 10px on all sides.
  final EdgeInsets padding;

  /// The duration of the rotation animation.
  ///
  /// Default to 200 ms.
  final Duration rotationDuration;

  /// The compass radius.
  final double radius;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();

    final camera = controller.getCamera();
    if (hideIfRotatedNorth && camera.bearing == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: alignment,
      padding: padding,
      child: Transform.rotate(
        angle: (-camera.bearing + rotationOffset) * degree2Radian,
        child: PointerInterceptor(
          child: InkWell(
            onTap: () {
              if (rotateNorthOnPressed) {
                controller.animateCamera(
                  bearing: 0,
                  nativeDuration: rotationDuration,
                );
              }
              onPressed?.call();
            },
            child: child ??
                CustomPaint(
                  painter: _CompassPainter(radius: radius),
                  child: SizedBox.square(dimension: radius * 2),
                ),
          ),
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  _CompassPainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    const needleHeight = 13.0;
    const needleWidth = 5.0;
    const needsStrokeWidth = 1.5;
    const borderWidth = 3.0;

    // background
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      Paint()..color = Colors.white60,
    );
    // circle outline
    canvas.drawCircle(
      Offset(radius, radius),
      radius - (borderWidth / 2),
      Paint()
        ..color = Colors.black
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );
    // compass needle
    canvas.drawPath(
      Path()
        ..moveTo(radius - needleWidth, radius)
        ..lineTo(radius, radius + needleHeight)
        ..lineTo(radius + needleWidth, radius),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.red
        ..strokeCap = StrokeCap.butt
        ..strokeJoin = StrokeJoin.bevel
        ..strokeWidth = needsStrokeWidth,
    );
    const halfStrokeWidth = needsStrokeWidth / 2;
    canvas.drawVertices(
      Vertices(
        VertexMode.triangles,
        [
          Offset(radius - needleWidth - halfStrokeWidth, radius),
          Offset(radius, radius - needleHeight - halfStrokeWidth),
          Offset(radius + needleWidth + halfStrokeWidth, radius),
        ],
      ),
      BlendMode.color,
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) =>
      radius != oldDelegate.radius;
}
