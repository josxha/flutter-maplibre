import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/layer/annotation_placement.dart';
import 'package:maplibre_platform_interface/src/style/style_owner.dart';

part 'annotation_drag.dart';
part 'annotation_images.dart';

/// A layer of [MapLibreMap.layers], from when it first shows up in the list
/// until it leaves it. Its style layer and its source have the id [id].
class AnnotationEntry {
  AnnotationEntry._(this._id, this._layer)
    : _features = List.of(_layer.list),
      _shownIcon = _layer.icon;

  /// The id of the style layer and of the source. A generated id changes
  /// when a style that loads already uses it.
  String get id => _id;
  String _id;

  /// The current definition of the layer.
  Layer get layer => _layer;
  Layer _layer;

  /// Whether the layer is still in the list.
  bool get mounted => _mounted;
  var _mounted = true;

  /// Copies of the features of [layer] as they were when the source was last
  /// written. `Layer.==` compares `list` by identity, and an app that adds to
  /// its list in place hands back the same instance, so only a copy shows
  /// what changed.
  List<Feature> _features;

  /// The icon that the style layer shows. After [Layer.icon] changed, it
  /// stays the old icon until the image of the new one is on the style, so
  /// that the markers don't disappear meanwhile.
  MarkerIcon? _shownIcon;

  /// Whether the source is on the current style. A layer whose id the style
  /// already used when it loaded is not.
  var _onStyle = false;

  /// The style layer on the current style, if it has been added.
  StyleLayer? _styleLayer;

  /// The anchor layer that was missing when debug builds last warned.
  String? _warnedAnchor;

  @override
  String toString() => 'AnnotationEntry($id, ${layer.runtimeType})';
}


/// Keeps the layers of [MapLibreMap.layers] on the map, one manager per map.
///
/// It holds the definitions and features of the layers, whether or not a
/// style is loaded, adds their sources, style layers and images to every
/// style that loads ([attach]), and applies only what changed when the list
/// changes ([update]). It owns their style layers and sources on the style
/// (see [StyleOwner]), places the style layers by [placeLayers], keeps the
/// images of the icons in [_AnnotationImages], and shows the feature that
/// the user drags in a [_FeatureDrag].
///
/// This is an internal class that is not exported publicly.
class AnnotationManager implements StyleOwner {
  /// Creates the manager with the initial [layers]. It adds them to the map
  /// once a style is [attach]ed.
  AnnotationManager(List<Layer> layers) {
    update(layers);
  }

  /// The property that holds the index of each feature in [Layer.list] while
  /// the layer is [Layer.interactive], to tell which feature the user tapped,
  /// hovered or dragged.
  static const featureIndexProperty = 'maplibre:index';

  /// How long a dropped feature stays in the overlay after its layer's
  /// source has it at its new place, while the map tiles that source again.
  /// Without it, the feature would show at its old place for a moment.
  static const _retileDelay = Duration(milliseconds: 250);

  StyleController? _style;

  /// The style that the layers are on, if one is loaded.
  StyleController? get style => _style;

  /// The layers in the order of [MapLibreMap.layers].
  List<AnnotationEntry> get entries => UnmodifiableListView(_entries);
  var _entries = <AnnotationEntry>[];

  /// The number of ids generated so far, by the type of the style layer.
  final _idCounters = <String, int>{};

  final _images = _AnnotationImages();

  /// The feature that the user drags, see [startDrag].
  _FeatureDrag? _drag;

  /// The depth of [_apply] calls, while the layers change their own style.
  var _writing = 0;

  /// Whether [_place] is scheduled after a change of the app to the order
  /// of the style's layers.
  var _placeScheduled = false;

  /// The layer with the id [id], or null.
  AnnotationEntry? operator [](String id) {
    for (final entry in _entries) {
      if (entry.id == id) return entry;
    }
    return null;
  }

  /// Whether the style layer [id] is one of the layers, or the overlay of a
  /// drag.
  bool owns(String id) =>
      id == _FeatureDrag.layerId || (this[id]?._onStyle ?? false);

