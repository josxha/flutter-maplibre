import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/translucent_pointer.dart';

/// Use the [WidgetLayer] to display [Widget]s on the [MapLibreMap]
/// by using it in [MapLibreMap.children].
class WidgetLayer extends StatelessWidget {
  /// Create a new [WidgetLayer] widget.
  const WidgetLayer({required this.markers, super.key});

  /// The list of [Marker]s.
  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    final camera = MapCamera.maybeOf(context);
    if (controller == null || camera == null) return const SizedBox.shrink();

    // Only Android returns screen pixel, other platforms return logical pixels.
    final pixelRatio = (!kIsWeb && Platform.isAndroid)
        ? MediaQuery.devicePixelRatioOf(context)
        : 1.0;

    final child = Stack(
      children: markers.map((m) {
        final matrix = Matrix4.identity();
        if (m.flat) matrix.rotateX(camera.pitch * degree2Radian);
        if (m.rotate) matrix.rotateZ(-camera.bearing * degree2Radian);
        return FutureBuilder<Offset>(
          future: controller.toScreenLocation(m.point),
          builder: (context, snapshot) {
            if (snapshot.data case final Offset offset) {
              return Positioned(
                left: offset.dx / pixelRatio -
                    m.size.width / 2 * (m.alignment.x + 1),
                top: offset.dy / pixelRatio -
                    m.size.height / 2 * (m.alignment.y + 1),
                height: m.size.height,
                width: m.size.width,
                child: Transform(
                  transform: matrix,
                  alignment: m.alignment,
                  child: m.child,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      }).toList(growable: false),
    );
    if (kIsWeb) return child;
    // Android needs a TranslucentPointer
    return TranslucentPointer(child: child);
  }
}

/// Model class for a widget marker, can be used in a [WidgetLayer].
@immutable
class Marker {
  /// Create a new [Marker] instance.
  const Marker({
    required this.point,
    required this.size,
    required this.child,
    this.alignment = Alignment.center,
    this.rotate = false,
    this.flat = false,
  });

  /// The [Position] of the [Marker].
  final Position point;

  /// The [Size] of the [Marker]. This needs to be set to the same dimensions
  /// as the [child] Widget.
  final Size size;

  /// Set to true if the marker should rotate with the map. The [Marker] stays
  /// upright when set to false.
  ///
  /// Defaults to false.
  final bool rotate;

  /// Set to true if the marker should be rendered flat on the map when the map
  /// camera is tilted. with the map.
  ///
  /// Defaults to false.
  final bool flat;

  /// Set the [Alignment] of the marker. Defaults to [Alignment.center].
  final Alignment alignment;

  /// The child widget. You can use any kind of [Widget] here. Use a [Builder]
  /// if you need to access the [MapLibreMap] context.
  final Widget child;
}
