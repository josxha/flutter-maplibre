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
    required this.state,
  });

  /// The layer id.
  final String? layerId;

  /// The source id.
  final String? sourceId;

  /// The source layer id.
  final String? sourceLayer;

  /// The state.
  final String? state;

  @override
  String toString() => 'RenderedFeature(layerId: $layerId, '
      'sourceId: $sourceId, sourceLayer: $sourceLayer, state: $state)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RenderedFeature &&
          runtimeType == other.runtimeType &&
          layerId == other.layerId &&
          sourceId == other.sourceId &&
          sourceLayer == other.sourceLayer &&
          state == other.state;

  @override
  int get hashCode =>
      layerId.hashCode ^
      sourceId.hashCode ^
      sourceLayer.hashCode ^
      state.hashCode;
}