  // ---------------------------------------------------------------------------
  // StyleOwner

  @override
  String get name => 'MapLibreMap.layers';

  @override
  bool get isWriting => _writing > 0;

  @override
  bool ownsLayer(String id) =>
      (id == _FeatureDrag.layerId && _drag != null) ||
      this[id]?._styleLayer != null;

  @override
  bool ownsSource(String id) => this[id]?._onStyle ?? false;

  /// Places the layers again after the app added, moved or removed a layer
  /// of the style, once its changes of this task are done.
  @override
  void layoutChanged() {
    final style = _style;
    if (style == null || _placeScheduled) return;
    _placeScheduled = true;
    scheduleMicrotask(() {
      _placeScheduled = false;
      if (identical(_style, style)) _apply(_place);
    });
  }

  // ---------------------------------------------------------------------------
  // Styles

  /// Adds every layer to [style], which just loaded. The layers of the style
  /// before are gone with it.
  ///
  /// A layer whose [Layer.id] the style already uses is left out, and the
  /// error is reported.
  void attach(StyleController style) {
    detach();
    _style = style;
    setStyleOwner(style, this);
    _apply(() {
      for (final entry in _entries) {
        if (_clashes(entry.id, style) != null && entry.layer.id == null) {
          // A generated id that the style uses gets another number.
          final taken = {for (final other in _entries) other.id};
          entry._id = _generateId(entry.layer, taken, const []);
        }
        // The style keeps a layer or source of the same id, until another
        // style loads.
        if (_clashes(entry.id, style) case final error?) {
          _report(error, StackTrace.current, 'while adding MapLibreMap.layers');
          continue;
        }
        entry._onStyle = true;
        unawaited(style.sources.add(_sourceOf(entry)));
      }
      _images.attach(style);
      _place();
    });
  }

  /// Forgets the style, which is about to be replaced or gone, with the
  /// layers on it.
  void detach() {
    if (_style case final style?) setStyleOwner(style, null);
    _style = null;
    _drag?.end(null);
    _drag = null;
    for (final entry in _entries) {
      entry
        .._onStyle = false
        .._styleLayer = null;
      // Without a style, nothing shows the old icon any more.
      _showIcon(entry, entry.layer.icon);
    }
    _images.detach();
  }

  /// The error of a [Layer.id] that [style] already uses, or null.
  static ArgumentError? _clashes(String id, StyleController style) {
    if (style.layers[id] != null) {
      return ArgumentError.value(
        id,
        'Layer.id',
        'The style already has a layer with this id',
      );
    }
    if (style.sources[id] != null) {
      return ArgumentError.value(
        id,
        'Layer.id',
        'The style already has a source with this id',
      );
    }
    return null;
  }

  /// Runs [changes] in one batch of the style, as changes of the owner of
  /// the layers' style layers and sources.
  void _apply(void Function() changes) {
    final style = _style;
    if (style == null) return changes();
    _writing++;
    try {
      style.batch(changes);
    } finally {
      _writing--;
    }
  }

  // ---------------------------------------------------------------------------
  // Layers

