part of 'annotations.dart';

/// A [LineString] layer.
class PolylineAnnotationLayer extends AnnotationLayer<LineString> {
  /// Create a new [PolylineAnnotationLayer] instance.
  PolylineAnnotationLayer({
    required List<LineString> polylines,
  }) : super._(
    list: polylines,
    sourceId: 'maplibre-polyline-source-${_counter++}',
    layerId: 'maplibre-polyline-layer-${_counter++}',
  );

  @override
  Map<String, Object> getPaint() => {};

  @override
  Layer createLayer() => LineLayer(
    id: layerId,
    sourceId: sourceId,
    paint: getPaint(),
  );
}
