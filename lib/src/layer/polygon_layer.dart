part of 'layer.dart';

/// A [Polygon] layer.
///
/// {@category Layers}
@immutable
class PolygonLayer extends Layer<Polygon> {
  /// Create a new [PolygonLayer] instance.
  const PolygonLayer({
    required List<Polygon> polygons,
    this.color = const Color(0xFF000000),
    this.outlineColor = const Color(0xFF000000),
  }) : super._(list: polygons);

  /// The color of the polygon. Defaults to black.
  final Color color;

  /// The opacity at which the polygon will be drawn.
  double get opacity => color.opacity;

  /// The outline color
  final Color outlineColor;

  @override
  Map<String, Object> getPaint() => {
        'fill-color': color.toHexStringNoOpacity(),
        'fill-opacity': opacity,
        'fill-outline-color': outlineColor.toHexStringNoOpacity(),
      };

  @override
  Map<String, Object> getLayout() => {};

  @override
  StyleLayer createStyleLayer(int index) => FillStyleLayer(
        id: getLayerId(index),
        sourceId: getSourceId(index),
        paint: getPaint(),
        layout: getLayout(),
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