  /// Brings the layers to [layers], the new [MapLibreMap.layers], like
  /// `Element.updateChildren` does for widgets.
  ///
  /// A layer with a [Layer.id] matches the layer of that id. A layer without
  /// one matches the next one of the same type without an id, in the order
  /// of the list. Matched layers keep their style layer and source and only
  /// get what changed, the others are added and removed. Moves move the
  /// style layers.
  ///
  /// Throws an [ArgumentError] if a new [Layer.id] is reserved or in use by
  /// a layer or source of the style, or by another layer.
  void update(List<Layer> layers) {
    assert(() {
      final ids = <String>{};
      for (final layer in layers) {
        if (layer.id case final id? when !ids.add(id)) {
          throw FlutterError(
            'Two layers of MapLibreMap.layers have the id "$id". The ids of '
            'the layers must be unique.',
          );
        }
      }
      return true;
    }(), 'The ids of MapLibreMap.layers must be unique.');
    final keyed = <String, AnnotationEntry>{};
    final unkeyed = <Type, Queue<AnnotationEntry>>{};
    for (final entry in _entries) {
      if (entry.layer.id case final id?) {
        keyed[id] = entry;
      } else {
        unkeyed.putIfAbsent(entry.layer.runtimeType, Queue.new).add(entry);
      }
    }
    final matches = [
      for (final layer in layers)
        switch (layer.id) {
          final id? => keyed.remove(id),
          null => switch (unkeyed[layer.runtimeType]) {
            final queue? when queue.isNotEmpty => queue.removeFirst(),
            _ => null,
          },
        },
    ];
    final removed = [
      ...keyed.values,
      for (final queue in unkeyed.values) ...queue,
    ];

    // Names the new layers before anything changes, so that a clash leaves
    // the map as it was.
    final taken = {
      for (final entry in matches)
        if (entry != null) entry.id,
    };
    final ids = <String>[];
    for (final (index, layer) in layers.indexed) {
      if (matches[index] != null) continue;
      final id = switch (layer.id) {
        final id? => _checkId(id, taken, removed),
        null => _generateId(layer, taken, removed),
      };
      taken.add(id);
      ids.add(id);
    }

    _apply(() {
      if (_drag case final drag?) {
        final index = matches.indexWhere(
          (entry) => identical(entry, drag.entry),
        );
        _checkDrag(index == -1 ? null : layers[index]);
      }
      removed.forEach(_remove);
      final next = <AnnotationEntry>[];
      var newIndex = 0;
      for (final (index, layer) in layers.indexed) {
        if (matches[index] case final entry?) {
          _update(entry, layer);
          next.add(entry);
        } else {
          next.add(_add(layer, ids[newIndex++]));
        }
      }
      _entries = next;
      _place();
    });
  }

  /// Returns [id], the [Layer.id] of a new layer, or throws an
  /// [ArgumentError] if it is reserved, [taken] by another layer, or used by
  /// the style other than by a [removed] layer.
  String _checkId(String id, Set<String> taken, List<AnnotationEntry> removed) {
    if (taken.contains(id)) {
      throw ArgumentError.value(
        id,
        'Layer.id',
        'Another layer of MapLibreMap.layers has this id',
      );
    }
    if (id.startsWith('maplibre-')) {
      throw ArgumentError.value(
        id,
        'Layer.id',
        'Ids that start with "maplibre-" are reserved for the map',
      );
    }
    if (_style case final style? when !_isOwn(id, removed)) {
      if (_clashes(id, style) case final error?) throw error;
    }
    return id;
  }

  /// Ends the drag if [next], the new definition of the dragged layer, or
  /// null if it is gone, no longer has the dragged feature.
  void _checkDrag(Layer? next) {
    final drag = _drag;
    if (drag == null) return;
    if (next == null ||
        !next.draggable ||
        drag.featureIndex >= next.list.length ||
        next.runtimeType != drag.entry.layer.runtimeType) {
      _finishDrag();
    }
  }

  static bool _isOwn(String id, List<AnnotationEntry> entries) =>
      entries.any((entry) => entry.id == id);

  /// An id for [layer], `maplibre-<type>-<n>` by the type of its style
  /// layer, that neither [taken], the style nor the other layers use.
  String _generateId(
    Layer layer,
    Set<String> taken,
    List<AnnotationEntry> removed,
  ) {
    // The type of the style layer, as `runtimeType` is minified in release
    // builds on web.
    final type = layer.createStyleLayer(id: '', sourceId: '').type;
    final style = _style;
    while (true) {
      final count = _idCounters[type] = (_idCounters[type] ?? 0) + 1;
      final id = 'maplibre-$type-$count';
      if (taken.contains(id) || _isOwn(id, removed)) continue;
      if (style != null && _clashes(id, style) != null) continue;
      return id;
    }
  }

