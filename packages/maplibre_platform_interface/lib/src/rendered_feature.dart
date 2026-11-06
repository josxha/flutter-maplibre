import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geobase/geobase.dart' show GeometryBuilder;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

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

  /// The geometry of the feature, in the precision of the tile that drew it,
  /// or null if it has none.
  final Geometry? geometry;

  /// The ID of the source that provided the feature.
  final String? sourceId;

  /// The source layer that provided the feature, for vector tile sources.
  final String? sourceLayer;

  /// The ID of the style layer that rendered the feature.
  final String? layerId;

  /// Parses the GeoJSON geometry object that the platforms report, or
  /// returns null if [json] is not one.
  static Geometry? geometryFromJson(Object? json) {
    if (json is! Map || json['type'] is! String) return null;
    try {
      return GeometryBuilder.parse(jsonEncode(json));
    } on FormatException {
      return null;
    }
  }

  @override
  String toString() =>
      'RenderedFeature(id: $id, properties: $properties, '
      'geometry: ${geometry?.toText()}, '
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
