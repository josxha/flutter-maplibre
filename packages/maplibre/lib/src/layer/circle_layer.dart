import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A [Point] layer.
///
/// {@category Layers}
@immutable
class CircleLayer extends Layer<Feature<Point>> {
  /// Create a new [CircleLayer] instance.
  const CircleLayer({
    required List<Feature<Point>> points,
    this.radius = const .literal(5),
    this.color = const .literal(Color(0xFF000000)),
    this.blur = const .literal(0),
    this.opacity = const .literal(1),
    this.strokeWidth = const .literal(0),
    this.strokeColor = const .literal(Color(0xFF000000)),
    this.strokeOpacity = const .literal(1),
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super(list: points);

  /// Circle radius in pixels. Defaults to 5px.
  final Expression<num> radius;

  /// The color of the circle. Defaults to black.
  final Expression<Color> color;

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// centerpoint is full opacity.
  final Expression<num> blur;

  /// The opacity at which the circle will be drawn, on top of the alpha of
  /// [color]. Defaults to 1.
  final Expression<num> opacity;

  /// The outline width
  final Expression<num> strokeWidth;

  /// The outline color
  final Expression<Color> strokeColor;

  /// The opacity of the circle's stroke, on top of the alpha of [strokeColor].
  /// Defaults to 1.
  final Expression<num> strokeOpacity;

  @override
  StyleLayer createStyleLayer(int index) => CircleStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    minZoom: minZoom,
    maxZoom: maxZoom,
    radius: radius,
    color: color,
    blur: blur,
    opacity: opacity,
    strokeWidth: strokeWidth,
    strokeColor: strokeColor,
    strokeOpacity: strokeOpacity,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CircleLayer &&
          runtimeType == other.runtimeType &&
          radius == other.radius &&
          color == other.color &&
          blur == other.blur &&
          opacity == other.opacity &&
          strokeWidth == other.strokeWidth &&
          strokeColor == other.strokeColor &&
          strokeOpacity == other.strokeOpacity;

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    radius,
    color,
    blur,
    opacity,
    strokeWidth,
    strokeColor,
    strokeOpacity,
  );
}