  /// Adds the layer [layer] with the id [id]. Its style layer is added by
  /// [_place].
  AnnotationEntry _add(Layer layer, String id) {
    final entry = AnnotationEntry._(id, layer);
    if (layer.icon case final icon?) _images.acquire(icon);
    if (_style case final style?) {
      entry._onStyle = true;
      unawaited(style.sources.add(_sourceOf(entry)));
    }
    return entry;
  }

  /// Removes the layer of [entry] with its style layer and source.
  void _remove(AnnotationEntry entry) {
    entry._mounted = false;
    if (identical(_drag?.entry, entry)) _finishDrag();
    _showIcon(entry, entry.layer.icon);
    if (entry.layer.icon case final icon?) _images.release(icon);
    final style = _style;
    if (style == null || !entry._onStyle) return;
    entry._onStyle = false;
    if (entry._styleLayer != null) {
      unawaited(style.layers.remove(entry.id));
      entry._styleLayer = null;
    }
    unawaited(style.sources.remove(entry.id));
  }

  /// Brings [entry] to [layer], its new definition.
  void _update(AnnotationEntry entry, Layer layer) {
    final old = entry.layer;
    entry._layer = layer;
    if (old.icon != layer.icon) _changeIcon(entry, old.icon);
    final sameFeatures = _sameFeatures(entry._features, layer.list);
    final style = _style;
    if (style == null || !entry._onStyle) {
      if (!sameFeatures) entry._features = List.of(layer.list);
      return;
    }
    // Only re-serialise a source whose features actually changed. Building
    // the GeoJSON is the expensive half of this call.
    if (layer.interactive != old.interactive || !sameFeatures) {
      final written = style.sources.updateGeoJsonData(entry.id, _dataOf(layer));
      final drag = _drag;
      if (drag != null &&
          identical(drag.entry, entry) &&
          drag.state == _DropState.dropped) {
        // The app saved the dropped feature: show the layer's feature again
        // once the source has it.
        drag.state = _DropState.saved;
        unawaited(
          written.whenComplete(() async {
            await Future<void>.delayed(_retileDelay);
            if (identical(_drag, drag)) _apply(_finishDrag);
          }),
        );
      } else {
        unawaited(written);
      }
    }
    if (!sameFeatures) entry._features = List.of(layer.list);
    if (layer != old) _refreshStyleLayer(entry);
  }

  /// Brings the style layer of [entry], if it has one, and the overlay of
  /// its drag to its definition.
  void _refreshStyleLayer(AnnotationEntry entry) {
    if (entry._styleLayer == null) return;
    _updateStyleLayer(entry);
    if (_drag case final drag? when identical(drag.entry, entry)) {
      drag.overlay.updateFrom(_overlayOf(entry));
      _hideDragged(drag);
    }
  }

  /// Switches [entry] from the icon [old] to its new [Layer.icon]. The style
  /// layer shows the icon it shows until the new image is on the style.
  void _changeIcon(AnnotationEntry entry, MarkerIcon? old) {
    final icon = entry.layer.icon;
    // The new image first, which keeps an image both show. The layer holds
    // the image of its icon and of the icon it shows, once each.
    if (icon != null && icon != entry._shownIcon) _images.acquire(icon);
    // An icon that the layer had but never showed goes at once.
    if (old != null && old != entry._shownIcon) _images.release(old);
    final style = _style;
    final added = icon == null ? null : _images.whenAdded(icon);
    if (style == null || entry._styleLayer == null || added == null) {
      _showIcon(entry, icon);
      return;
    }
    unawaited(
      added.then((added) {
        // A failed image keeps the old icon on the map.
        if (!added ||
            !entry.mounted ||
            !identical(_style, style) ||
            entry.layer.icon != icon ||
            entry._shownIcon == icon) {
          return;
        }
        _apply(() {
          _showIcon(entry, icon);
          _refreshStyleLayer(entry);
        });
      }),
    );
  }

  /// Makes the style layer of [entry] show [icon] from now on, and releases
  /// the image of the icon it showed before, unless that is still its
  /// [Layer.icon].
  void _showIcon(AnnotationEntry entry, MarkerIcon? icon) {
    final shown = entry._shownIcon;
    if (shown == icon) return;
    entry._shownIcon = icon;
    if (shown != null && shown != entry.layer.icon) _images.release(shown);
  }

