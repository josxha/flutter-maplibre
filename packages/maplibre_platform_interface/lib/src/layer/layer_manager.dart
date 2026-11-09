import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Manages the declarative layers of [MapLibreMap.layers].
///
/// Each record owns its style and source IDs, so moving a layer does not
/// change its identity or recreate its style layer.
class LayerManager {
  /// Creates the sources and style layers for [layers].
  LayerManager(this.style, List<Layer> layers) {
    _validateIds(layers);
    final reservedIds = {
      for (final layer in layers)
        if (layer.id != null) layer.id!,
    };
    _records.addAll([
      for (final (index, layer) in layers.indexed)
        _createRecord(layer, index, reservedIds),
    ]);

    style.batch(() {
      // Adding bottom to top already gives the style the declarative order.
      for (final record in _records) {
        unawaited(style.sources.add(_sourceOf(record)));
        unawaited(style.layers.add(record.styleLayer));
      }
    });
  }

  /// The style controller of the map.
  final StyleController style;

  /// The managed layers, ordered bottom to top like MapLibreMap.layers.
  final _records = <_ManagedLayer>[];

  /// The next generated style-layer and source IDs.
  var _nextLayerId = 0;
  var _nextSourceId = 0;

  /// The feature currently being dragged, if any.
  _FeatureDrag? _drag;

  static const _dragSourceId = 'maplibre-drag-source';
  static const _dragLayerId = 'maplibre-drag-layer';

  /// How long a dropped feature stays in its overlay while the source retiles.
  static const _retileDelay = Duration(milliseconds: 250);

  /// The property holding a feature's index while its layer is interactive.
  static const featureIndexProperty = 'maplibre:index';

  /// Returns the style-layer ID assigned to the layer at [index].
  String getLayerId(int index) => _records[index].layerId;

  void _validateIds(List<Layer> layers) {
    final ids = <String>{};
    final managedIds = _records.map((record) => record.layerId).toSet();

    for (final layer in layers) {
      final id = layer.id;
      if (id == null) continue;
      if (id.isEmpty || !ids.add(id)) {
        throw ArgumentError.value(
          id,
          'layers',
          'Layer ids must be unique and non-empty.',
        );
      }
      if (style.layers[id] != null && !managedIds.contains(id)) {
        throw ArgumentError.value(
          id,
          'layers',
          'The id is already used by a style layer.',
        );
      }
    }
  }

  String _newLayerId(Set<String> reservedIds) {
    while (true) {
      final id = 'maplibre-layer-' + _nextLayerId.toString();
      _nextLayerId++;
      if (reservedIds.contains(id) ||
          style.layers[id] != null ||
          _records.any((record) => record.layerId == id)) {
        continue;
      }
      reservedIds.add(id);
      return id;
    }
  }

  String _newSourceId() {
    while (true) {
      final id = 'maplibre-source-' + _nextSourceId.toString();
      _nextSourceId++;
      if (style.sources[id] != null ||
          _records.any((record) => record.sourceId == id)) {
        continue;
      }
      return id;
    }
  }

  _ManagedLayer _createRecord(
    Layer layer,
    int index,
    Set<String> reservedIds,
  ) {
    final record = _ManagedLayer(
      layer: layer,
      layerId: layer.id ?? _newLayerId(reservedIds),
      sourceId: _newSourceId(),
    );
    record.styleLayer = _createStyleLayer(layer, index, record);
    return record;
  }

