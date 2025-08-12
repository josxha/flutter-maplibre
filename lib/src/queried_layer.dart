import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';

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
