part of 'layer.dart';

/// A [Polygon] layer.
///
/// {@category Layers}
@immutable
class PolygonLayer extends Layer<Feature<Polygon>> {
  /// Create a new [PolygonLayer] instance.
  const PolygonLayer({
    required List<Feature<Polygon>> polygons,
    this.color = const Color(0xFF000000),
    this.outlineColor = const Color(0xFF000000),
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super._(list: polygons);

  /// The color of the polygon. Defaults to black.
  final Color color;

  /// The opacity at which the polygon will be drawn.
  double get opacity => color.a;

  /// The outline color
  final Color outlineColor;

  @override
  StyleLayer createStyleLayer(int index) => FillStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    minZoom: minZoom,
    maxZoom: maxZoom,
    color: PropertyValue.value(color),
    opacity: PropertyValue.value(opacity),
    outlineColor: PropertyValue.value(outlineColor),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PolygonLayer &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          outlineColor == other.outlineColor;

  @override
  int get hashCode => Object.hash(super.hashCode, color, outlineColor);
}
