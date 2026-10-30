import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A [Polygon] layer.
///
/// {@category Layers}
@immutable
class PolygonLayer extends Layer<Feature<Polygon>> {
  /// Create a new [PolygonLayer] instance.
  const PolygonLayer({
    required List<Feature<Polygon>> polygons,
    this.color = const .literal(Color(0xFF000000)),
    this.opacity = const .literal(1),
    this.outlineColor = const .literal(Color(0xFF000000)),
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super(list: polygons);

  /// The color of the polygon. Defaults to black.
  final Expression<Color> color;

  /// The opacity at which the polygon will be drawn, on top of the alpha of
  /// [color]. Defaults to 1.
  final Expression<num> opacity;

  /// The outline color
  final Expression<Color> outlineColor;

  @override
  StyleLayer createStyleLayer(int index) => FillStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    minZoom: minZoom,
    maxZoom: maxZoom,
    color: color,
    opacity: opacity,
    outlineColor: outlineColor,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PolygonLayer &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          opacity == other.opacity &&
          outlineColor == other.outlineColor;

  @override
  int get hashCode => Object.hash(super.hashCode, color, opacity, outlineColor);
}
