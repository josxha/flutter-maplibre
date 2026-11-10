import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/style/layers/style_layer.dart'
    show setAnnotationLayer, writeAsAnnotations;

/// A layer of [MapLibreMap.layers], from when it first shows up in the list
/// until it leaves it. Its style layer and its source have the id [id].
class AnnotationEntry {
  AnnotationEntry._(this.id, this.layer) : _features = List.of(layer.list);

  /// The id of the style layer and of the source.
  final String id;

  /// The current definition of the layer.
  Layer layer;

  /// Whether the layer is still in the list.
  bool get mounted => _mounted;
  var _mounted = true;

  /// Copies of the features of [layer] as they were when the source was last
  /// written. `Layer.==` compares `list` by identity, and an app that adds to
  /// its list in place hands back the same instance, so only a copy shows
  /// what changed.
  List<Feature> _features;

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
/// changes ([update]).
///
/// This is an internal class that is not exported publicly.
class AnnotationManager {
  /// Creates the manager with the initial [layers]. It adds them to the map
  /// once a style is [attach]ed.
  AnnotationManager(List<Layer> layers) {
    update(layers);
  }

  /// The property that holds the index of each feature in [Layer.list] while
  /// the layer is [Layer.interactive], to tell which feature the user tapped,
  /// hovered or dragged.
  static const featureIndexProperty = 'maplibre:index';

  static const _dragSourceId = 'maplibre-drag-source';
  static const _dragLayerId = 'maplibre-drag-layer';

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

  /// The images that the icons of the layers show, by icon.
  final _images = <MarkerIcon, _StyleImage>{};
  var _imageCounter = 0;

  /// The feature that the user drags, see [startDrag].
  _FeatureDrag? _drag;

  /// The layer with the id [id], or null.
  AnnotationEntry? operator [](String id) {
    for (final entry in _entries) {
      if (entry.id == id) return entry;
    }
    return null;
  }

  /// Whether the style layer [id] is one of the layers, or the overlay of a
  /// drag.
  bool owns(String id) => id == _dragLayerId || this[id] != null;

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
    _apply(() {
      for (final entry in _entries) {
        // The style keeps a layer or source of the same id, until another
        // style loads.
        if (_clashes(entry.id, style) case final error?) {
          _report(error, StackTrace.current, 'while adding MapLibreMap.layers');
          continue;
        }
        entry._onStyle = true;
        unawaited(style.sources.add(_sourceOf(entry)));
      }
      for (final MapEntry(key: icon, value: image) in _images.entries) {
        _addImage(icon, image, style);
      }
      _place();
    });
  }

  /// Forgets the style, which is about to be replaced or gone, with the
  /// layers on it.
  void detach() {
    _style = null;
    _drag = null;
    for (final entry in _entries) {
      entry
        .._onStyle = false
        .._styleLayer = null;
    }
    for (final image in _images.values) {
      image.adding = null;
    }
  }