  /// Brings the style layer of [entry] to its definition: only its changed
  /// properties, or a new style layer if its type or source changed, which
  /// [_place] adds.
  void _updateStyleLayer(AnnotationEntry entry) {
    final current = entry._styleLayer!;
    final next = _createStyleLayer(entry);
    if (current.type == next.type &&
        _sourceOfLayer(current) == _sourceOfLayer(next)) {
      current.updateFrom(next);
      return;
    }
    if (identical(_drag?.entry, entry)) _finishDrag();
    unawaited(_style!.layers.remove(entry.id));
    entry._styleLayer = null;
  }

  static (String?, String?) _sourceOfLayer(StyleLayer layer) =>
      layer is StyleLayerWithSource
      ? (layer.sourceId, layer.sourceLayerId)
      : (null, null);

  /// The style layer of [entry], with the image of its icon.
  StyleLayer _createStyleLayer(AnnotationEntry entry) {
    final layer = entry.layer;
    final styleLayer = layer.createStyleLayer(id: entry.id, sourceId: entry.id);
    if ((entry._shownIcon, styleLayer) case (
      final icon?,
      final SymbolStyleLayer symbol,
    )) {
      symbol.iconImage = switch (icon) {
        MarkerIconNamed(:final imageId) => Expression.literal(imageId),
        MarkerIconExpression(:final imageId) => imageId,
        _ => Expression.literal(_images.idOf(icon)),
      };
    }
    return styleLayer;
  }

