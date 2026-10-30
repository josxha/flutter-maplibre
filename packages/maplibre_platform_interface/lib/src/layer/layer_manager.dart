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
    style.batch(() {
      for (final (index, layer) in layers.indexed) {
        unawaited(style.sources.add(_sourceOf(layer, index)));
        _styleLayers.add(_addStyleLayer(layer, index));
      }
    });
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

  /// The style layers on the map, one per entry of [_oldLayers].
  final _styleLayers = <StyleLayer>[];

  static bool _sameFeatures(List<Feature> a, List<Feature> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!identical(a[i], b[i]) && a[i] != b[i]) return false;
    }
    return true;
  }

  static GeoJsonSource _sourceOf(Layer layer, int index) => GeoJsonSource.data(
    id: layer.getSourceId(index),
    data: FeatureCollection(layer.list).toText(),
  );

  StyleLayer _addStyleLayer(Layer layer, int index, {String? belowLayerId}) {
    final styleLayer = layer.createStyleLayer(index);
    unawaited(style.layers.add(styleLayer, belowLayerId: belowLayerId));
    return styleLayer;
  }

  /// Called when `setState()` gets called and the widget rebuilds. This method
  /// translates the declarative layer definition of [MapLibreMap.layers] to
  /// imperative calls to the maps' [MapController].
  void updateLayers(List<Layer> layers) {
    style.batch(() {
      for (var index = 0; index < layers.length; index++) {
        final layer = layers[index];
        final oldLayer = index < _oldLayers.length ? _oldLayers[index] : null;
        if (oldLayer == null) {
          unawaited(style.sources.add(_sourceOf(layer, index)));
          _styleLayers.add(_addStyleLayer(layer, index));
          continue;
        }
        // Only re-serialise a source whose features actually changed. Building
        // the FeatureCollection text is the expensive half of this call.
        //
        // `Layer.==` compares `list` by identity and misses features added to
        // the same list in place, so the features are compared with the copy
        // taken last time.
        if (!_sameFeatures(_oldFeatures[index], layer.list)) {
          unawaited(
            style.sources.updateGeoJsonData(
              layer.getSourceId(index),
              FeatureCollection(layer.list).toText(),
            ),
          );
        }
        if (layer != oldLayer) _updateStyleLayer(layer, index);
      }
      // remove any left-over sources and layers from the map
      for (var index = _oldLayers.length - 1; index >= layers.length; index--) {
        final oldLayer = _oldLayers[index];
        unawaited(style.layers.remove(oldLayer.getLayerId(index)));
        unawaited(style.sources.remove(oldLayer.getSourceId(index)));
        _styleLayers.removeAt(index);
      }
    });
    _oldLayers = layers;
    _oldFeatures = [for (final layer in layers) List.of(layer.list)];
  }

  /// Brings the style layer at [index] to the definition of [layer]: only its
  /// changed properties, or a new style layer at the same position if its type
  /// or source changed.
  void _updateStyleLayer(Layer layer, int index) {
    final current = _styleLayers[index];
    final next = layer.createStyleLayer(index);
    if (current.type == next.type &&
        _sourceOfLayer(current) == _sourceOfLayer(next)) {
      current.updateFrom(next);
      return;
    }
    unawaited(style.layers.remove(current.id));
    _styleLayers[index] = next;
    final nextIndex = index + 1;
    unawaited(
      style.layers.add(
        next,
        belowLayerId: nextIndex < _styleLayers.length
            ? _styleLayers[nextIndex].id
            : null,
      ),
    );
  }

  static (String?, String?) _sourceOfLayer(StyleLayer layer) =>
      layer is StyleLayerWithSource
      ? (layer.sourceId, layer.sourceLayerId)
      : (null, null);
}
