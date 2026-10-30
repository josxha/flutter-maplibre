import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/style/expressions/expression_json.dart';

part 'style_layer_collection.dart';
part 'style_layers.g.dart';

/// A layer of a map style.
///
/// A layer is a plain object until it is on a map, either because it was added
/// with [StyleLayers.add] or because it came from [StyleController.layers].
/// From then on it is its own controller: its setters also update the map,
/// fire-and-forget and in order, so an animation can call them every frame.
/// Removing the layer or loading a new style detaches the object, after which
/// its setters only change the object.
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract class StyleLayer {
  /// Creates a layer that is not on a map yet.
  ///
  /// The [layout] and [paint] maps take raw style JSON by property name, for
  /// what the typed properties of the subclasses don't cover. A typed property
  /// wins over its raw value.
  StyleLayer({
    required this.id,
    this._minZoom = 0,
    this._maxZoom = 24,
    Expression<bool>? filter,
    bool visible = true,
    Map<String, Object?> layout = const {},
    Map<String, Object?> paint = const {},
  }) : _filter = filter?.toJson(),
       _layout = {...layout},
       _paint = {...paint},
       _extras = const {} {
    if (!visible) _layout['visibility'] = 'none';
  }

  StyleLayer._fromJson(Map<String, Object?> json)
    : id = json['id']! as String,
      _minZoom = (json['minzoom'] as num?)?.toDouble() ?? 0,
      _maxZoom = (json['maxzoom'] as num?)?.toDouble() ?? 24,
      _filter = json['filter'],
      _layout = {...?json['layout'] as Map<String, Object?>?},
      _paint = {...?json['paint'] as Map<String, Object?>?},
      _extras = {
        for (final MapEntry(:key, :value) in json.entries)
          if (!_modeledKeys.contains(key)) key: value,
      };

  /// Reads a layer from the JSON of a style layer. The class follows its
  /// `type`.
  factory StyleLayer.fromJson(Map<String, Object?> json) =>
      _layerFromJson(json);

  static const _modeledKeys = {
    'id',
    'type',
    'source',
    'source-layer',
    'minzoom',
    'maxzoom',
    'filter',
    'layout',
    'paint',
  };

  /// The unique name of the layer.
  final String id;

  /// The type of the layer in the style spec, such as `line`.
  String get type;

  final Map<String, Object?> _layout;
  final Map<String, Object?> _paint;

  /// Top-level members that are not modeled, such as `metadata`.
  final Map<String, Object?> _extras;

  double _minZoom;
  double _maxZoom;
  Object? _filter;

  /// The collection of the map this layer is on.
  StyleLayers? _owner;
  var _wasAttached = false;
  var _warnedDetached = false;

  /// The names of the properties that belong to the layout of this layer.
  Set<String> get _layoutProperties;

  /// The minimum zoom level of the layer. Below it, the layer is hidden.
  ///
  /// Between 0 and 24. Defaults to 0.
  double get minZoom => _minZoom;

  set minZoom(double value) {
    _minZoom = value;
    _sendZoomRange();
  }

  /// The maximum zoom level of the layer. At and above it, the layer is
  /// hidden.
  ///
  /// Between 0 and 24. Defaults to 24.
  double get maxZoom => _maxZoom;

  set maxZoom(double value) {
    _maxZoom = value;
    _sendZoomRange();
  }

  /// The condition on source features. Only features that match it are shown.
  /// Zoom expressions in filters are only evaluated at integer zoom levels,
  /// and the `feature-state` expression is not supported in them.
  ///
  /// Only layers with vector features use it: [CircleStyleLayer],
  /// [FillStyleLayer], [FillExtrusionStyleLayer], [HeatmapStyleLayer],
  /// [LineStyleLayer] and [SymbolStyleLayer].
  Expression<bool>? get filter => switch (_filter) {
    null => null,
    final filter => decodeExpression(filter, decodeBool),
  };

  set filter(Expression<bool>? value) {
    _filter = value?.toJson();
    if (_ownerOrWarn() case final owner?) {
      owner._backend.setFilter(id, _filter);
    }
  }

  /// Whether the layer is shown.
  ///
  /// Defaults to true.
  bool get visible => _layout['visibility'] != 'none';

  set visible(bool value) => setProperty('visibility', value ? null : 'none');

  /// The layout properties as style JSON, by name in the style spec.
  Map<String, Object?> get layout => Map.unmodifiable(_layout);

  /// The paint properties as style JSON, by name in the style spec.
  Map<String, Object?> get paint => Map.unmodifiable(_paint);

  /// The value of the property [name] in the style spec as JSON, or null if it
  /// isn't set. This is the escape hatch for what the typed properties don't
  /// cover. It also reads `filter`, `minzoom` and `maxzoom`.
  Object? getProperty(String name) => switch (name) {
    'filter' => _filter,
    'minzoom' => _minZoom,
    'maxzoom' => _maxZoom,
    _ => _layout[name] ?? _paint[name],
  };

  /// Sets the property [name] in the style spec to the JSON [value]. Null
  /// resets it to its default. This is the escape hatch for what the typed
  /// properties don't cover, such as the transition `line-color-transition`.
  /// It also writes `filter`, `minzoom` and `maxzoom`.
  void setProperty(String name, Object? value) {
    switch (name) {
      case 'filter':
        _filter = value;
        if (_ownerOrWarn() case final owner?) {
          owner._backend.setFilter(id, value);
        }
        return;
      case 'minzoom':
        minZoom = (value as num?)?.toDouble() ?? 0;
        return;
      case 'maxzoom':
        maxZoom = (value as num?)?.toDouble() ?? 24;
        return;
    }
    final isLayout = _isLayout(name);
    final target = isLayout ? _layout : _paint;
    if (value == null) {
      target.remove(name);
    } else {
      target[name] = value;
    }
    if (_ownerOrWarn() case final owner?) {
      if (isLayout) {
        owner._backend.setLayoutProperty(id, name, value);
      } else {
        owner._backend.setPaintProperty(id, name, value);
      }
    }
  }

  /// Moves this layer below the layer [layerId], or to the top if it is null.
  /// See [StyleLayers.move].
  void moveBelow(String? layerId) =>
      _ownerOrWarn()?.move(id, belowLayerId: layerId);

  /// The layer as the JSON of a style layer.
  Map<String, Object?> toJson() => {
    ..._extras,
    'id': id,
    'type': type,
    ..._sourceJson,
    if (_minZoom != 0) 'minzoom': _minZoom,
    if (_maxZoom != 24) 'maxzoom': _maxZoom,
    'filter': ?_filter,
    if (_layout.isNotEmpty) 'layout': {..._layout},
    if (_paint.isNotEmpty) 'paint': {..._paint},
  };

  Map<String, Object?> get _sourceJson => const {};

  bool _isLayout(String name) =>
      name == 'visibility' || _layoutProperties.contains(name);

  void _initProperty(String name, Expression<Object?>? value) {
    if (value == null) return;
    (_isLayout(name) ? _layout : _paint)[name] = encodeProperty(value);
  }

  Expression<T> _property<T>(
    String name,
    LiteralDecoder<T> decode,
    Expression<T> fallback,
  ) => switch (_layout[name] ?? _paint[name]) {
    null => fallback,
    final json => decodeExpression(json, decode),
  };

  Expression<T>? _propertyOrNull<T>(String name, LiteralDecoder<T> decode) =>
      switch (_layout[name] ?? _paint[name]) {
        null => null,
        final json => decodeExpression(json, decode),
      };

  void _setExpression(String name, Expression<Object?>? value) =>
      setProperty(name, value == null ? null : encodeProperty(value));

  void _sendZoomRange() {
    if (_ownerOrWarn() case final owner?) {
      owner._backend.setZoomRange(id, _minZoom, _maxZoom);
    }
  }

  /// The collection this layer is on. A write to a layer that left its map
  /// only changes the object, which is likely a mistake, so debug builds warn
  /// once.
  StyleLayers? _ownerOrWarn() {
    if (_owner == null && _wasAttached && !_warnedDetached) {
      _warnedDetached = true;
      if (kDebugMode) {
        debugPrint(
          'maplibre: the style layer "$id" was removed or its style was '
          'replaced, so changing it no longer updates the map.',
        );
      }
    }
    return _owner;
  }
}