  static bool _sameFeatures(List<Feature> a, List<Feature> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!identical(a[i], b[i]) && a[i] != b[i]) return false;
    }
    return true;
  }

  static GeoJsonSource _sourceOf(AnnotationEntry entry) =>
      GeoJsonSource.data(id: entry.id, data: _dataOf(entry.layer));

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

  // ---------------------------------------------------------------------------
  // Order

  /// Adds the missing style layers and moves the others into the order of
  /// the list, by their anchors, see [placeLayers].
  void _place() {
    final style = _style;
    if (style == null) return;
    final own = {for (final entry in _entries) entry.id};
    final onStyle = {
      for (final entry in _entries)
        if (entry._onStyle) entry.id: entry,
    };
    final drag = _drag;
    final steps = placeLayers(
      [for (final layer in style.layers) layer.id],
      [
        for (final entry in onStyle.values)
          (
            id: entry.id,
            anchor: _anchorOf(entry, style, own),
            added: entry._styleLayer != null,
          ),
      ],
      overlay: drag == null
          ? null
          : (id: _FeatureDrag.layerId, aboveId: drag.entry.id),
    );
    for (final step in steps) {
      switch (step.kind) {
        case PlacementKind.move:
          style.layers.move(step.id, belowLayerId: step.belowLayerId);
        case PlacementKind.add:
          final entry = onStyle[step.id]!;
          final styleLayer = entry._styleLayer = _createStyleLayer(entry);
          if (drag != null && identical(drag.entry, entry)) _hideDragged(drag);
          unawaited(
            _addStyleLayer(style, entry, styleLayer, step.belowLayerId),
          );
      }
    }
  }

  /// The anchor of [entry], or [LayerAnchor.top] if the layer it names is not
  /// a layer of the style.
  LayerAnchor _anchorOf(
    AnnotationEntry entry,
    StyleController style,
    Set<String> own,
  ) {
    final anchor = entry.layer.anchor;
    final layerId = switch (anchor) {
      LayerAnchorBelow(:final layerId) ||
      LayerAnchorAbove(:final layerId) => layerId,
      _ => null,
    };
    if (layerId == null) return anchor;
    if (style.layers[layerId] != null &&
        !own.contains(layerId) &&
        layerId != _FeatureDrag.layerId) {
      entry._warnedAnchor = null;
      return anchor;
    }
    if (kDebugMode && entry._warnedAnchor != layerId) {
      debugPrint(
        'maplibre: the anchor of the layer "${entry.id}" names the layer '
        '"$layerId", which the style does not have, so it goes on top. '
        'Anchors name layers of the style, not of MapLibreMap.layers.',
      );
    }
    entry._warnedAnchor = layerId;
    return const LayerAnchor.top();
  }

  /// Adds [styleLayer] of [entry] to [style]. If the map rejects it, the
  /// error is reported and the next placement adds the layer again.
  Future<void> _addStyleLayer(
    StyleController style,
    AnnotationEntry entry,
    StyleLayer styleLayer,
    String? belowLayerId,
  ) async {
    try {
      await style.layers.add(styleLayer, belowLayerId: belowLayerId);
    } on Object catch (error, stack) {
      // The style took the layer out again.
      if (identical(entry._styleLayer, styleLayer)) entry._styleLayer = null;
      if (identical(_style, style)) {
        _report(error, stack, 'while adding MapLibreMap.layers');
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Drags

  /// Lets the user drag the feature [featureIndex] of the layer of [entry].
  ///
  /// The feature moves to the overlay of a [_FeatureDrag], and its layer
  /// hides it, so that [moveDrag] moves it without writing the layer's
  /// whole source.
  void startDrag(AnnotationEntry entry, int featureIndex) {
    final style = _style;
    if (style == null) return;
    _apply(() {
      _finishDrag();
      final layer = entry.layer;
      final features = entry._features;
      if (!entry.mounted ||
          entry._styleLayer == null ||
          !layer.draggable ||
          featureIndex >= features.length) {
        return;
      }
      final feature = features[featureIndex];
      final geometry = feature.geometry;
      if (geometry == null) return;
      final drag = _drag = _FeatureDrag(
        entry,
        featureIndex,
        feature,
        _overlayOf(entry),
      );
      final ids = [for (final layer in style.layers) layer.id];
      final above = ids.indexOf(entry.id) + 1;
      drag.show(style, geometry, above < ids.length ? ids[above] : null);
      _hideDragged(drag);
    });
  }

  /// Shows the dragged feature with [geometry].
  void moveDrag(Geometry geometry) {
    final drag = _drag;
    final style = _style;
    if (drag == null || style == null) return;
    if (drag.state == _DropState.dragging) drag.move(style, geometry);
  }

  /// Ends the drag. The feature stays in the overlay until the app saves it
  /// at its new place in the layer, or goes back after the next frame if
  /// the app doesn't.
  void endDrag() {
    final drag = _drag;
    if (drag == null || drag.state != _DropState.dragging) return;
    drag.state = _DropState.dropped;
    SchedulerBinding.instance
      ..addPostFrameCallback((_) {
        if (identical(_drag, drag) && drag.state == _DropState.dropped) {
          _apply(_finishDrag);
        }
      })
      ..scheduleFrame();
  }

  /// Removes the overlay of the drag and shows the feature in its layer
  /// again. Call it in [_apply].
  void _finishDrag() {
    final drag = _drag;
    if (drag == null) return;
    _drag = null;
    final style = _style;
    drag.end(style);
    if (style == null) return;
    final entry = drag.entry;
    if (entry._styleLayer case final styleLayer? when entry.mounted) {
      styleLayer.filter = _createStyleLayer(entry).filter;
    }
  }

  /// Hides the dragged feature in its layer.
  void _hideDragged(_FeatureDrag drag) {
    final styleLayer = drag.entry._styleLayer;
    if (styleLayer == null) return;
    final own = _createStyleLayer(drag.entry).filter;
    styleLayer.filter = drag.hidingFilter(own);
  }

  StyleLayer _overlayOf(AnnotationEntry entry) => StyleLayer.fromJson({
    ..._createStyleLayer(entry).toJson(),
    'id': _FeatureDrag.layerId,
    'source': _FeatureDrag.sourceId,
  });
}

void _report(Object error, StackTrace stack, String context) {
  FlutterError.reportError(
    FlutterErrorDetails(
      exception: error,
      stack: stack,
      library: 'maplibre',
      context: ErrorDescription(context),
    ),
  );
}
