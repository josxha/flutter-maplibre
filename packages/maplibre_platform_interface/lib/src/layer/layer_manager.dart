import 'dart:async';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The layer manager handles the high-level layer API used in
/// [MapLibreMap.layers]. This is an internal class that doesn't get exposed
/// publicly.
class LayerManager {
  /// Create a new [LayerManager]. Needs the [MapController] of the
  /// [MapLibreMap] and the initial list of [Layer]s.
  ///
  /// It creates all sources and layers on the map. It's not needed to compare
  /// the layers with [_oldLayers] in for the initial creation.
  LayerManager(this.style, List<Layer> layers) {
    for (final (index, layer) in layers.indexed) {
      unawaited(style.addSource(layer.createSource(index)));
      for (final styleLayer in layer.createStyleLayers(index)) {
        unawaited(style.addLayer(styleLayer));
      }
    }
    _oldLayers = layers;
  }

  /// The [StyleController] of the [MapLibreMap].
  final StyleController style;

  /// The saved [Layer]s from before `setState()` gets called and the
  /// layers get changed.
  late List<Layer> _oldLayers;

  /// Called when `setState()` gets called and the widget rebuilds. This method
  /// translates the declarative layer definition of [MapLibreMap.layers] to
  /// imperative calls to the maps' [MapController].
  void updateLayers(List<Layer> layers) {
    for (var index = 0; index < layers.length; index++) {
      final layer = layers[index];
      final oldLayer = index > _oldLayers.length - 1 ? null : _oldLayers[index];
      final source = layer.createSource(index);
      // update source
      // TODO check if the entities of both lists are equal
      if (oldLayer case final Layer oldLayer
          when oldLayer.createSource(index) == source) {
        // The source definition (e.g. cluster options) is unchanged, only
        // update the data in place.
        style.updateGeoJsonSource(id: source.id, data: source.data);
      } else {
        if (oldLayer != null) {
          // The source definition changed, recreate it together with its
          // layers further down.
          for (final styleLayer in oldLayer.createStyleLayers(index)) {
            style.removeLayer(styleLayer.id);
          }
          style.removeSource(oldLayer.getSourceId(index));
        }
        style.addSource(source);
      }
      // update layer
      if (layer != oldLayer) {
        if (oldLayer case final Layer oldLayer
            when oldLayer.createSource(index) == source) {
          for (final styleLayer in oldLayer.createStyleLayers(index)) {
            style.removeLayer(styleLayer.id);
          }
        }
        layer.createStyleLayers(index).forEach(style.addLayer);
      }
    }
    // remove any left-over sources and layers from the map
    for (var i = 0; i < (_oldLayers.length - layers.length); i++) {
      final index = layers.length + i;
      final oldLayer = _oldLayers[index];
      oldLayer
          .createStyleLayers(index)
          .map((styleLayer) => styleLayer.id)
          .forEach(style.removeLayer);
      style.removeSource(oldLayer.getSourceId(index));
    }
    _oldLayers = layers;
  }
}
