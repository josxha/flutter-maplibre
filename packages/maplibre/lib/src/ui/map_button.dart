import 'dart:math';

import 'package:flutter/widgets.dart';

/// A round button that the map controls share, drawn without any design
/// library.
@immutable
class MapButton extends StatelessWidget {
  /// Creates a round map button.
  const MapButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.size = 48,
    this.iconSize = 24,
    super.key,
  });

  /// The icon on the button.
  final MapButtonIcon icon;

  /// The semantic label of the button.
  final String label;

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// The diameter of the button.
  final double size;

  /// The size of the icon.
  final double iconSize;

  /// The background color of a button.
  static const backgroundColor = Color(0xFFFFFFFF);

  /// The color of an icon.
  static const iconColor = Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: CustomPaint(
              size: Size.square(iconSize),
              painter: MapButtonIconPainter(icon, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}

/// The icons that [MapButton] can draw.
enum MapButtonIcon {
  /// A plus sign.
  zoomIn,

  /// A minus sign.
  zoomOut,

  /// A crosshair without a center dot: the location is not tracked.
  locationOff,

  /// A crosshair with a center dot: the location is tracked.
  location,

  /// A compass needle: the location and heading are tracked.
  locationAndHeading,

  /// An "i" in a circle.
  info,
}

/// Paints a [MapButtonIcon] in a square of the canvas size.
class MapButtonIconPainter extends CustomPainter {
  /// Paints [icon] in [color].
  const MapButtonIconPainter(this.icon, {required this.color});

  /// The icon to paint.
  final MapButtonIcon icon;

  /// The color of the icon.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final c = size.center(Offset.zero);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s / 12
      ..strokeCap = StrokeCap.round;
    final fill = Paint()..color = color;

    switch (icon) {
      case MapButtonIcon.zoomIn:
        canvas
          ..drawLine(c.translate(-s * .3, 0), c.translate(s * .3, 0), stroke)
          ..drawLine(c.translate(0, -s * .3), c.translate(0, s * .3), stroke);
      case MapButtonIcon.zoomOut:
        canvas.drawLine(
          c.translate(-s * .3, 0),
          c.translate(s * .3, 0),
          stroke,
        );
      case MapButtonIcon.locationOff || MapButtonIcon.location:
        canvas.drawCircle(c, s * .3, stroke);
        for (final (dx, dy) in const [(0, -1), (0, 1), (-1, 0), (1, 0)]) {
          canvas.drawLine(
            c.translate(dx * s * .3, dy * s * .3),
            c.translate(dx * s * .45, dy * s * .45),
            stroke,
          );
        }
        if (icon == MapButtonIcon.location) {
          canvas.drawCircle(c, s * .14, fill);
        }
      case MapButtonIcon.locationAndHeading:
        canvas.drawCircle(c, s * .42, stroke);
        final needle = Path()
          ..moveTo(c.dx, c.dy - s * .3)
          ..lineTo(c.dx + s * .12, c.dy)
          ..lineTo(c.dx, c.dy + s * .3)
          ..lineTo(c.dx - s * .12, c.dy)
          ..close();
        canvas
          ..save()
          ..translate(c.dx, c.dy)
          ..rotate(pi / 4)
          ..translate(-c.dx, -c.dy)
          ..drawPath(needle, fill)
          ..restore();
      case MapButtonIcon.info:
        canvas
          ..drawCircle(c, s * .45, fill)
          ..drawCircle(
            c.translate(0, -s * .2),
            s * .065,
            Paint()..color = MapButton.backgroundColor,
          )
          ..drawLine(
            c.translate(0, -s * .04),
            c.translate(0, s * .24),
            Paint()
              ..color = MapButton.backgroundColor
              ..strokeWidth = s * .12
              ..strokeCap = StrokeCap.round,
          );
    }
  }

  @override
  bool shouldRepaint(covariant MapButtonIconPainter oldDelegate) =>
      icon != oldDelegate.icon || color != oldDelegate.color;
}
