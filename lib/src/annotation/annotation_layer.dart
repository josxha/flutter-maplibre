import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/annotation/extensions.dart';

part 'circle_annotation_layer.dart';
part 'marker_annotation_layer.dart';
part 'polygon_annotation_layer.dart';
part 'polyline_annotation_layer.dart';

/// This counter guarantees unique source and layer IDs.
int _counter = 0;

/// This class is the base for all annotation layer classes like
/// [MarkerAnnotationLayer].
@immutable
sealed class AnnotationLayer<G extends GeometryType<Object>> {
  const AnnotationLayer._({
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

  /// Internal used, register a map controller and add the [AnnotationLayer]
  /// to the map.
  void addToMap(MapController controller, int index) {
    final source = GeoJsonSource(
      id: sourceId,
      data: jsonEncode(GeometryCollection(geometries: list).toJson()),
    );
    controller.addSource(source);
    controller.addLayer(createLayer());
  }

  /// Build the paint properties.
  Map<String, Object> getPaint();

  /// Build the layout properties.
  Map<String, Object> getLayout();

  /// Add the annotation layer to the map.
  Layer createLayer();

  /// Update the annotations.
  void updateOnMap(MapController controller, int index) {
    controller.updateGeoJsonSource(
      id: sourceId,
      data: jsonEncode(GeometryCollection(geometries: list).toJson()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotationLayer &&
          runtimeType == other.runtimeType &&
          list == other.list &&
          sourceId == other.sourceId &&
          layerId == other.layerId;

  @override
  int get hashCode => list.hashCode ^ sourceId.hashCode ^ layerId.hashCode;
}
