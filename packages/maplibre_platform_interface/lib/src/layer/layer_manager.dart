import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
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

  /// The feature that the user drags, see [startDrag].
  _FeatureDrag? _drag;

  static const _dragSourceId = 'maplibre-drag-source';
  static const _dragLayerId = 'maplibre-drag-layer';

  /// How long a dropped feature stays in the overlay after its layer's
  /// source has it at its new place, while the map tiles that source again.
  /// Without it, the feature would show at its old place for a moment.
  static const _retileDelay = Duration(milliseconds: 250);

  static bool _sameFeatures(List<Feature> a, List<Feature> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!identical(a[i], b[i]) && a[i] != b[i]) return false;
    }
    return true;
  }

  /// The property that holds the index of each feature in [Layer.list] while
  /// the layer is [Layer.interactive], to tell which feature the user tapped,
  /// hovered or dragged.
  static const featureIndexProperty = 'maplibre:index';

  static GeoJsonSource _sourceOf(Layer layer, int index) =>
      GeoJsonSource.data(id: layer.getSourceId(index), data: _dataOf(layer));

  static GeoJsonData _dataOf(Layer layer) {
    if (!layer.interactive) {
      return .featureCollection(FeatureCollection(List.of(layer.list)));
    }
    return .featureCollection(
      FeatureCollection([
        for (final (index, feature) in layer.list.indexed)
          Feature(
            id: feature.id,
            geometry: feature.geometry,
            properties: {...feature.properties, featureIndexProperty: index},
          ),
      ]),
    );
  }

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
      if (_drag case final drag?) {
        final index = drag.layerIndex;
        if (index >= layers.length ||
            !layers[index].draggable ||
            drag.featureIndex >= layers[index].list.length ||
            layers[index].runtimeType != _oldLayers[index].runtimeType) {
          _finishDrag();
        }
      }
      for (var index = 0; index < layers.length; index++) {
        final layer = layers[index];
        final oldLayer = index < _oldLayers.length ? _oldLayers[index] : null;
        if (oldLayer == null) {
          unawaited(style.sources.add(_sourceOf(layer, index)));
          _styleLayers.add(_addStyleLayer(layer, index));
          continue;
        }
        // Only re-serialise a source whose features actually changed. Building
        // the GeoJSON is the expensive half of this call.
        //
        // `Layer.==` compares `list` by identity and misses features added to
        // the same list in place, so the features are compared with the copy
        // taken last time.
        if (layer.interactive != oldLayer.interactive ||
            !_sameFeatures(_oldFeatures[index], layer.list)) {
          final written = style.sources.updateGeoJsonData(
            layer.getSourceId(index),
            _dataOf(layer),
          );
          final drag = _drag;
          if (drag != null &&
              drag.layerIndex == index &&
              drag.ending &&
              !drag.committed) {
            // The app saved the dropped feature: show the layer's feature
            // again once the source has it.
            drag.committed = true;
            unawaited(
              written.whenComplete(() async {
                await Future<void>.delayed(_retileDelay);
                if (identical(_drag, drag)) style.batch(_finishDrag);
              }),
            );
          } else {
            unawaited(written);
          }
        }
        if (layer != oldLayer) {
          _updateStyleLayer(layer, index);
          if (_drag case final drag? when drag.layerIndex == index) {
            drag.overlay.updateFrom(_overlayOf(layer, index));
            _hideDragged(layer, drag);
          }
        }
      }
      // remove any left-over sources and layers from the map
      if (_drag case final drag? when drag.layerIndex >= layers.length) {
        _finishDrag();
      }
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

  /// Lets the user drag the feature [featureIndex] of the layer [layerIndex].
  ///
  /// The feature moves to a one-feature overlay above its layer, and its
  /// layer hides it, so that [moveDrag] moves it without writing the
  /// layer's whole source.
  void startDrag(int layerIndex, int featureIndex) {
    style.batch(() {
      _finishDrag();
      if (layerIndex >= _oldLayers.length) return;
      final layer = _oldLayers[layerIndex];
      final features = _oldFeatures[layerIndex];
      if (!layer.draggable || featureIndex >= features.length) return;
      final feature = features[featureIndex];
      final geometry = feature.geometry;
      if (geometry == null) return;
      final drag = _drag = _FeatureDrag(
        layerIndex,
        featureIndex,
        feature,
        _overlayOf(layer, layerIndex),
      );
      unawaited(
        style.sources.add(
          GeoJsonSource.data(
            id: _dragSourceId,
            data: _overlayData(drag, geometry),
          ),
        ),
      );
      final above = layerIndex + 1;
      unawaited(
        style.layers.add(
          drag.overlay,
          belowLayerId: above < _styleLayers.length
              ? _styleLayers[above].id
              : null,
        ),
      );
      _hideDragged(layer, drag);
    });
  }

  /// Shows the dragged feature with [geometry]. Only the latest geometry is
  /// sent while the map still takes the one before.
  void moveDrag(Geometry geometry) {
    final drag = _drag;
    if (drag == null || drag.ending) return;
    drag.next = geometry;
    if (!drag.sending) unawaited(_sendDrag(drag));
  }

  Future<void> _sendDrag(_FeatureDrag drag) async {
    drag.sending = true;
    try {
      while (identical(_drag, drag)) {
        final geometry = drag.next;
        if (geometry == null) break;
        drag.next = null;
        await style.sources.updateGeoJsonData(
          _dragSourceId,
          _overlayData(drag, geometry),
        );
      }
    } on Object catch (error, stack) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'maplibre',
          context: ErrorDescription('while moving a dragged feature'),
        ),
      );
    } finally {
      drag.sending = false;
    }
  }

  /// Ends the drag. The feature stays in the overlay until the app saves it
  /// at its new place in the layer, or goes back after the next frame if
  /// the app doesn't.
  void endDrag() {
    final drag = _drag;
    if (drag == null || drag.ending) return;
    drag.ending = true;
    SchedulerBinding.instance
      ..addPostFrameCallback((_) {
        if (identical(_drag, drag) && !drag.committed) {
          style.batch(_finishDrag);
        }
      })
      ..scheduleFrame();
  }

  /// Removes the overlay of the drag and shows the feature in its layer
  /// again. Call it in a [StyleController.batch].
  void _finishDrag() {
    final drag = _drag;
    if (drag == null) return;
    _drag = null;
    unawaited(style.layers.remove(_dragLayerId));
    unawaited(style.sources.remove(_dragSourceId));
    final index = drag.layerIndex;
    if (index < _styleLayers.length && index < _oldLayers.length) {
      _styleLayers[index].filter = _oldLayers[index]
          .createStyleLayer(index)
          .filter;
    }
  }

  /// Hides the dragged feature in its layer.
  void _hideDragged(Layer layer, _FeatureDrag drag) {
    final own = layer.createStyleLayer(drag.layerIndex).filter;
    final hide = Expression.notEqual(
      Expression.get(featureIndexProperty),
      Expression.literal(drag.featureIndex),
    );
    _styleLayers[drag.layerIndex].filter = own == null
        ? hide
        : Expression.all([own, hide]);
  }

  static StyleLayer _overlayOf(Layer layer, int index) => StyleLayer.fromJson({
    ...layer.createStyleLayer(index).toJson(),
    'id': _dragLayerId,
    'source': _dragSourceId,
  });

  static GeoJsonData _overlayData(_FeatureDrag drag, Geometry geometry) =>
      .featureCollection(
        FeatureCollection([
          Feature(
            id: drag.feature.id,
            geometry: geometry,
            properties: {
              ...drag.feature.properties,
              featureIndexProperty: drag.featureIndex,
            },
          ),
        ]),
      );

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

/// A feature that the user drags, shown in an overlay.
class _FeatureDrag {
  _FeatureDrag(this.layerIndex, this.featureIndex, this.feature, this.overlay);

  final int layerIndex;
  final int featureIndex;
  final Feature feature;

  /// The style layer that shows the feature while it is dragged.
  final StyleLayer overlay;

  /// The geometry to show next, while the map still takes the one before.
  Geometry? next;
  bool sending = false;

  /// Whether the user dropped the feature, and whether the app then saved
  /// it in the layer.
  bool ending = false;
  bool committed = false;
}
