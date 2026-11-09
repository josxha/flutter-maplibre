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
    _ensureIds(layers);
    style.batch(() {
      // Add top to bottom, anchoring each layer below the next declarative
      // layer.
      for (final (index, layer) in layers.indexed.toList().reversed) {
        unawaited(style.sources.add(_sourceOf(layer, index)));
        final belowLayerId = index + 1 < layers.length
            ? _layerId(layers[index + 1], index + 1)
            : null;
        _styleLayers.add(
          _addStyleLayer(layer, index, belowLayerId: belowLayerId),
        );
      }
      _styleLayers.setAll(0, _styleLayers.reversed);
    });
    _oldLayers = List.of(layers);
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

  /// Generated ids belong to layer slots, but aren't derived from their index.
  /// Keeping the counters avoids reusing an id when a slot is removed and later
  /// filled again.
  final _generatedLayerIds = <String>[];
  final _generatedSourceIds = <String>[];
  var _nextLayerId = 0;
  var _nextSourceId = 0;

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

  /// The style-layer id used for [index] in the current declarative list.
  /// Explicit ids follow their layer; generated ids stay with the slot.
  String getLayerId(int index) => _layerId(_oldLayers[index], index);

  String _layerId(Layer layer, int index) =>
      layer.id ?? _generatedLayerIds[index];

  String _sourceId(int index) => _generatedSourceIds[index];

  void _ensureIds(List<Layer> layers) {
    final customIds = <String>{};
    for (final layer in layers) {
      final id = layer.id;
      if (id != null && !customIds.add(id)) {
        throw ArgumentError.value(id, 'layers', 'Layer ids must be unique.');
      }
    }
    while (_generatedLayerIds.length < layers.length) {
      _generatedLayerIds.add('maplibre-layer-${_nextLayerId++}');
    }
    while (_generatedSourceIds.length < layers.length) {
      _generatedSourceIds.add('maplibre-source-${_nextSourceId++}');
    }
    for (final (index, layer) in layers.indexed) {
      if (layer.id == null && customIds.contains(_generatedLayerIds[index])) {
        _generatedLayerIds[index] = 'maplibre-layer-${_nextLayerId++}';
      }
    }
    final resolvedIds = <String>{};
    for (final (index, layer) in layers.indexed) {
      if (!resolvedIds.add(_layerId(layer, index))) {
        throw ArgumentError.value(
          layer.id,
          'layers',
          'Layer ids must be unique.',
        );
      }
    }
  }

  GeoJsonSource _sourceOf(Layer layer, int index) =>
      GeoJsonSource.data(id: _sourceId(index), data: _dataOf(layer));

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

  StyleLayer _styleLayerOf(Layer layer, int index) {
    final styleLayer = layer.createStyleLayer(index);
    return StyleLayer.fromJson({
      ...styleLayer.toJson(),
      'id': _layerId(layer, index),
      if (styleLayer is StyleLayerWithSource) 'source': _sourceId(index),
    });
  }

  StyleLayer _addStyleLayer(Layer layer, int index, {String? belowLayerId}) {
    final styleLayer = _styleLayerOf(layer, index);
    unawaited(style.layers.add(styleLayer, belowLayerId: belowLayerId));
    return styleLayer;
  }

  /// Called when `setState()` gets called and the widget rebuilds. This method
  /// translates the declarative layer definition of [MapLibreMap.layers] to
  /// imperative calls to the maps' [MapController].
  void updateLayers(List<Layer> layers) {
    _ensureIds(layers);
    final oldLayers = _oldLayers;
    final oldFeatures = _oldFeatures;
    final oldStyleLayers = List<StyleLayer>.of(_styleLayers);
    final nextStyleLayers = [
      for (final (index, layer) in layers.indexed) _styleLayerOf(layer, index),
    ];
    final replacements = [
      for (final (index, next) in nextStyleLayers)
        index >= oldStyleLayers.length ||
            oldStyleLayers[index].id != next.id ||
            oldStyleLayers[index].type != next.type ||
            _sourceOfLayer(oldStyleLayers[index]) != _sourceOfLayer(next),
    ];

    style.batch(() {
      if (_drag case final drag?) {
        final index = drag.layerIndex;
        if (index >= layers.length ||
            index >= oldLayers.length ||
            !layers[index].draggable ||
            drag.featureIndex >= layers[index].list.length ||
            layers[index].runtimeType != oldLayers[index].runtimeType ||
            _layerId(layers[index], index) != oldStyleLayers[index].id) {
          _finishDrag();
        }
      }

      // Remove every layer that needs replacing before adding any of them.
      // This permits explicitly named layers to swap order without briefly
      // registering the same style-layer id twice.
      for (var index = 0; index < oldStyleLayers.length; index++) {
        if (index >= layers.length || replacements[index]) {
          unawaited(style.layers.remove(oldStyleLayers[index].id));
        }
      }

      // Remove sources that belonged to layers at the end of the old list.
      for (var index = oldLayers.length - 1; index >= layers.length; index--) {
        unawaited(style.sources.remove(_sourceId(index)));
      }

      for (var index = 0; index < layers.length; index++) {
        final layer = layers[index];
        final oldLayer = index < oldLayers.length ? oldLayers[index] : null;
        if (oldLayer == null) {
          unawaited(style.sources.add(_sourceOf(layer, index)));
        } else if (layer.interactive != oldLayer.interactive ||
            !_sameFeatures(oldFeatures[index], layer.list)) {
          final written = style.sources.updateGeoJsonData(
            _sourceId(index),
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
      }

      final nextStyleOrder = <StyleLayer>[];
      for (var index = 0; index < layers.length; index++) {
        if (index < oldStyleLayers.length && !replacements[index]) {
          final current = oldStyleLayers[index];
          current.updateFrom(nextStyleLayers[index]);
          nextStyleOrder.add(current);
        } else {
          nextStyleOrder.add(nextStyleLayers[index]);
        }
      }
      _styleLayers
        ..clear()
        ..addAll(nextStyleOrder);

      // Add new and replaced layers from top to bottom, each below the next
      // entry in MapLibreMap.layers.
      for (var index = layers.length - 1; index >= 0; index--) {
        if (index < oldStyleLayers.length && !replacements[index]) continue;
        final belowLayerId = index + 1 < layers.length
            ? nextStyleOrder[index + 1].id
            : null;
        unawaited(
          style.layers.add(
            nextStyleOrder[index],
            belowLayerId: belowLayerId,
          ),
        );
      }
    });

    _oldLayers = List.of(layers);
    _oldFeatures = [for (final layer in layers) List.of(layer.list)];
    if (_generatedLayerIds.length > layers.length) {
      _generatedLayerIds.removeRange(layers.length, _generatedLayerIds.length);
      _generatedSourceIds.removeRange(
        layers.length,
        _generatedSourceIds.length,
      );
    }
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
      _styleLayers[index].filter = _styleLayerOf(
        _oldLayers[index],
        index,
      ).filter;
    }
  }

  /// Hides the dragged feature in its layer.
  void _hideDragged(Layer layer, _FeatureDrag drag) {
    final own = _styleLayerOf(layer, drag.layerIndex).filter;
    final hide = Expression.notEqual(
      Expression.get(featureIndexProperty),
      Expression.literal(drag.featureIndex),
    );
    _styleLayers[drag.layerIndex].filter = own == null
        ? hide
        : Expression.all([own, hide]);
  }

  StyleLayer _overlayOf(Layer layer, int index) => StyleLayer.fromJson({
    ..._styleLayerOf(layer, index).toJson(),
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