  /// The error of a [Layer.id] that [style] already uses, or null.
  ArgumentError? _clashes(String id, StyleController style) {
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

  /// Runs [changes] in one batch of the style, as changes of the annotations,
  /// which may change their own style layers.
  void _apply(void Function() changes) {
    final style = _style;
    if (style == null) return changes();
    style.batch(() => writeAsAnnotations(style.layers, changes));
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
  /// Throws an [ArgumentError] if a new [Layer.id] is in use by a layer or
  /// source of the style, or by another layer.
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
    final kept = {
      for (final entry in matches)
        if (entry != null) entry.id,
    };

    // Names the new layers before anything changes, so that a clash leaves
    // the map as it was.
    final style = _style;
    final taken = {...kept};
    final ids = <String>[];
    for (final (index, layer) in layers.indexed) {
      if (matches[index] != null) continue;
      if (layer.id case final id?) {
        if (taken.contains(id)) {
          throw ArgumentError.value(
            id,
            'Layer.id',
            'Another layer of MapLibreMap.layers has this id',
          );
        }
        if (style != null && !_isOwn(id, removed)) {
          if (_clashes(id, style) case final error?) throw error;
        }
        taken.add(id);
        ids.add(id);
      } else {
        final id = _generateId(layer, taken, removed);
        taken.add(id);
        ids.add(id);
      }
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

  /// Adds [layer] at [index] of the list, or on top, and returns its id.
  ///
  /// Throws an [ArgumentError] if its [Layer.id] is in use.
  String add(Layer layer, {int? index}) {
    final taken = {for (final entry in _entries) entry.id};
    final String id;
    if (layer.id case final layerId?) {
      if (taken.contains(layerId)) {
        throw ArgumentError.value(
          layerId,
          'Layer.id',
          'Another layer of MapLibreMap.layers has this id',
        );
      }
      if (_style case final style?) {
        if (_clashes(layerId, style) case final error?) throw error;
      }
      id = layerId;
    } else {
      id = _generateId(layer, taken, const []);
    }
    _apply(() {
      _entries.insert(index ?? _entries.length, _add(layer, id));
      _place();
    });
    return id;
  }

  /// Changes the layer [id] to [layer], applying only what changed.
  void updateLayer(String id, Layer layer) {
    final entry = this[id];
    if (entry == null) {
      throw ArgumentError.value(id, 'id', 'There is no such layer');
    }
    _apply(() {
      if (identical(_drag?.entry, entry)) _checkDrag(layer);
      _update(entry, layer);
      _place();
    });
  }

  /// Moves the layer [id] to [index] of the list, which moves its style
  /// layer.
  void move(String id, int index) {
    final entry = this[id];
    if (entry == null) {
      throw ArgumentError.value(id, 'id', 'There is no such layer');
    }
    _apply(() {
      _entries
        ..remove(entry)
        ..insert(index, entry);
      _place();
    });
  }

  /// Removes the layer [id] with its style layer and source.
  void remove(String id) {
    final entry = this[id];
    if (entry == null) return;
    _apply(() {
      _remove(entry);
      _entries.remove(entry);
    });
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
    if (layer.icon case final icon?) _acquireImage(icon);
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
    if (entry.layer.icon case final icon?) _releaseImage(icon);
    final style = _style;
    if (style == null || !entry._onStyle) return;
    entry._onStyle = false;
    if (entry._styleLayer != null) {
      unawaited(style.layers.remove(entry.id));
      setAnnotationLayer(style.layers, entry.id, owned: false);
      entry._styleLayer = null;
    }
    unawaited(style.sources.remove(entry.id));
  }

  /// Brings [entry] to [layer], its new definition.
  void _update(AnnotationEntry entry, Layer layer) {
    final old = entry.layer;
    entry.layer = layer;
    if (old.icon != layer.icon) {
      // The new image first, which keeps an image both show.
      if (layer.icon case final icon?) _acquireImage(icon);
      if (old.icon case final icon?) _releaseImage(icon);
    }
    final style = _style;
    if (style == null || !entry._onStyle) {
      entry._features = List.of(layer.list);
      return;
    }
    // Only re-serialise a source whose features actually changed. Building
    // the GeoJSON is the expensive half of this call.
    if (layer.interactive != old.interactive ||
        !_sameFeatures(entry._features, layer.list)) {
      final written = style.sources.updateGeoJsonData(entry.id, _dataOf(layer));
      final drag = _drag;
      if (drag != null &&
          identical(drag.entry, entry) &&
          drag.ending &&
          !drag.committed) {
        // The app saved the dropped feature: show the layer's feature again
        // once the source has it.
        drag.committed = true;
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
    entry._features = List.of(layer.list);
    if (layer != old && entry._styleLayer != null) {
      _updateStyleLayer(entry);
      if (_drag case final drag? when identical(drag.entry, entry)) {
        drag.overlay.updateFrom(_overlayOf(entry));
        _hideDragged(drag);
      }
    }
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
    if ((layer.icon, styleLayer) case (
      final icon?,
      final SymbolStyleLayer symbol,
    )) {
      symbol.iconImage = switch (icon) {
        MarkerIconNamed(:final imageId) => Expression.literal(imageId),
        MarkerIconExpression(:final imageId) => imageId,
        _ => Expression.literal(_images[icon]!.id),
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
  /// the list, by their anchors, with as few moves as it takes.
  void _place() {
    final style = _style;
    if (style == null) return;
    final own = {for (final entry in _entries) entry.id};
    final groups = <LayerAnchor, List<AnnotationEntry>>{};
    for (final entry in _entries) {
      if (!entry._onStyle) continue;
      groups.putIfAbsent(_anchorOf(entry, style, own), () => []).add(entry);
    }
    final ids = [for (final layer in style.layers) layer.id];
    final anchors = groups.keys.toList()
      ..sort((a, b) => _anchorRank(a).compareTo(_anchorRank(b)));
    for (final anchor in anchors) {
      _placeGroup(style, ids, anchor, groups[anchor]!);
    }
    _placeOverlay(style, ids);
  }

  static int _anchorRank(LayerAnchor anchor) => switch (anchor) {
    LayerAnchorTop() => 0,
    LayerAnchorBottom() => 1,
    LayerAnchorBelow() || LayerAnchorAbove() => 2,
  };

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
        layerId != _dragLayerId) {
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

  /// Places the layers of [group], which share [anchor], from the top down.
  /// [ids] are the ids of the style's layers, which this keeps up to date.
  void _placeGroup(
    StyleController style,
    List<String> ids,
    LayerAnchor anchor,
    List<AnnotationEntry> group,
  ) {
    final members = {for (final entry in group) entry.id};
    bool other(String id) => !members.contains(id) && id != _dragLayerId;

    // Whether [index] is where the group goes, among the other layers.
    bool inRegion(int index) {
      switch (anchor) {
        case LayerAnchorTop():
          for (var i = index + 1; i < ids.length; i++) {
            if (other(ids[i])) return false;
          }
          return true;
        case LayerAnchorBottom():
          for (var i = 0; i < index; i++) {
            if (other(ids[i])) return false;
          }
          return true;
        case LayerAnchorBelow(:final layerId):
          return index < ids.indexOf(layerId);
        case LayerAnchorAbove(:final layerId):
          return index > ids.indexOf(layerId);
      }
    }

    // The layer that the top of the group goes below, or null for the top.
    String? groupBelow() {
      switch (anchor) {
        case LayerAnchorTop():
          return null;
        case LayerAnchorBottom():
          for (final id in ids) {
            if (other(id)) return id;
          }
          return null;
        case LayerAnchorBelow(:final layerId):
          return layerId;
        case LayerAnchorAbove(:final layerId):
          final index = ids.indexOf(layerId);
          for (var i = index + 1; i < ids.length; i++) {
            if (other(ids[i])) return ids[i];
          }
          return null;
      }
    }

    for (var i = group.length - 1; i >= 0; i--) {
      final entry = group[i];
      final index = ids.indexOf(entry.id);
      final above = i + 1 < group.length ? group[i + 1].id : null;
      if (entry._styleLayer != null &&
          index != -1 &&
          inRegion(index) &&
          (above == null || index < ids.indexOf(above))) {
        continue;
      }
      final belowLayerId = above ?? groupBelow();
      if (entry._styleLayer == null) {
        final styleLayer = entry._styleLayer = _createStyleLayer(entry);
        setAnnotationLayer(style.layers, entry.id, owned: true);
        if (_drag case final drag? when identical(drag.entry, entry)) {
          _hideDragged(drag);
        }
        unawaited(style.layers.add(styleLayer, belowLayerId: belowLayerId));
      } else {
        style.layers.move(entry.id, belowLayerId: belowLayerId);
        ids.removeAt(index);
      }
      ids.insert(
        belowLayerId == null ? ids.length : ids.indexOf(belowLayerId),
        entry.id,
      );
    }
  }

  /// Keeps the overlay of the drag right above the layer of the dragged
  /// feature.
  void _placeOverlay(StyleController style, List<String> ids) {
    final drag = _drag;
    if (drag == null) return;
    final layerIndex = ids.indexOf(drag.entry.id);
    final index = ids.indexOf(_dragLayerId);
    if (layerIndex == -1 || index == -1 || index == layerIndex + 1) return;
    ids.removeAt(index);
    final above = ids.indexOf(drag.entry.id) + 1;
    style.layers.move(
      _dragLayerId,
      belowLayerId: above < ids.length ? ids[above] : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Images

  /// Whether the map adds the image of [icon] to the style, instead of
  /// [icon] naming images that the style has.
  static bool _addsImage(MarkerIcon icon) =>
      icon is! MarkerIconNamed && icon is! MarkerIconExpression;

  /// Adds a user of the image of [icon], which adds the image to the style
  /// for the first one.
  void _acquireImage(MarkerIcon icon) {
    if (!_addsImage(icon)) return;
    final image = _images.putIfAbsent(
      icon,
      () => _StyleImage('maplibre-icon-${++_imageCounter}'),
    );
    image.users++;
    if (image.users == 1 && _style != null) _addImage(icon, image, _style!);
  }

  /// Takes a user of the image of [icon] away, which removes the image from
  /// the style after the last one.
  void _releaseImage(MarkerIcon icon) {
    if (!_addsImage(icon)) return;
    final image = _images[icon];
    if (image == null || --image.users > 0) return;
    _images.remove(icon);
    final style = _style;
    final adding = image.adding;
    if (style == null || adding == null) return;
    image.adding = null;
    unawaited(
      adding
          .then((_) async {
            if (identical(_style, style)) await style.removeImage(image.id);
          })
          .catchError((Object error, StackTrace stack) {
            if (identical(_style, style)) {
              _report(
                error,
                stack,
                'while removing the image of a marker icon',
              );
            }
          }),
    );
  }

  void _addImage(MarkerIcon icon, _StyleImage image, StyleController style) {
    image.adding = _loadImage(icon, image.id, style).catchError((
      Object error,
      StackTrace stack,
    ) {
      // An image of a style that is gone needs no report.
      if (identical(_style, style)) {
        _report(error, stack, 'while adding the image of a marker icon');
      }
    });
  }

  static Future<void> _loadImage(
    MarkerIcon icon,
    String id,
    StyleController style,
  ) async {
    switch (icon) {
      case MarkerIconData(:final icon, :final color, :final size):
        await style.addImageFromIconData(
          id: id,
          iconData: icon,
          color: color,
          size: size,
        );
      case MarkerIconAsset(:final path, :final pixelRatio):
        await style.addImageFromAssets(
          id: id,
          asset: path,
          pixelRatio: pixelRatio,
        );
      case MarkerIconBytes(:final bytes, :final pixelRatio):
        await style.addImage(id, bytes, pixelRatio: pixelRatio);
      case MarkerIconProvider(:final provider):
        final info = await resolveImageInfo(provider);
        try {
          await style.addImageFromUiImage(
            id: id,
            image: info.image,
            pixelRatio: info.scale,
          );
        } finally {
          info.dispose();
        }
      case MarkerIconNamed() || MarkerIconExpression():
        break;
    }
  }

  static void _report(Object error, StackTrace stack, String context) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'maplibre',
        context: ErrorDescription(context),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Drags

  /// Lets the user drag the feature [featureIndex] of the layer of [entry].
  ///
  /// The feature moves to a one-feature overlay above its layer, and its
  /// layer hides it, so that [moveDrag] moves it without writing the
  /// layer's whole source.
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
      unawaited(
        style.sources.add(
          GeoJsonSource.data(
            id: _dragSourceId,
            data: _overlayData(drag, geometry),
          ),
        ),
      );
      final ids = [for (final layer in style.layers) layer.id];
      final above = ids.indexOf(entry.id) + 1;
      setAnnotationLayer(style.layers, _dragLayerId, owned: true);
      unawaited(
        style.layers.add(
          drag.overlay,
          belowLayerId: above < ids.length ? ids[above] : null,
        ),
      );
      _hideDragged(drag);
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
        final style = _style;
        if (geometry == null || style == null) break;
        drag.next = null;
        await style.sources.updateGeoJsonData(
          _dragSourceId,
          _overlayData(drag, geometry),
        );
      }
    } on Object catch (error, stack) {
      _report(error, stack, 'while moving a dragged feature');
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
        if (identical(_drag, drag) && !drag.committed) _apply(_finishDrag);
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
    if (style == null) return;
    unawaited(style.layers.remove(_dragLayerId));
    setAnnotationLayer(style.layers, _dragLayerId, owned: false);
    unawaited(style.sources.remove(_dragSourceId));
    final entry = drag.entry;
    if (entry._styleLayer case final styleLayer? when entry.mounted) {
      styleLayer.filter = _createStyleLayer(entry).filter;
    }
  }

  /// Hides the dragged feature in its layer.
  void _hideDragged(_FeatureDrag drag) {
    final entry = drag.entry;
    final styleLayer = entry._styleLayer;
    if (styleLayer == null) return;
    final own = _createStyleLayer(entry).filter;
    final hide = Expression.notEqual(
      Expression.get(featureIndexProperty),
      Expression.literal(drag.featureIndex),
    );
    styleLayer.filter = own == null ? hide : Expression.all([own, hide]);
  }

  StyleLayer _overlayOf(AnnotationEntry entry) => StyleLayer.fromJson({
    ..._createStyleLayer(entry).toJson(),
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

/// An image that the icons of layers show.
class _StyleImage {
  _StyleImage(this.id);

  /// The id of the image in the style.
  final String id;

  /// The number of layers that show it.
  int users = 0;

  /// Adds the image to the current style, null while no style has it.
  Future<void>? adding;
}

/// A feature that the user drags, shown in an overlay.
class _FeatureDrag {
  _FeatureDrag(this.entry, this.featureIndex, this.feature, this.overlay);

  final AnnotationEntry entry;
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
