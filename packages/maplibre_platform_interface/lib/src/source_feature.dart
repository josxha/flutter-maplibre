import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A feature that [MapController.querySourceFeatures] found in a source.
///
/// {@category Basic}
@immutable
class SourceFeature {
  /// Creates a [SourceFeature].
  const SourceFeature({
    required this.id,
    required this.properties,
    this.geometry,
    this.sourceLayer,
  });

  /// The id of the feature in its source, a string or a number, if it has
  /// one.
  final Object? id;

  /// The properties of the feature as provided by its source.
  final Map<String, Object?> properties;

  /// The geometry of the feature, in the precision of the tile that holds it,
  /// or null if it has none.
  final Geometry? geometry;

  /// The source layer that holds the feature, for vector tile sources.
  final String? sourceLayer;

  @override
  String toString() =>
      'SourceFeature(id: $id, properties: $properties, '
      'geometry: ${geometry?.toText()}, sourceLayer: $sourceLayer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceFeature &&
          id == other.id &&
          sourceLayer == other.sourceLayer &&
          mapEquals(properties, other.properties);

  @override
  int get hashCode => Object.hash(id, sourceLayer);
}
