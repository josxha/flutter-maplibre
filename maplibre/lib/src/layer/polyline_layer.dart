part of 'layer.dart';

/// A [LineString] layer.
///
/// {@category Layers}
@immutable
class PolylineLayer extends Layer<Feature<LineString>> {
  /// Create a new [PolylineLayer] instance.
  const PolylineLayer({
    required List<Feature<LineString>> polylines,
    this.color = const Color(0xFF000000),
    this.width = 1,
    this.gapWidth = 0,
    this.blur = 0,
    this.dashArray,
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super._(list: polylines);

  /// The color of the polyline. Defaults to black
  final Color color;

  /// The opacity at which the polyline will be drawn.
  double get opacity => color.a;

  /// Stroke thickness.
  final double width;

  /// Stroke thickness.
  final double gapWidth;

  /// Blur applied to the line, in pixels. Defaults to 0.
  final double blur;

  /// Specifies the lengths of the alternating dashes and gaps that form the
  /// dash pattern. The lengths are later scaled by the line width.
  final List<double>? dashArray;

  @override
  StyleLayer createStyleLayer(int index) => LineStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    color: PropertyValue.value(color),
    opacity: PropertyValue.value(opacity),
    width: PropertyValue.value(width),
    gapWidth: PropertyValue.value(gapWidth),
    blur: PropertyValue.value(blur),
    dashArray: dashArray != null ? PropertyValue.value(dashArray!) : null,
    minZoom: minZoom,
    maxZoom: maxZoom,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PolylineLayer &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          width == other.width &&
          gapWidth == other.gapWidth &&
          blur == other.blur &&
          dashArray == other.dashArray;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, color, width, gapWidth, blur, dashArray);
}
