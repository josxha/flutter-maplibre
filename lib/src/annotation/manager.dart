import 'dart:convert';

import 'package:maplibre/maplibre.dart';

/// The [AnnotationManager] contains the logic for map annotations.
class AnnotationManager {
  /// Create a new [AnnotationManager].
  AnnotationManager(
    this._mapCtrl,
    List<AnnotationLayer<GeometryType<Object>>> layers,
  ) {
    for (final layer in layers) {
      final collection = GeometryCollection(
        geometries: (layer as CircleAnnotationLayer).list,
      );
      final source = GeoJsonSource(
        id: sourceId,
        data: jsonEncode(collection.toJson()),
      );
      _mapCtrl.addSource(source);
      _mapCtrl.addLayer(
        const CircleLayer(
          id: '$sourceId-circles',
          sourceId: sourceId,
          paint: {},
        ),
      );
    }
  }

  /// Update the [Annotation]s.
  void update(List<AnnotationLayer<GeometryType<Object>>> layers) {
    final collection = GeometryCollection(
      geometries: (layers.first as CircleAnnotationLayer)
          .list
          .map((e) => Point(coordinates: e.coordinates))
          .toList(),
    );
    _mapCtrl.updateGeoJsonSource(
      id: sourceId,
      data: jsonEncode(collection.toJson()),
    );
  }

  /// The layer ID, needs to be unique.
  static const sourceId = '803tqugh0f283hrf';
  final MapController _mapCtrl;
}