/// A [StyleLayer] that pulls its data from a [Source]. Basically every layer
/// except [BackgroundStyleLayer].
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract class StyleLayerWithSource extends StyleLayer {
  /// Creates a layer on the source [sourceId] that is not on a map yet.
  StyleLayerWithSource({
    required super.id,
    required this.sourceId,
    this.sourceLayerId,
    super.minZoom,
    super.maxZoom,
    super.filter,
    super.visible,
    super.layout,
    super.paint,
  });

  StyleLayerWithSource._fromJson(super.json)
    : sourceId = json['source'] as String? ?? '',
      sourceLayerId = json['source-layer'] as String?,
      super._fromJson();

  /// The id of the source of this layer.
  final String sourceId;

  /// The layer to use from a vector tile source. Required for vector tile
  /// sources; prohibited for all other source types, including GeoJSON sources.
  final String? sourceLayerId;

  @override
  Map<String, Object?> get _sourceJson => {
    'source': sourceId,
    'source-layer': ?sourceLayerId,
  };
}

/// A layer of a type that this version of the package doesn't know. It keeps
/// its JSON, which [StyleLayer.getProperty] and [StyleLayer.setProperty] reach.
///
/// {@category Style}
/// {@subCategory Style Layers}
final class UnknownStyleLayer extends StyleLayer {
  /// Reads a layer from the JSON of a style layer.
  UnknownStyleLayer.fromJson(super.json)
    : type = json['type'] as String? ?? '',
      _source = {
        if (json['source'] case final String source) 'source': source,
        if (json['source-layer'] case final String layer) 'source-layer': layer,
      },
      super._fromJson();

  @override
  final String type;

  final Map<String, Object?> _source;

  @override
  Map<String, Object?> get _sourceJson => _source;

  @override
  Set<String> get _layoutProperties => _layout.keys.toSet();
}
