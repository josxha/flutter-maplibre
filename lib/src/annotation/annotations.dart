import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/annotation/extensions.dart';

part 'circle.dart';
part 'marker.dart';
part 'polygon.dart';
part 'polyline.dart';

/// This counter guarantees unique source and layer IDs.
int _counter = 0;

/// This class is the base for all annotation layer classes like
/// [MarkerAnnotationLayer].
sealed class AnnotationLayer<G extends GeometryType<Object>> {
  AnnotationLayer._({
    required this.list,
    required this.sourceId,
    required this.layerId,
  });

  /// The [List] of annotations.
  final List<G> list;

  /// Get a unique source id.
  final String sourceId;

  /// Get a unique layer id.
  final String layerId;

  MapController? _mapController;

  /// Returns true if the [MapController] has been registered.
  bool get isRegistered => _mapController != null;

  /// Internal used, register a map controller and add the [AnnotationLayer]
  /// to the map.
  void registerController(MapController controller) {
    _mapController = controller;

    final source = GeoJsonSource(
      id: sourceId,
      data: jsonEncode(GeometryCollection(geometries: list).toJson()),
    );
    _mapController?.addSource(source);

    addToMap();
  }

  /// Build the paint properties.
  Map<String, Object> getPaint();

  /// Add the annotation layer to the map.
  void addToMap() {
    final layer = CircleLayer(
      id: layerId,
      sourceId: sourceId,
      paint: getPaint(),
    );
    _mapController?.addLayer(layer);
  }

  /// Update the annotations.
  void updateOnMap() {
    _mapController?.updateGeoJsonSource(
      id: sourceId,
      data: jsonEncode(GeometryCollection(geometries: list).toJson()),
    );
  }
}
