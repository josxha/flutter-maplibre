part of 'style_layer.dart';

/// The layers of a map style, from bottom to top.
///
/// Reading is synchronous: the collection is filled once when the style loads
/// and follows every change made through it. Changes apply to the collection
/// at once and reach the map in the order they were made.
///
/// {@category Style}
/// {@subCategory Style Layers}
final class StyleLayers extends Iterable<StyleLayer> {
  /// Creates an empty collection. Platforms create it, on their [StyleBackend]
  /// and the sources of their style.
  StyleLayers(this._backend, {required this._sources});

  final StyleBackend _backend;
  final StyleSources _sources;
  final _layers = <StyleLayer>[];
  final ValueNotifier<int> _callbacks = ValueNotifier(0);

  /// The part of the map that owns some of the layers, see
  /// [setStyleLayersOwner].
  StyleOwner? _styleOwner;

  /// Tells the owner that the app added, moved or removed a layer.
  void _layoutChanged() {
    final owner = _styleOwner;
    if (owner != null && !owner.isWriting) owner.layoutChanged();
  }

  /// The owner of the layer [id], if the layer has one and the change doesn't
  /// come from it.
  StyleOwner? _foreignOwnerOf(String id) {
    final owner = _styleOwner;
    if (owner == null || owner.isWriting || !owner.ownsLayer(id)) return null;
    return owner;
  }

  void _checkNotOwned(String id, String change) {
    final owner = _foreignOwnerOf(id);
    if (owner == null) return;
    throw StateError(
      'The style layer "$id" belongs to ${owner.name} and cannot be '
      '$change here. Change ${owner.name} instead.',
    );
  }

  /// Notifies its listeners when a layer of the collection gets its first
  /// [StyleLayer.onClick], [StyleLayer.onEnter] or [StyleLayer.onLeave] or
  /// loses its last one, so that the map listens for taps and the mouse
  /// only while a layer needs them.
  Listenable get callbacksChanged => _callbacks;

  void _callbacksChanged() => _callbacks.value++;

  @override
  Iterator<StyleLayer> get iterator => _layers.iterator;

  @override
  int get length => _layers.length;

  /// The layer [id], or null if the style has none.
  StyleLayer? operator [](String id) => switch (_indexOf(id)) {
    -1 => null,
    final index => _layers[index],
  };

  /// Adds [layer] below the layer [belowLayerId], or on top if it is null. Its
  /// source must be in [StyleController.sources].
  ///
  /// The layer is in this collection at once and [layer] is attached to the
  /// map, so its setters can be called right away. The future completes when
  /// the map took the layer. If the map rejects it, the future completes with
  /// the error and the layer is taken out again.
  ///
  /// Fails with an [ArgumentError] if the layer's id is taken, its source is
  /// missing or [belowLayerId] is not a layer of this style, and with a
  /// [StateError] if [layer] already is on a map.
  Future<void> add(StyleLayer layer, {String? belowLayerId}) async {
    if (layer._owner != null) {
      throw StateError('The layer "${layer.id}" is already on a map.');
    }
    if (_indexOf(layer.id) != -1) {
      throw ArgumentError.value(layer.id, 'layer', 'The id is already in use');
    }
    if (layer is StyleLayerWithSource && _sources[layer.sourceId] == null) {
      throw ArgumentError.value(
        layer.sourceId,
        'layer.sourceId',
        'The style has no such source',
      );
    }
    final index = belowLayerId == null
        ? _layers.length
        : _indexOf(belowLayerId);
    if (index == -1) {
      throw ArgumentError.value(
        belowLayerId,
        'belowLayerId',
        'The style has no such layer',
      );
    }
    _layers.insert(index, layer);
    _attach(layer);
    if (layer._hasCallbacks) _callbacksChanged();
    _layoutChanged();
    try {
      await _backend.addLayer(layer.toJson(), belowLayerId: belowLayerId);
    } catch (_) {
      if (identical(layer._owner, this)) {
        _layers.remove(layer);
        _detach(layer);
        if (layer._hasCallbacks) _callbacksChanged();
      }
      rethrow;
    }
  }

  /// Removes the layer [id] and detaches its object. Removing a layer the
  /// style doesn't have does nothing.
  ///
  /// Fails with a [StateError] for a layer of [MapLibreMap.layers]: change
  /// that list instead.
  Future<void> remove(String id) async {
    final index = _indexOf(id);
    if (index == -1) return;
    _checkNotOwned(id, 'removed');
    final layer = _layers.removeAt(index);
    _detach(layer);
    if (layer._hasCallbacks) _callbacksChanged();
    _layoutChanged();
    await _backend.removeLayer(id);
  }

  /// Moves the layer [id] below the layer [belowLayerId], or to the top if it
  /// is null. Fails with an [ArgumentError] if either isn't a layer of this
  /// style.
  ///
  /// Fails with a [StateError] for a layer of [MapLibreMap.layers]: change
  /// the order of that list or the [Layer.anchor] of the layer instead.
  void move(String id, {String? belowLayerId}) {
    final index = _indexOf(id);
    if (index == -1) {
      throw ArgumentError.value(id, 'id', 'The style has no such layer');
    }
    _checkNotOwned(id, 'moved');
    if (id == belowLayerId) return;
    if (belowLayerId != null && _indexOf(belowLayerId) == -1) {
      throw ArgumentError.value(
        belowLayerId,
        'belowLayerId',
        'The style has no such layer',
      );
    }
    final layer = _layers.removeAt(index);
    _layers.insert(
      belowLayerId == null ? _layers.length : _indexOf(belowLayerId),
      layer,
    );
    _backend.moveLayer(id, belowLayerId: belowLayerId);
    _layoutChanged();
  }

  /// Fills the collection with the layers of a loaded style, by the `layers`
  /// member of its JSON. Platforms call it.
  void load(Iterable<Map<String, Object?>> layers) {
    for (final json in layers) {
      final layer = StyleLayer.fromJson(json);
      _layers.add(layer);
      _attach(layer);
    }
  }

  /// Detaches every layer object, when the style goes away. Platforms call it.
  void dispose() {
    final hadCallbacks = _layers.any((layer) => layer._hasCallbacks);
    _layers.forEach(_detach);
    _layers.clear();
    if (hadCallbacks) _callbacksChanged();
  }

  int _indexOf(String id) => _layers.indexWhere((layer) => layer.id == id);

  void _attach(StyleLayer layer) {
    layer
      .._owner = this
      .._wasAttached = true;
  }

  void _detach(StyleLayer layer) => layer._owner = null;
}

/// Makes [owner] the owner of some layers of [layers], or no one if it is
/// null, see [setStyleOwner].
///
/// Not part of the public API: `style.dart` hides it.
void setStyleLayersOwner(StyleLayers layers, StyleOwner? owner) {
  layers._styleOwner = owner;
}
