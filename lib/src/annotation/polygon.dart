part of 'annotations.dart';

/// A [Polygon] layer.
class PolygonAnnotationLayer extends AnnotationLayer<Polygon> {
  /// Create a new [PolygonAnnotationLayer] instance.
  PolygonAnnotationLayer({
    required List<Polygon> polygons,
    this.color = const Color(0x00000000),
    this.outlineColor = const Color(0x00000000),
  }) : super._(
          list: polygons,
          sourceId: 'maplibre-polygon-source-${_counter++}',
          layerId: 'maplibre-polygon-layer-${_counter++}',
        );

  /// The color of the polygon. Defaults to black.
  final Color color;

  /// The opacity at which the polygon will be drawn.
  double get opacity => color.opacity;

  /// The outline color
  final Color outlineColor;

  @override
  Map<String, Object> getPaint() => {
    'fill-color': color.toHexStringNoOpacity(),
    'fill-opacity': color.opacity,
    'fill-outline-color': outlineColor.toHexStringNoOpacity(),
  };

  @override
  Layer createLayer() => FillLayer(
        id: layerId,
        sourceId: sourceId,
        paint: getPaint(),
      );
}