  /// Matches new declarations to existing records.
  ///
  /// Explicit IDs are the strongest key. Unkeyed layers are matched by object
  /// identity, then value equality, then a unique shared feature-list identity.
  /// A same-slot/type fallback preserves identity when a layer replaces its
  /// feature list. Indistinguishable duplicate layers need explicit IDs.
  List<_ManagedLayer?> _matchRecords(List<Layer> layers) {
    final matches = List<_ManagedLayer?>.filled(layers.length, null);
    final unmatched = List<_ManagedLayer>.of(_records);

    for (final (index, layer) in layers.indexed) {
      if (layer.id == null) continue;
      final match = unmatched.indexWhere(
        (record) => record.layer.id == layer.id,
      );
      if (match != -1) matches[index] = unmatched.removeAt(match);
    }

    void matchUnkeyed(bool Function(_ManagedLayer, Layer) matchesLayer) {
      for (final (index, layer) in layers.indexed) {
        if (layer.id != null || matches[index] != null) continue;
        final match = unmatched.indexWhere(
          (record) =>
              record.layer.id == null && matchesLayer(record, layer),
        );
        if (match != -1) matches[index] = unmatched.removeAt(match);
      }
    }

    matchUnkeyed((record, layer) => identical(record.layer, layer));
    matchUnkeyed((record, layer) => record.layer == layer);

    for (final (index, layer) in layers.indexed) {
      if (layer.id != null || matches[index] != null) continue;
      final candidates = unmatched
          .where(
            (record) =>
                record.layer.runtimeType == layer.runtimeType &&
                identical(record.layer.list, layer.list),
          )
          .toList();
      final incoming = layers
          .where(
            (candidate) =>
                candidate.id == null &&
                candidate.runtimeType == layer.runtimeType &&
                identical(candidate.list, layer.list),
          )
          .length;
      if (candidates.length == 1 && incoming == 1) {
        final match = unmatched.indexOf(candidates.single);
        matches[index] = unmatched.removeAt(match);
      }
    }

    // A new list instance with the same features can still identify a moved
    // layer, provided the match is unique on both sides.
    for (final (index, layer) in layers.indexed) {
      if (layer.id != null || matches[index] != null) continue;
      final candidates = unmatched
          .where(
            (record) =>
                record.layer.runtimeType == layer.runtimeType &&
                _sameFeatures(record.features, layer.list),
          )
          .toList();
      if (candidates.length != 1) continue;
      final candidate = candidates.single;
      final incoming = layers
          .where(
            (other) =>
                other.id == null &&
                other.runtimeType == layer.runtimeType &&
                _sameFeatures(candidate.features, other.list),
          )
          .length;
      if (incoming == 1) {
        matches[index] = unmatched.remove(candidate);
      }
    }

    // If a layer stays in its slot but receives a new feature-list instance,
    // keep the record when its concrete layer type is unchanged.
    for (final (index, layer) in layers.indexed) {
      if (layer.id != null ||
          matches[index] != null ||
          index >= _records.length) {
        continue;
      }
      final record = _records[index];
      final match = unmatched.indexOf(record);
      if (match != -1 &&
          record.layer.id == null &&
          record.layer.runtimeType == layer.runtimeType) {
        matches[index] = unmatched.removeAt(match);
      }
    }

    return matches;
  }

  static bool _sameFeatures(List<Feature> a, List<Feature> b) {
    if (a.length != b.length) return false;
    for (var index = 0; index < a.length; index++) {
      if (!identical(a[index], b[index]) && a[index] != b[index]) {
        return false;
      }
    }
    return true;
  }

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

  GeoJsonSource _sourceOf(_ManagedLayer record) => GeoJsonSource.data(
    id: record.sourceId,
    data: _dataOf(record.layer),
  );

  StyleLayer _createStyleLayer(
    Layer layer,
    int index,
    _ManagedLayer record,
  ) {
    final styleLayer = layer.createStyleLayer(index);
    return StyleLayer.fromJson({
      ...styleLayer.toJson(),
      'id': record.layerId,
      if (styleLayer is StyleLayerWithSource) 'source': record.sourceId,
    });
  }

  static bool _requiresReplacement(StyleLayer current, StyleLayer next) =>
      current.type != next.type ||
      _sourceOfLayer(current) != _sourceOfLayer(next);

  static (String?, String?) _sourceOfLayer(StyleLayer layer) =>
      layer is StyleLayerWithSource
      ? (layer.sourceId, layer.sourceLayerId)
      : (null, null);

