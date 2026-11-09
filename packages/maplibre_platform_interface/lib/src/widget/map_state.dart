import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/layer/annotation_manager.dart';
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

/// The [State] of the [MapLibreMap] widget.
abstract class MapLibreMapState extends State<MapLibreMap>
    implements MapController {
  /// The counter is used to ensure an unique [viewName] for the platform view.
  static int _counter = 0;

  /// A unique name for the platform view.
  final viewName = 'plugins.flutter.io/maplibre${_counter++}';

  /// Keeps the layers of [MapLibreMap.layers] on every style of the map.
  late final AnnotationManager _annotations;

  /// Adds the layers of [MapLibreMap.layers] to [style], which just loaded.
  /// Platforms call it after [MapLibreMap.onStyleLoaded].
  @protected
  void attachAnnotations(StyleController style) => _annotations.attach(style);

  /// Forgets the style of the layers of [MapLibreMap.layers], which is about
  /// to be replaced. Platforms call it.
  @protected
  void detachAnnotations() => _annotations.detach();

  /// The id of the style layer and source of [layer] of [MapLibreMap.layers],
  /// or null if it is not in the list.
  @visibleForTesting
  String? annotationLayerId(Layer layer) {
    for (final entry in _annotations.entries) {
      if (identical(entry.layer, layer)) return entry.id;
    }
    return null;
  }

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  CameraPosition? camera;

  /// Set to true once the map is initialized and a [MapController.camera]
  /// is set.
  bool isInitialized = false;

  @override
  bool get isRenderingPaused => _renderingPaused;
  var _renderingPaused = false;

  /// Stops or resumes rendering, see [MapLibreMap.paused]. Called whenever
  /// [isRenderingPaused] changes, including when the map starts out paused.
  /// The map keeps its style, camera and tiles meanwhile.
  @protected
  void setRenderingPaused({required bool paused}) {}

  /// Whether the platform stops rendering a paused map. Where it does not,
  /// [isRenderingPaused] stays false.
  @protected
  bool get canPauseRendering => true;

  @override
  void initState() {
    super.initState();
    _annotations = AnnotationManager(widget.layers);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateRenderingPaused();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    _annotations.update(widget.layers);
    if (oldWidget.paused != widget.paused) _updateRenderingPaused();
  }

  /// Pauses the map while [MapLibreMap.paused] is set, while a [Visibility]
  /// or an [IndexedStack] hides it, or while [TickerMode] is disabled.
  void _updateRenderingPaused() {
    final paused =
        canPauseRendering &&
        (widget.paused ||
            !TickerMode.valuesOf(context).enabled ||
            !Visibility.of(context));
    if (paused == _renderingPaused) return;
    _renderingPaused = paused;
    setRenderingPaused(paused: paused);
    // This runs while the tree builds, where listeners must not rebuild.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _renderingPaused == paused) {
        widget.onRenderingChanged?.call(
          MapEventRenderingChanged(paused: paused),
        );
      }
    });
  }

  /// Applies the camera changes of the map gestures that
  /// [MapGestureDetector] recognizes over [buildPlatformWidget], or null if
  /// the platform handles gestures itself.
  GestureCameraSink? get gestureCamera => null;

  /// The feature of [MapLibreMap.layers] that the current drag moves.
  _LayerDrag? _layerDrag;

  /// Whether a layer of [MapLibreMap.layers] has draggable features.
  bool get _layersDraggable => widget.layers.any((layer) => layer.draggable);

  /// Counts the drags, so that a feature query of a drag that ended or was
  /// followed by another one is dropped.
  var _dragGeneration = 0;

  /// The search of the current drag for a feature to move, until it and the
  /// start callbacks complete.
  Future<void>? _dragStarting;

  /// The last move of the current drag while it starts, which is reported
  /// once it started.
  MapEventDrag? _heldDrag;

  FutureOr<void> _onDragStart(MapEventDragStart event) {
    _layerDrag = null;
    _heldDrag = null;
    final generation = ++_dragGeneration;
    final onDragStart = widget.onDragStart;
    if (!_layersDraggable) return onDragStart?.call(event);
    final starting = _grabFeature(
      event,
      generation,
    ).then((_) => onDragStart?.call(event));
    _dragStarting = starting;
    unawaited(
      _afterStart(starting, () {
        if (!identical(_dragStarting, starting)) return;
        _dragStarting = null;
        final held = _heldDrag;
        _heldDrag = null;
        if (held != null && mounted) _onDrag(held);
      }),
    );
    // The gesture detector reports the errors of the start.
    return starting;
  }

  /// Runs [callback] once [starting] completes. Reports the errors of
  /// [callback], but not those of [starting], which the gesture detector
  /// reports.
  Future<void> _afterStart(
    Future<void> starting,
    void Function() callback,
  ) async {
    try {
      await starting;
    } on Object catch (_) {}
    try {
      callback();
    } on Object catch (error, stack) {
      _reportError(error, stack, 'while handling a drag');
    }
  }

  void _reportError(Object error, StackTrace stack, String context) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'maplibre',
        context: ErrorDescription(context),
      ),
    );
  }

  /// Finds the feature of a draggable layer that [event] went down on, and
  /// keeps the drag from panning the map if it found one.
  Future<void> _grabFeature(MapEventDragStart event, int generation) async {
    final hits = await _queryLayers(
      .rect(
        Rect.fromCenter(
          center: event.screenPoint,
          width: _grabSize,
          height: _grabSize,
        ),
      ),
      (layer) => layer.draggable,
      'while finding the feature to drag',
    );
    if (hits == null || generation != _dragGeneration) return;
    final hit = _topmost(hits.layers, event.screenPoint);
    if (hit == null) return;
    event.preventDefault();
    _layerDrag = _LayerDrag(hit, event.screenPoint);
    _annotations.startDrag(hit.entry, hit.featureIndex);
    _emitLayerDrag(event.screenPoint, (layer) => layer.onDragStart);
  }

  /// The features in [geometry] of the layers of [MapLibreMap.layers] that
  /// [include] picks and of the style layers that [includeStyle] picks, or
  /// null if the query failed or the map is gone.
  Future<_Hits?> _queryLayers(
    QueryGeometry geometry,
    bool Function(Layer layer) include,
    String context, {
    bool Function(StyleLayer layer)? includeStyle,
  }) async {
    final entries = <String, AnnotationEntry>{
      for (final entry in _annotations.entries)
        if (include(entry.layer)) entry.id: entry,
    };
    final styleLayerIds = {
      if (includeStyle != null)
        for (final layer in style?.layers ?? const <StyleLayer>[])
          if (includeStyle(layer) && !_annotations.owns(layer.id)) layer.id,
    };
    if (entries.isEmpty && styleLayerIds.isEmpty) return const _Hits();
    final List<RenderedFeature> features;
    try {
      features = await queryRenderedFeatures(
        geometry,
        layerIds: [...entries.keys, ...styleLayerIds],
      );
    } on Object catch (error, stack) {
      _reportError(error, stack, context);
      return null;
    }
    if (!mounted) return null;
    return _Hits(
      layers: _layerHits(features, entries, include),
      styleLayers: [
        for (final feature in features)
          if (styleLayerIds.contains(feature.layerId)) feature,
      ],
    );
  }

  /// The features of [features] of the layers of [MapLibreMap.layers] by
  /// the ids of their style layers in [entries].
  List<_LayerHit> _layerHits(
    List<RenderedFeature> features,
    Map<String, AnnotationEntry> entries,
    bool Function(Layer layer) include,
  ) {
    // The draw order of the style layers, which anchors make differ from
    // the order of the list.
    final order = <String, int>{
      for (final (index, layer)
          in (style?.layers ?? const <StyleLayer>[]).indexed)
        layer.id: index,
    };
    final hits = <_LayerHit>[];
    for (final feature in features) {
      final entry = entries[feature.layerId];
      final featureIndex =
          feature.properties[AnnotationManager.featureIndexProperty];
      if (entry == null || !entry.mounted || featureIndex is! num) continue;
      final layer = entry.layer;
      if (!include(layer) || featureIndex >= layer.list.length) continue;
      final listFeature = layer.list[featureIndex.toInt()];
      final geometry = listFeature.geometry;
      if (geometry == null) continue;
      hits.add(
        _LayerHit(
          entry,
          order[entry.id] ?? _annotations.entries.indexOf(entry),
          featureIndex.toInt(),
          listFeature,
          geometry,
        ),
      );
    }
    return hits;
  }

  /// Of [hits], the one of the topmost layer, and of its points the nearest
  /// to [center].
  _LayerHit? _topmost(List<_LayerHit> hits, Offset center) {
    _LayerHit? nearest;
    var nearestDistance = double.infinity;
    for (final hit in hits) {
      var distance = 0.0;
      if (hit.geometry case Point(:final position)) {
        distance =
            (toScreenLocation(Geographic.from(position)) - center).distance;
      }
      if (nearest == null ||
          hit.drawIndex > nearest.drawIndex ||
          (hit.drawIndex == nearest.drawIndex && distance < nearestDistance)) {
        nearest = hit;
        nearestDistance = distance;
      }
    }
    return nearest;
  }

  /// Whether a layer of [MapLibreMap.layers] reports taps on its features.
  bool get _layersClickable =>
      widget.layers.any((layer) => layer.onClick != null);

  /// Whether a layer of [StyleController.layers] reports taps on its
  /// features.
  bool get _styleLayersClickable => style?.layers.any(_styleClickable) ?? false;

  static bool _styleClickable(StyleLayer layer) => layer.onClick != null;

  void _onClick(MapEventClick event) {
    widget.onClick?.call(event);
    if (_layersClickable || _styleLayersClickable) {
      unawaited(_clickFeature(event));
    }
  }

  /// Reports a tap to [Layer.onClick] of the topmost feature under it, or,
  /// if none is right under it, next to it, and to [StyleLayer.onClick] of
  /// every style layer with a feature right under it.
  Future<void> _clickFeature(MapEventClick event) async {
    bool clickable(Layer layer) => layer.onClick != null;
    const context = 'while finding the clicked feature';
    final hits = await _queryLayers(
      .point(event.screenPoint),
      clickable,
      context,
      includeStyle: _styleClickable,
    );
    if (hits == null) return;
    var layerHits = hits.layers;
    // Only annotation layers take taps next to their features, like drags.
    if (layerHits.isEmpty && _layersClickable) {
      layerHits =
          (await _queryLayers(
            .rect(
              Rect.fromCenter(
                center: event.screenPoint,
                width: _grabSize,
                height: _grabSize,
              ),
            ),
            clickable,
            context,
          ))?.layers ??
          const [];
    }
    if (_topmost(layerHits, event.screenPoint) case final hit?) {
      _emitLayerEvent(hit, event, _layerOf(hit.entry)?.onClick);
    }
    for (final (layer, feature) in _topmostPerStyleLayer(
      hits.styleLayers,
      _styleClickable,
    )) {
      _emitStyleLayerEvent(layer, layer.onClick, feature, event);
    }
  }

  /// The topmost feature of [features] of each style layer that [include]
  /// picks.
  List<(StyleLayer, RenderedFeature)> _topmostPerStyleLayer(
    List<RenderedFeature> features,
    bool Function(StyleLayer layer) include,
  ) {
    final topmost = <String, (StyleLayer, RenderedFeature)>{};
    for (final feature in features) {
      final layerId = feature.layerId;
      if (layerId == null || topmost.containsKey(layerId)) continue;
      if (style?.layers[layerId] case final layer? when include(layer)) {
        // Rendered features come topmost first.
        topmost[layerId] = (layer, feature);
      }
    }
    return topmost.values.toList();
  }

  void _emitStyleLayerEvent(
    StyleLayer layer,
    StyleLayerFeatureCallback? callback,
    RenderedFeature feature,
    MapEventUserInput input,
  ) {
    // Removing the layer or loading another style ends its calls.
    if (callback == null || !identical(style?.layers[layer.id], layer)) return;
    try {
      callback(
        StyleLayerFeatureEvent(
          feature: feature,
          point: input.point,
          screenPoint: input.screenPoint,
        ),
      );
    } on Object catch (error, stack) {
      _reportError(error, stack, 'while handling a style layer event');
    }
  }

  void _emitLayerEvent(
    _LayerHit hit,
    MapEventUserInput input,
    LayerFeatureCallback? callback,
  ) {
    if (callback == null) return;
    try {
      callback(
        LayerFeatureEvent(
          index: hit.featureIndex,
          feature: hit.feature,
          geometry: hit.geometry,
          point: input.point,
          screenPoint: input.screenPoint,
        ),
      );
    } on Object catch (error, stack) {
      _reportError(error, stack, 'while handling a layer event');
    }
  }

  /// Whether a layer of [MapLibreMap.layers] reports the mouse over its
  /// features.
  bool get _layersHoverable => widget.layers.any(_hoverable);

  static bool _hoverable(Layer layer) =>
      layer.onEnter != null || layer.onLeave != null;

  /// Whether a layer of [StyleController.layers] reports the mouse over its
  /// features.
  bool get _styleLayersHoverable => style?.layers.any(_styleHoverable) ?? false;

  static bool _styleHoverable(StyleLayer layer) =>
      layer.onEnter != null || layer.onLeave != null;

  /// The layer of [entry] while it is in [MapLibreMap.layers].
  static Layer? _layerOf(AnnotationEntry entry) =>
      entry.mounted ? entry.layer : null;

  /// The feature under the mouse, by layer.
  final _hovered = <AnnotationEntry, _LayerHit>{};

  /// The feature under the mouse, by style layer id.
  final _hoveredStyle = <String, (StyleLayer, RenderedFeature)>{};

  /// The last mouse position over the map.
  MapEventPointerMove? _hoverInput;

  /// Whether a query for the features under the mouse runs.
  var _hoverQuerying = false;

  /// Counts the times the mouse left the map, so that a query that started
  /// before is dropped.
  var _hoverGeneration = 0;

  void _onPointerMove(MapEventPointerMove event) {
    widget.onPointerMove?.call(event);
    if (!_layersHoverable &&
        !_styleLayersHoverable &&
        _hovered.isEmpty &&
        _hoveredStyle.isEmpty) {
      return;
    }
    _hoverInput = event;
    unawaited(_hover());
  }

  void _onPointerLeave(MapEventPointerLeave event) {
    widget.onPointerLeave?.call(event);
    _hoverGeneration++;
    final input = _hoverInput;
    _hoverInput = null;
    if (input != null) _updateHovered(const _Hits(), input);
  }

  /// Queries the features under the mouse, coalescing moves while a query
  /// runs.
  Future<void> _hover() async {
    if (_hoverQuerying) return;
    _hoverQuerying = true;
    try {
      MapEventPointerMove? queried;
      while (_hoverInput != null && !identical(_hoverInput, queried)) {
        final input = queried = _hoverInput!;
        final generation = _hoverGeneration;
        final hits = await _queryLayers(
          .point(input.screenPoint),
          _hoverable,
          'while finding the hovered feature',
          includeStyle: _styleHoverable,
        );
        if (hits == null || generation != _hoverGeneration) continue;
        _updateHovered(hits, input);
      }
    } finally {
      _hoverQuerying = false;
    }
  }

  /// Reports the features of [hits] that the mouse entered and the ones it
  /// left. Per layer, the topmost feature counts.
  void _updateHovered(_Hits hits, MapEventUserInput input) {
    _updateHoveredStyle(hits.styleLayers, input);
    final now = <AnnotationEntry, _LayerHit>{};
    for (final hit in hits.layers) {
      // Rendered features come topmost first.
      now.putIfAbsent(hit.entry, () => hit);
    }
    for (final MapEntry(key: entry, value: hit) in _hovered.entries) {
      if (now[entry]?.featureIndex == hit.featureIndex) continue;
      _emitLayerEvent(hit, input, _layerOf(entry)?.onLeave);
    }
    for (final MapEntry(key: entry, value: hit) in now.entries) {
      if (_hovered[entry]?.featureIndex == hit.featureIndex) continue;
      _emitLayerEvent(hit, input, _layerOf(entry)?.onEnter);
    }
    _hovered
      ..clear()
      ..addAll(now);
  }

  /// Reports the features of style layers in [features] that the mouse
  /// entered and the ones it left. Features without an id stand for their
  /// whole layer.
  void _updateHoveredStyle(
    List<RenderedFeature> features,
    MapEventUserInput input,
  ) {
    final now = {
      for (final entry in _topmostPerStyleLayer(features, _styleHoverable))
        entry.$1.id: entry,
    };
    bool same(
      (StyleLayer, RenderedFeature)? a,
      (StyleLayer, RenderedFeature) b,
    ) => a != null && identical(a.$1, b.$1) && a.$2.id == b.$2.id;
    for (final entry in _hoveredStyle.entries) {
      if (same(now[entry.key], entry.value)) continue;
      final (layer, feature) = entry.value;
      _emitStyleLayerEvent(layer, layer.onLeave, feature, input);
    }
    for (final entry in now.entries) {
      if (same(_hoveredStyle[entry.key], entry.value)) continue;
      final (layer, feature) = entry.value;
      _emitStyleLayerEvent(layer, layer.onEnter, feature, input);
    }
    _hoveredStyle
      ..clear()
      ..addAll(now);
  }

  void _onDrag(MapEventDrag event) {
    // Moves come after the start callbacks.
    if (_dragStarting != null) {
      _heldDrag = event;
      return;
    }
    final moved = _emitLayerDrag(event.screenPoint, (layer) => layer.onDrag);
    if (moved != null) _annotations.moveDrag(moved);
    widget.onDrag?.call(event);
  }

  void _onDragEnd(MapEventDragEnd event) {
    // A drag that ends while it looks for its feature ends once it found it,
    // so that the callbacks come in order.
    final starting = _dragStarting;
    if (starting == null) return _endLayerDrag(event);
    final generation = _dragGeneration;
    unawaited(
      _afterStart(starting, () {
        if (!mounted) return;
        if (generation == _dragGeneration) return _endLayerDrag(event);
        widget.onDragEnd?.call(event);
      }),
    );
  }

  void _endLayerDrag(MapEventDragEnd event) {
    final moved = _emitLayerDrag(event.screenPoint, (layer) => layer.onDragEnd);
    if (moved != null) _annotations.moveDrag(moved);
    _annotations.endDrag();
    _layerDrag = null;
    widget.onDragEnd?.call(event);
  }

  /// Reports the pointer at [screenPoint] to the callback that [callback]
  /// picks of the layer of the current drag, with the dragged geometry,
  /// which it returns.
  Geometry? _emitLayerDrag(
    Offset screenPoint,
    LayerFeatureCallback? Function(Layer layer) callback,
  ) {
    final drag = _layerDrag;
    if (drag == null || !isInitialized) return null;
    final hit = drag.hit;
    final layer = _layerOf(hit.entry);
    if (layer == null ||
        !layer.draggable ||
        hit.featureIndex >= layer.list.length) {
      return null;
    }
    final delta = screenPoint - drag.start;
    final geometry = _moved(hit.geometry, delta);
    final (point, target) = switch (geometry) {
      Point(:final position) => (
        Geographic.from(position),
        toScreenLocation(Geographic.from(position)),
      ),
      _ => (toLngLat(screenPoint), screenPoint),
    };
    callback(layer)?.call(
      LayerFeatureEvent(
        index: hit.featureIndex,
        feature: hit.feature,
        geometry: geometry,
        point: point,
        screenPoint: target,
      ),
    );
    return geometry;
  }

  /// [geometry] moved by [delta] on screen. Only the geometries of the
  /// annotation layers move.
  Geometry _moved(Geometry geometry, Offset delta) {
    Geographic move(Position position) =>
        toLngLat(toScreenLocation(Geographic.from(position)) + delta);
    List<Geographic> moveAll(PositionSeries series) => [
      for (final position in series.positions) move(position),
    ];
    return switch (geometry) {
      Point(:final position) => Point(move(position)),
      LineString(:final chain) => LineString.from(moveAll(chain)),
      Polygon(:final rings) => Polygon.from([
        for (final ring in rings) moveAll(ring),
      ]),
      _ => geometry,
    };
  }

  /// The size of the map's last layout, to report changes with
  /// [MapLibreMap.onResize].
  Size? _size;

  void _onLayout(BoxConstraints constraints) {
    final size = constraints.biggest;
    if (!size.isFinite || size == _size) return;
    final resized = _size != null;
    _size = size;
    if (!resized) return;
    // Layout runs while the tree builds, where listeners must not rebuild.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _size == size) {
        widget.onResize?.call(MapEventResize(size: size));
      }
    });
  }

  /// The style layers whose callbacks [build] follows.
  StyleLayers? _styleLayers;

  void _listenToStyleLayers() {
    final layers = style?.layers;
    if (identical(layers, _styleLayers)) return;
    _styleLayers?.callbacksChanged.removeListener(_onStyleCallbacksChanged);
    _styleLayers = layers;
    layers?.callbacksChanged.addListener(_onStyleCallbacksChanged);
  }

  /// Rebuilds, so that the map listens for taps and the mouse while a style
  /// layer reports them.
  void _onStyleCallbacksChanged() {
    if (!mounted) return;
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      // The callbacks changed while the tree builds.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _styleLayers?.callbacksChanged.removeListener(_onStyleCallbacksChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gestureCamera = this.gestureCamera;
    final platformWidget = buildPlatformWidget(context);
    final widget = this.widget;
    final layersDraggable = _layersDraggable;
    // Only the gesture detector reports taps and the mouse to style layers.
    if (gestureCamera != null) _listenToStyleLayers();
    final clicks =
        gestureCamera != null &&
        (_layersClickable || _styleLayersClickable || widget.onClick != null);
    // Hovered features are left once the last hoverable layer is gone.
    final hovers =
        gestureCamera != null &&
        (_layersHoverable ||
            _styleLayersHoverable ||
            _hovered.isNotEmpty ||
            _hoveredStyle.isNotEmpty);
    return LayoutBuilder(
      builder: (context, constraints) {
        _onLayout(constraints);
        return Stack(
          children: [
            if (gestureCamera == null)
              platformWidget
            else
              MapGestureDetector(
                movements: options.movements,
                gestures: options.gestures,
                camera: gestureCamera,
                toLngLat: (point) => isInitialized ? toLngLat(point) : null,
                onClick: clicks ? _onClick : null,
                onDoubleClick: widget.onDoubleClick,
                onSecondaryClick: widget.onSecondaryClick,
                onLongClick: widget.onLongClick,
                onDragStart: layersDraggable || widget.onDragStart != null
                    ? _onDragStart
                    : null,
                onDrag: layersDraggable || widget.onDrag != null
                    ? _onDrag
                    : null,
                onDragEnd: layersDraggable || widget.onDragEnd != null
                    ? _onDragEnd
                    : null,
                onPointerMove: hovers || widget.onPointerMove != null
                    ? _onPointerMove
                    : null,
                onPointerLeave: hovers || widget.onPointerLeave != null
                    ? _onPointerLeave
                    : null,
                child: platformWidget,
              ),
            MapLibreInheritedModel(
              mapController: this,
              cameraPosition: camera,
              child: isInitialized
                  ? Stack(children: widget.children)
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  /// Build the platform specific widget.
  Widget buildPlatformWidget(BuildContext context);
}

/// Logical pixels of the square around a drag's start that it grabs a
/// feature of a draggable layer in, so that small features can be grabbed by
/// touch.
const _grabSize = 24.0;

/// What a query found.
class _Hits {
  const _Hits({this.layers = const [], this.styleLayers = const []});

  /// The features of [MapLibreMap.layers].
  final List<_LayerHit> layers;

  /// The features of style layers, topmost first.
  final List<RenderedFeature> styleLayers;
}

/// A feature of [MapLibreMap.layers] that a query found.
class _LayerHit {
  const _LayerHit(
    this.entry,
    this.drawIndex,
    this.featureIndex,
    this.feature,
    this.geometry,
  );

  /// The layer, which keeps its identity while the list changes.
  final AnnotationEntry entry;

  /// The position of the layer's style layer, from the bottom.
  final int drawIndex;

  final int featureIndex;
  final Feature feature;

  /// The geometry of the feature, where a drag starts.
  final Geometry geometry;
}

/// A feature of [MapLibreMap.layers] that a drag moves.
class _LayerDrag {
  _LayerDrag(this.hit, this.start);

  /// The dragged feature, with its geometry where the drag started.
  final _LayerHit hit;

  /// Where the drag started, in logical pixels of the map.
  final Offset start;
}
