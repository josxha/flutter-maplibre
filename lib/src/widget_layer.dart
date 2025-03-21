import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/translucent_pointer.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Use the [WidgetLayer] to display [Widget]s on the [MapLibreMap]
/// by using it in [MapLibreMap.children].
///
/// {@category Layers}
class WidgetLayer extends StatelessWidget {
  /// Create a new [WidgetLayer] widget.
  const WidgetLayer({
    required this.markers,
    this.allowInteraction = false,
    super.key,
  });

  /// The list of [Marker]s.
  final List<Marker> markers;

  /// Allow gestures on [Marker]s.
  final bool allowInteraction;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    final camera = MapCamera.maybeOf(context);
    if (controller == null || camera == null) return const SizedBox.shrink();

    // Only Android returns screen pixel, other platforms return logical pixels.
    final pixelRatio =
        (!kIsWeb && Platform.isAndroid)
            ? MediaQuery.devicePixelRatioOf(context)
            : 1.0;

    Widget buildChild(List<Offset> offsets) => LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          // TODO: filter markers that are completely outside of the visible screen.
          children: markers.indexed
              .map((e) {
                final markerOffset = offsets[e.$1];
                final marker = e.$2;

                final matrix = Matrix4.identity();
                if (marker.flat) matrix.rotateX(camera.pitch * degree2Radian);
                if (marker.rotate) {
                  matrix.rotateZ(-camera.bearing * degree2Radian);
                }

                final left =
                    markerOffset.dx / pixelRatio -
                    marker.size.width / 2 * (marker.alignment.x + 1);
                final top =
                    markerOffset.dy / pixelRatio -
                    marker.size.height / 2 * (marker.alignment.y + 1);
                final centerHorizontal = top + marker.size.height / 2;
                final centerVertical = left + marker.size.width / 2;
                final bottom = top + marker.size.height;

                final markerWidget = Positioned(
                  left: left,
                  top: top,
                  height: marker.size.height,
                  width: marker.size.width,
                  child: Transform(
                    transform: matrix,
                    alignment: marker.alignment,
                    child: marker.child,
                  ),
                );

                List<Widget> createAnnotations() {
                  return List.generate(marker.annotations.length, (index) {
                    final annotationOffset = marker.annotations[index].offset;

                    return Positioned(
                      top: switch (marker.annotations[index].alignment) {
                        Alignment.topLeft ||
                        Alignment.topRight => top + annotationOffset.dy,
                        Alignment.centerLeft || Alignment.centerRight =>
                          centerHorizontal + annotationOffset.dy,
                        Alignment.bottomCenter => markerOffset.dy / pixelRatio,
                        _ => null,
                      },
                      bottom: switch (marker.annotations[index].alignment) {
                        Alignment.bottomLeft || Alignment.bottomRight =>
                          constraints.maxHeight - bottom + annotationOffset.dy,
                        Alignment.topCenter => constraints.maxHeight - top,
                        _ => null,
                      },
                      right: switch (marker.annotations[index].alignment) {
                        Alignment.topLeft ||
                        Alignment.centerLeft ||
                        Alignment.bottomLeft =>
                          constraints.maxWidth - left + annotationOffset.dx,
                        _ => null,
                      },
                      left: switch (marker.annotations[index].alignment) {
                        Alignment.topRight ||
                        Alignment.centerRight ||
                        Alignment.bottomRight =>
                          left + marker.size.width + annotationOffset.dx,
                        Alignment.topCenter || Alignment.bottomCenter =>
                          centerVertical + annotationOffset.dx,
                        _ => null,
                      },

                      child: marker.annotations[index].child,
                    );
                  });
                }

                final stack = Stack(
                  children: [markerWidget, ...createAnnotations()],
                );

                return stack;
              })
              .toList(growable: false),
        );
      },
    );

    final points = markers.map((m) => m.point).toList(growable: false);

    if (kIsWeb) {
      final offsets = controller.toScreenLocationsSync(points);
      return buildChild(offsets);
    }

    Widget buildChildAsync(List<Position> points) =>
        FutureBuilder<List<Offset>>(
          future: controller.toScreenLocations(points),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.length == markers.length) {
              final offsets = snapshot.data!;

              return buildChild(offsets);
            }

            if (snapshot.error case final Object error) {
              debugPrint(error.toString());
              debugPrintStack(stackTrace: snapshot.stackTrace);
            }

            return const SizedBox.shrink();
          },
        );

    if (allowInteraction) {
      // Web requires a PointerInterceptor to prevent the HtmlElementView from
      // recieving gestures.
      return PointerInterceptor(child: buildChildAsync(points));
    } else {
      // Android needs a TranslucentPointer so that the widgets don't prevent
      // panning on the map.
      return TranslucentPointer(child: buildChildAsync(points));
    }
  }
}

/// Model class for a widget marker, can be used in a [WidgetLayer].
///
/// {@category Layers}
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
    this.annotations = const [],
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

  /// A list of annotations.
  final List<Annotation> annotations;
}

/// Model class for a widget marker's annotation, can be used in a [WidgetLayer].
///
/// {@category Layers}
@immutable
class Annotation {
  /// Create a new [Annotation] instance.
  const Annotation({
    required this.child,
    required this.alignment,
    this.offset = Offset.zero,
  });

  /// The child widget. You can use any kind of [Widget] here. Use a [Builder]
  /// if you need to access the [MapLibreMap] context.
  final Widget child;

  /// Set the [Alignment] of the marker. Defaults to [Alignment.center].
  final Alignment alignment;

  /// Annotation offset relative to Alignment
  final Offset offset;
}
