import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

/// Return used for [MapController.queryRenderedFeatures].
@immutable
class RenderedFeature {
  /// Create a new [RenderedFeature] object.
  const RenderedFeature({
    required this.layerId,
    required this.sourceId,
    required this.sourceLayer,
  });

  /// The layer id.
  final String? layerId;

  /// The source id.
  final String? sourceId;

  /// The source layer id.
  final String? sourceLayer;

  @override
  String toString() => 'RenderedFeature(layerId: $layerId, '
      'sourceId: $sourceId, sourceLayer: $sourceLayer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RenderedFeature &&
          runtimeType == other.runtimeType &&
          layerId == other.layerId &&
          sourceId == other.sourceId &&
          sourceLayer == other.sourceLayer;

  @override
  int get hashCode =>
      layerId.hashCode ^
      sourceId.hashCode ^
      sourceLayer.hashCode;
}
