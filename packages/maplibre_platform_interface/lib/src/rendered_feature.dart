import 'package:flutter/foundation.dart';

/// Data class representing a vector feature that was rendered on the map.
///
/// {@category Basic}
@immutable
class RenderedFeature {
  /// Create a new [RenderedFeature].
  const RenderedFeature({
    required this.id,
    required this.properties,
    this.geometry,
    this.sourceId,
    this.sourceLayer,
    this.layerId,
  });

  /// If present, an object uniquely identifying the feature in the vector
  /// source. May be either a string or an integer.
  ///
  /// If the source is GeoJSON, this property corresponds to the feature's `id`
  /// field.
  ///
  /// **DANGER**:
  /// This field is unpredictable on MapLibre web when the underlying GeoJSON
  /// feature has an `id` field that is not a positive integer.
  /// See https://github.com/maplibre/maplibre-gl-js/issues/1043.
  ///
  /// If using GeoJSON sources, consider relying on `[properties]` rather
  /// than `[id]`.
  final Object? id;

  /// The properties of the feature as provided by its source.
  final Map<String, Object?> properties;

  /// The GeoJSON geometry of the feature as provided by its source.
  ///
  /// The map usually contains `type` and `coordinates` keys.
  ///
  /// This field may be null if the platform does not expose geometry in query
  /// results.
  final Map<String, Object?>? geometry;

  /// The ID of the source that provided the feature.
  final String? sourceId;

  /// The source layer that provided the feature, for vector tile sources.
  final String? sourceLayer;

  /// The ID of the style layer that rendered the feature.
  final String? layerId;

  @override
  String toString() =>
      'RenderedFeature(id: $id, properties: $properties, geometry: $geometry, '
      'sourceId: $sourceId, sourceLayer: $sourceLayer, layerId: $layerId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RenderedFeature &&
          id == other.id &&
          sourceId == other.sourceId &&
          sourceLayer == other.sourceLayer &&
          layerId == other.layerId;

  @override
  int get hashCode => Object.hash(id, sourceId, sourceLayer, layerId);
}
