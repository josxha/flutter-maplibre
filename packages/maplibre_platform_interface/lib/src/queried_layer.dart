import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Data class representing a vector feature that was rendered on the map.
///
/// {@category Basic}
@immutable
class RenderedFeature {
  /// Create a new [RenderedFeature].
  const RenderedFeature({required this.id, required this.properties});

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
  /// **DANGER**:
  /// On Android, the `id` field is always converted to a string.
  ///
  /// If using GeoJSON sources, consider relying on `[properties]` rather
  /// than `[id]`.
  final Object? id;

  /// The properties of the feature as provided by its source.
  final Map<String, Object?> properties;

  @override
  String toString() => 'RenderedFeature(id: $id, properties: $properties)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RenderedFeature && id == other.id;

  @override
  int get hashCode => Object.hash(id, properties);
}

/// Return used for [MapController.queryLayers].
///
/// {@category Basic}
@immutable
class QueriedLayer {
  /// Create a new [QueriedLayer] object.
  const QueriedLayer({
    required this.layerId,
    required this.sourceId,
    required this.sourceLayer,
  });

  /// The ID of the layer the feature was rendered in.
  final String layerId;

  /// The ID of the vector source that provided the feature.
  final String? sourceId;

  /// The ID of the vector source layer that provided the feature.
  final String? sourceLayer;

  @override
  String toString() =>
      'QueriedLayer(layerId: $layerId, '
      'sourceId: $sourceId, sourceLayer: $sourceLayer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueriedLayer &&
          runtimeType == other.runtimeType &&
          layerId == other.layerId &&
          sourceId == other.sourceId &&
          sourceLayer == other.sourceLayer;

  @override
  int get hashCode => Object.hash(layerId, sourceId, sourceLayer);
}
