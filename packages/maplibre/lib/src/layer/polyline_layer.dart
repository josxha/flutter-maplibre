import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A [LineString] layer.
///
/// {@category Layers}
@immutable
class PolylineLayer extends Layer<Feature<LineString>> {
  /// Create a new [PolylineLayer] instance.
  const PolylineLayer({
    required List<Feature<LineString>> polylines,
    this.color = const .literal(Color(0xFF000000)),
    this.opacity = const .literal(1),
    this.width = const .literal(1),
    this.gapWidth = const .literal(0),
    this.blur = const .literal(0),
    this.dashArray,
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super(list: polylines);

  /// The color of the polyline. Defaults to black
  final Expression<Color> color;

  /// The opacity at which the polyline will be drawn, on top of the alpha of
  /// [color]. Defaults to 1.
  final Expression<num> opacity;

  /// Stroke thickness.
  final Expression<num> width;

  /// The gap between the two lines that a width above 0 draws.
  final Expression<num> gapWidth;

  /// Blur applied to the line, in pixels. Defaults to 0.
  final Expression<num> blur;

  /// Specifies the lengths of the alternating dashes and gaps that form the
  /// dash pattern. The lengths are later scaled by the line width.
  final Expression<List<num>>? dashArray;

  @override
  StyleLayer createStyleLayer(int index) => LineStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    minZoom: minZoom,
    maxZoom: maxZoom,
    color: color,
    opacity: opacity,
    width: width,
    gapWidth: gapWidth,
    blur: blur,
    dasharray: dashArray,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PolylineLayer &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          opacity == other.opacity &&
          width == other.width &&
          gapWidth == other.gapWidth &&
          blur == other.blur &&
          dashArray == other.dashArray;

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    color,
    opacity,
    width,
    gapWidth,
    blur,
    dashArray,
  );
}
