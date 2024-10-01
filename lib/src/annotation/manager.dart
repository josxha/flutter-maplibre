import 'dart:convert';

import 'package:maplibre/maplibre.dart';

/// The [AnnotationManager] contains the logic for map annotations.
class AnnotationManager {
  /// Create a new [AnnotationManager].
  AnnotationManager(this._mapCtrl, List<AnnotationLayer<Annotation>> layers) {
    final collection = GeometryCollection(
      geometries: (layers.first as MarkerAnnotationLayer)
          .list
          .map((e) => Point(coordinates: e.point))
          .toList(),
    );
    final source = GeoJsonSource(
      id: sourceId,
      data: jsonEncode(collection.toJson()),
    );
    _mapCtrl.addSource(source);
    _mapCtrl.addLayer(
      const CircleLayer(id: '$sourceId-circles', sourceId: sourceId),
    );
  }

  /// Update the [Annotation]s.
  void update(List<AnnotationLayer<Annotation>> layers) {
    final collection = GeometryCollection(
      geometries: (layers.first as MarkerAnnotationLayer)
          .list
          .map((e) => Point(coordinates: e.point))
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