  /// Updates the map to match [layers], retaining records for unchanged or
  /// identifiable layers and moving their existing style layers into place.
  void updateLayers(List<Layer> layers) {
    _validateIds(layers);
    final oldRecords = List<_ManagedLayer>.of(_records);
    final matches = _matchRecords(layers);
    final reservedIds = {
      for (final layer in layers)
        if (layer.id != null) layer.id!,
    };
    final nextRecords = <_ManagedLayer>[];
    final newRecords = <_ManagedLayer>{};
    final replacements = <_ManagedLayer>{};
    final replacementStyles = <_ManagedLayer, StyleLayer>{};
    final updatedStyles = <_ManagedLayer, StyleLayer>{};
    final updatedData = <_ManagedLayer>{};
    final nextLayers = <_ManagedLayer, Layer>{};

    for (final (index, layer) in layers.indexed) {
      var record = matches[index];
      if (record == null) {
        record = _createRecord(layer, index, reservedIds);
        newRecords.add(record);
      } else {
        final previous = record.layer;
        if (layer != previous) {
          final nextStyle = _createStyleLayer(layer, index, record);
          if (_requiresReplacement(record.styleLayer, nextStyle)) {
            replacements.add(record);
            replacementStyles[record] = nextStyle;
          } else {
            updatedStyles[record] = nextStyle;
          }
        }
        if (previous.interactive != layer.interactive ||
            !_sameFeatures(record.features, layer.list)) {
          updatedData.add(record);
        }
      }
      nextRecords.add(record);
      nextLayers[record] = layer;
    }

    final layerIds = <String>{};
    for (final record in nextRecords) {
      if (!layerIds.add(record.layerId)) {
        throw ArgumentError.value(
          record.layerId,
          'layers',
          'Layer ids must be unique.',
        );
      }
    }

    final removedRecords = oldRecords
        .where((record) => !nextRecords.contains(record))
        .toList();

    style.batch(() {
      // A drag is tied to the layer stack. End it if that stack changes or its
      // layer is removed/recreated or stops being draggable.
      if (_drag case final drag?) {
        final nextLayer = nextLayers[drag.record];
        if (!nextLayer == null ||
            !nextLayer.draggable ||
            drag.featureIndex >= nextLayer.list.length ||
            nextLayer.runtimeType != drag.record.layer.runtimeType ||
            replacements.contains(drag.record)) {
          _finishDrag();
        }
      }

      // Detach each removed layer before its source, then remove every
      // replacement before adding any new style layer.
      for (final record in oldRecords.reversed) {
        if (removedRecords.contains(record) || replacements.contains(record)) {
          unawaited(style.layers.remove(record.layerId));
        }
        if (removedRecords.contains(record)) {
          unawaited(style.sources.remove(record.sourceId));
        }
      }

      for (final record in newRecords) {
        unawaited(style.sources.add(_sourceOf(record)));
      }

      for (final record in updatedData) {
        final layer = nextLayers[record]!;
        final written = style.sources.updateGeoJsonData(
          record.sourceId,
          _dataOf(layer),
        );
        final drag = _drag;
        if (drag != null &&
            identical(drag.record, record) &&
            drag.ending &&
            !drag.committed) {
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

      for (final entry in updatedStyles.entries) {
        entry.key.styleLayer.updateFrom(entry.value);
      }
      for (final entry in replacementStyles.entries) {
        entry.key.styleLayer = entry.value;
      }
      for (final entry in nextLayers.entries) {
        entry.key
          ..layer = entry.value
          ..features = List<Feature>.of(entry.value.list);
      }

      if (_drag case final drag? when nextRecords.contains(drag.record)) {
        final index = nextRecords.indexOf(drag.record);
        if (updatedStyles.containsKey(drag.record)) {
          drag.overlay.updateFrom(_overlayOf(drag.record, index));
          _hideDragged(drag.record, index, drag);
        }
      }

      _records
        ..clear()
        ..addAll(nextRecords);

      // Add new and replaced layers top to bottom. Each layer is anchored
      // below the next declarative layer, which is already present.
      for (var index = nextRecords.length - 1; index >= 0; index--) {
        final record = nextRecords[index];
        if (!newRecords.contains(record) && !replacements.contains(record)) {
          continue;
        }
        final belowLayerId = index + 1 < nextRecords.length
            ? nextRecords[index + 1].layerId
            : null;
        unawaited(
          style.layers.add(
            record.styleLayer,
            belowLayerId: belowLayerId,
          ),
        );
      }

      _moveLayersToMatchOrder();
    });
  }

  /// Moves only layers that are not already adjacent to their next layer.
  ///
  /// The style collection is bottom-to-top, so the desired top layer is placed
  /// first and the algorithm works down towards the bottom.
  void _moveLayersToMatchOrder() {
    final orderedIds = <String>[];
    for (final record in _records) {
      orderedIds.add(record.layerId);
      if (_drag case final drag? when identical(drag.record, record)) {
        orderedIds.add(drag.overlay.id);
      }
    }

    for (var index = orderedIds.length - 1; index >= 0; index--) {
      final id = orderedIds[index];
      final belowLayerId = index + 1 < orderedIds.length
          ? orderedIds[index + 1]
          : null;
      final current = style.layers.map((layer) => layer.id).toList();
      final currentIndex = current.indexOf(id);
      final belowIndex = belowLayerId == null
          ? current.length
          : current.indexOf(belowLayerId);
      if (currentIndex == -1 || belowIndex == -1) {
        throw StateError('An annotation layer is missing from the style.');
      }
      final alreadyInPlace = belowLayerId == null
          ? currentIndex == current.length - 1
          : belowIndex == currentIndex + 1;
      if (!alreadyInPlace) {
        style.layers.move(id, belowLayerId: belowLayerId);
      }
    }
  }

  /// Starts dragging [featureIndex] in the layer at [layerIndex].
  void startDrag(int layerIndex, int featureIndex) {
    style.batch(() {
      _finishDrag();
      if (layerIndex < 0 || layerIndex >= _records.length) return;
      final record = _records[layerIndex];
      if (!record.layer.draggable ||
          featureIndex < 0 ||
          featureIndex >= record.features.length) {
        return;
      }
      final feature = record.features[featureIndex];
      final geometry = feature.geometry;
      if (geometry == null) return;
      final drag = _drag = _FeatureDrag(
        record: record,
        featureIndex: featureIndex,
        feature: feature,
        overlay: _overlayOf(record, layerIndex),
      );
      unawaited(
        style.sources.add(
          GeoJsonSource.data(
            id: _dragSourceId,
            data: _overlayData(drag, geometry),
          ),
        ),
      );
      final belowLayerId = layerIndex + 1 < _records.length
          ? _records[layerIndex + 1].layerId
          : null;
      unawaited(style.layers.add(drag.overlay, belowLayerId: belowLayerId));
      _hideDragged(record, layerIndex, drag);
    });
  }

  /// Moves the currently dragged feature to [geometry].
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

  /// Ends the current drag. An unsaved feature returns on the next frame.
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

  void _finishDrag() {
    final drag = _drag;
    if (drag == null) return;
    _drag = null;
    unawaited(style.layers.remove(_dragLayerId));
    unawaited(style.sources.remove(_dragSourceId));

    final index = _records.indexOf(drag.record);
    if (index != -1) {
      drag.record.styleLayer.filter = _createStyleLayer(
        drag.record.layer,
        index,
        drag.record,
      ).filter;
    }
  }

  void _hideDragged(_ManagedLayer record, int index, _FeatureDrag drag) {
    final own = _createStyleLayer(record.layer, index, record).filter;
    final hide = Expression.notEqual(
      Expression.get(featureIndexProperty),
      Expression.literal(drag.featureIndex),
    );
    record.styleLayer.filter = own == null
        ? hide
        : Expression.all([own, hide]);
  }

  StyleLayer _overlayOf(_ManagedLayer record, int index) =>
      StyleLayer.fromJson({
    ..._createStyleLayer(record.layer, index, record).toJson(),
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
}

/// The state and generated IDs owned by one declarative annotation layer.
class _ManagedLayer {
  _ManagedLayer({
    required this.layer,
    required this.layerId,
    required this.sourceId,
  }) : features = List<Feature>.of(layer.list);

  Layer layer;
  final String layerId;
  final String sourceId;
  late StyleLayer styleLayer;
  List<Feature> features;
}

/// The overlay used while a feature is being dragged.
class _FeatureDrag {
  _FeatureDrag({
    required this.record,
    required this.featureIndex,
    required this.feature,
    required this.overlay,
  });

  final _ManagedLayer record;
  final int featureIndex;
  final Feature feature;
  final StyleLayer overlay;

  Geometry? next;
  bool sending = false;
  bool ending = false;
  bool committed = false;
}
