import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/ui/map_button.dart';

/// A compass for flutter_map that shows the map rotation and allows to reset
/// the rotation back to 0.
///
/// {@category UI}
@immutable
class MapCompass extends StatelessWidget {
  /// Use this constructor if you want to customize your compass.
  const MapCompass({
    this.child,
    super.key,
    this.rotationOffset = 0,
    this.animation = const CameraAnimation.ease(
      duration: Duration(milliseconds: 200),
    ),
    this.removePinchOnPressed = false,
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

  /// Reset the camera pinch / tilt back to 0 when clicked.
  ///
  /// Defaults to false.
  final bool removePinchOnPressed;

  /// Set to true to hide the compass while the map is not rotated.
  ///
  /// Defaults to false (always visible).
  final bool hideIfRotatedNorth;

  /// The [Alignment] of the compass on the map.
  ///
  /// Default to [Alignment.topRight].
  final Alignment alignment;

  /// The padding of the compass.
  ///
  /// Defaults to 10px on all sides.
  final EdgeInsets padding;

  /// The animation that rotates the map north. Defaults to a 200 ms ease.
  final CameraAnimation animation;

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
        child: MapTapTarget(
          label: 'Compass',
          onPressed: () => _onTap(controller),
          child:
              child ??
              CustomPaint(
                painter: _CompassPainter(radius: radius),
                child: SizedBox.square(dimension: radius * 2),
              ),
        ),
      ),
    );
  }

  void _onTap(MapController controller) {
    if (rotateNorthOnPressed || removePinchOnPressed) {
      controller.animateCamera(
        CameraUpdate.position(
          bearing: rotateNorthOnPressed ? 0 : null,
          pitch: removePinchOnPressed ? 0 : null,
        ),
        animation: animation,
      );
    }
    onPressed?.call();
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
      Paint()..color = const Color(0x99FFFFFF),
    );
    // circle outline
    canvas.drawCircle(
      Offset(radius, radius),
      radius - (borderWidth / 2),
      Paint()
        ..color = const Color(0xFF000000)
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
        ..color = const Color(0xFFF44336)
        ..strokeCap = StrokeCap.butt
        ..strokeJoin = StrokeJoin.bevel
        ..strokeWidth = needsStrokeWidth,
    );
    const halfStrokeWidth = needsStrokeWidth / 2;
    canvas.drawVertices(
      Vertices(VertexMode.triangles, [
        Offset(radius - needleWidth - halfStrokeWidth, radius),
        Offset(radius, radius - needleHeight - halfStrokeWidth),
        Offset(radius + needleWidth + halfStrokeWidth, radius),
      ]),
      BlendMode.color,
      Paint()..color = const Color(0xFFF44336),
    );
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) =>
      radius != oldDelegate.radius;
}
