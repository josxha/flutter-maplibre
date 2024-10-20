import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// A compass for flutter_map that shows the map rotation and allows to reset
/// the rotation back to 0.
class Compass extends StatelessWidget {
  /// Use this constructor if you want to customize your compass.
  ///
  /// Use [Compass.cupertino] to use the default.
  const Compass({
    required this.icon,
    super.key,
    this.rotationOffset = 0,
    this.rotationDuration = const Duration(seconds: 1),
    this.animationCurve = Curves.fastOutSlowIn,
    this.onPressed,
    this.hideIfRotatedNorth = false,
    this.alignment = Alignment.topRight,
    this.padding = const EdgeInsets.all(10),
  });

  /// The default map compass based on the cupertino compass icon
  const Compass.cupertino({
    super.key,
    this.onPressed,
    this.hideIfRotatedNorth = false,
    this.rotationDuration = const Duration(seconds: 1),
    this.animationCurve = Curves.fastOutSlowIn,
    this.alignment = Alignment.topRight,
    this.padding = const EdgeInsets.all(10),
  })  : rotationOffset = -45,
        icon = const Stack(
          children: [
            Icon(CupertinoIcons.compass, color: Colors.red, size: 50),
            Icon(CupertinoIcons.compass_fill, color: Colors.white54, size: 50),
            Icon(CupertinoIcons.circle, color: Colors.black, size: 50),
          ],
        );

  /// This child widget, for example a [Icon] width with a compass icon.
  final Widget icon;

  /// Sometimes icons are rotated itself. Use this to fix the rotation offset.
  final double rotationOffset;

  /// Overrides the default behaviour for a tap or click event
  ///
  /// This will override the default behaviour.
  final VoidCallback? onPressed;

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
  /// Default to 1 second.
  final Duration rotationDuration;

  /// The curve of the rotation animation.
  final Curve animationCurve;

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
          child: IconButton(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            icon: icon,
            onPressed: onPressed ??
                () => controller.animateCamera(
                      bearing: 0,
                      nativeDuration: const Duration(milliseconds: 200),
                    ),
          ),
        ),
      ),
    );
  }
}
