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
      final source = GeoJsonSource(
        id: layer.getSourceId(index),
        data: FeatureCollection(layer.list).toText(),
      );
      unawaited(style.addSource(source));
      unawaited(style.addLayer(layer.createStyleLayer(index)));
    }
    _oldLayers = layers;
    _oldFeatures = [for (final layer in layers) List.of(layer.list)];
  }

  /// The [StyleController] of the [MapLibreMap].
  final StyleController style;

  /// The saved [Layer]s from before `setState()` gets called and the
  /// layers get changed.
  late List<Layer> _oldLayers;

  /// Copies of the features of [_oldLayers] as they were when the sources
  /// were last written. `Layer.==` compares `list` by identity, and an app
  /// that adds to its list in place hands back the same instance, so only a
  /// copy shows what changed.
  late List<List<Feature>> _oldFeatures;

  static bool _sameFeatures(List<Feature> a, List<Feature> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!identical(a[i], b[i]) && a[i] != b[i]) return false;
    }
    return true;
  }

  /// Called when `setState()` gets called and the widget rebuilds. This method
  /// translates the declarative layer definition of [MapLibreMap.layers] to
  /// imperative calls to the maps' [MapController].
  void updateLayers(List<Layer> layers) {
    for (var index = 0; index < layers.length; index++) {
      final layer = layers[index];
      final oldLayer = index > _oldLayers.length - 1 ? null : _oldLayers[index];
      // update source
      if (oldLayer case Layer()) {
        // Only re-serialise a source whose layer actually changed. Building
        // the FeatureCollection text is the expensive half of this call, and
        // it ran on every rebuild for every layer even when nothing about the
        // layer had moved.
        //
        // `Layer.==` alone misses features added to the same list in place,
        // so the features are also compared with the copy taken last time.
        if (layer != oldLayer ||
            !_sameFeatures(_oldFeatures[index], layer.list)) {
          style.updateGeoJsonSource(
            id: layer.getSourceId(index),
            data: FeatureCollection(layer.list).toText(),
          );
        }
      } else {
        final source = GeoJsonSource(
          id: layer.getSourceId(index),
          data: FeatureCollection(layer.list).toText(),
        );
        style.addSource(source);
      }
      // update layer
      if (layer != oldLayer) {
        if (oldLayer case Layer()) {
          style.removeLayer(oldLayer.getLayerId(index));
        }
        style.addLayer(layer.createStyleLayer(index));
      }
    }
    // remove any left-over sources and layers from the map
    for (var i = 0; i < (_oldLayers.length - layers.length); i++) {
      final index = layers.length + i;
      final oldLayer = _oldLayers[index];
      style.removeLayer(oldLayer.getLayerId(index));
      style.removeSource(oldLayer.getSourceId(index));
    }
    _oldLayers = layers;
    _oldFeatures = [for (final layer in layers) List.of(layer.list)];
  }
}
