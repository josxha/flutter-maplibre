import 'dart:convert';

import 'package:maplibre/maplibre.dart';

/// The annotation manager handles the high-level annotation API used in
/// [MapLibreMap.layers]. This is an internal class that doesn't get exposed
/// publicly.
class AnnotationManager {
  /// Create a new [AnnotationManager]. Needs the [MapController] of the
  /// [MapLibreMap] and the initial list of [AnnotationLayer]s.
  ///
  /// It creates all sources and layers on the map. It's not needed to compare
  /// the layers with [_oldLayers] in for the initial creation.
  AnnotationManager(this.mapController, List<AnnotationLayer> layers) {
    for (final (index, layer) in layers.indexed) {
      final source = GeoJsonSource(
        id: layer.getSourceId(index),
        data: jsonEncode(GeometryCollection(geometries: layer.list).toJson()),
      );
      mapController.addSource(source);
      mapController.addLayer(layer.createLayer(index));
    }
    _oldLayers = layers;
  }

  /// The [MapController] of the [MapLibreMap].
  final MapController mapController;

  /// The saved [AnnotationLayer]s from before `setState()` gets called and the
  /// layers get changed.
  late List<AnnotationLayer> _oldLayers;

  /// Called when `setState()` gets called and the widget rebuilds. This method
  /// translates the declarative layer definition of [MapLibreMap.layers] to
  /// imperative calls to the maps' [MapController].
  void updateLayers(List<AnnotationLayer> layers) {
    for (var index = 0; index < layers.length; index++) {
      final layer = layers[index];
      final oldLayer = index > _oldLayers.length - 1 ? null : _oldLayers[index];
      // update source
      // TODO check if the entities of both lists are equal
      if (oldLayer case AnnotationLayer()) {
        mapController.updateGeoJsonSource(
          id: layer.getSourceId(index),
          data:
          jsonEncode(GeometryCollection(geometries: layer.list).toJson()),
        );
      } else {
        final source = GeoJsonSource(
          id: layer.getSourceId(index),
          data:
          jsonEncode(GeometryCollection(geometries: layer.list).toJson()),
        );
        mapController.addSource(source);
      }
      // update layer
      if (layer != oldLayer) {
        if (oldLayer case AnnotationLayer()) {
          mapController.removeLayer(oldLayer.getLayerId(index));
        }
        mapController.addLayer(layer.createLayer(index));
      }
    }
    // remove any left-over sources and layers from the map
    for (var index = 0; index < (_oldLayers.length - layers.length); index++) {
      final oldLayer = _oldLayers[index];
      mapController.removeSource(oldLayer.getSourceId(index));
      mapController.removeLayer(oldLayer.getLayerId(index));
    }
    _oldLayers = layers;
  }
}
