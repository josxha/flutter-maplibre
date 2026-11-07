import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

/// The [State] of the [MapLibreMap] widget.
abstract class MapLibreMapState extends State<MapLibreMap>
    implements MapController {
  /// The counter is used to ensure an unique [viewName] for the platform view.
  static int _counter = 0;

  /// A unique name for the platform view.
  final viewName = 'plugins.flutter.io/maplibre${_counter++}';

  /// The [LayerManager] handles the high level markers, polygons,
  /// circles and polylines.
  LayerManager? layerManager;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateRenderingPaused();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    final hit = _topmost(hits, event.screenPoint);
    if (hit == null) return;
    event.preventDefault();
    _layerDrag = _LayerDrag(
      hit.layerIndex,
      hit.featureIndex,
      hit.geometry,
      event.screenPoint,
    );
    layerManager?.startDrag(hit.layerIndex, hit.featureIndex);
    _emitLayerDrag(event.screenPoint, (layer) => layer.onDragStart);
  }

  /// The features of the layers of [MapLibreMap.layers] that [include]
  /// picks in [geometry], or null if the query failed or the map is gone.
  Future<List<_LayerHit>?> _queryLayers(
    QueryGeometry geometry,
    bool Function(Layer layer) include,
    String context,
  ) async {
    final layerIndexes = <String, int>{
      for (final (index, layer) in widget.layers.indexed)
        if (include(layer)) layer.getLayerId(index): index,
    };
    if (layerIndexes.isEmpty) return const [];
    final List<RenderedFeature> features;
    try {
      features = await queryRenderedFeatures(
        geometry,
        layerIds: layerIndexes.keys.toList(),
      );
    } on Object catch (error, stack) {
      _reportError(error, stack, context);
      return null;
    }
    if (!mounted) return null;
    return [
      for (final feature in features)
        if ((
              layerIndexes[feature.layerId],
              feature.properties[LayerManager.featureIndexProperty],
            )
            case (final int layerIndex, final num featureIndex))
          if (widget.layers.elementAtOrNull(layerIndex) case final layer?
              when include(layer) && featureIndex < layer.list.length)
            if (layer.list[featureIndex.toInt()].geometry case final geometry?)
              _LayerHit(layerIndex, featureIndex.toInt(), geometry),
    ];
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
          hit.layerIndex > nearest.layerIndex ||
          (hit.layerIndex == nearest.layerIndex &&
              distance < nearestDistance)) {
        nearest = hit;
        nearestDistance = distance;
      }
    }
    return nearest;
  }

  /// Whether a layer of [MapLibreMap.layers] reports taps on its features.
  bool get _layersClickable =>
      widget.layers.any((layer) => layer.onClick != null);

  void _onClick(MapEventClick event) {
    widget.onClick?.call(event);
    if (_layersClickable) unawaited(_clickFeature(event));
  }

  /// Reports a tap to [Layer.onClick] of the topmost feature under it, or,
  /// if none is right under it, next to it.
  Future<void> _clickFeature(MapEventClick event) async {
    bool clickable(Layer layer) => layer.onClick != null;
    const context = 'while finding the clicked feature';
    var hits = await _queryLayers(
      .point(event.screenPoint),
      clickable,
      context,
    );
    if (hits != null && hits.isEmpty) {
      hits = await _queryLayers(
        .rect(
          Rect.fromCenter(
            center: event.screenPoint,
            width: _grabSize,
            height: _grabSize,
          ),
        ),
        clickable,
        context,
      );
    }
    if (hits == null) return;
    final hit = _topmost(hits, event.screenPoint);
    if (hit == null) return;
    _emitLayerEvent(
      hit,
      event,
      widget.layers.elementAtOrNull(hit.layerIndex)?.onClick,
    );
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

  /// The feature under the mouse, by layer index.
  final _hovered = <int, _LayerHit>{};

  /// The last mouse position over the map.
  MapEventPointerMove? _hoverInput;

  /// Whether a query for the features under the mouse runs.
  var _hoverQuerying = false;

  /// Counts the times the mouse left the map, so that a query that started
  /// before is dropped.
  var _hoverGeneration = 0;

  void _onPointerMove(MapEventPointerMove event) {
    widget.onPointerMove?.call(event);
    if (!_layersHoverable && _hovered.isEmpty) return;
    _hoverInput = event;
    unawaited(_hover());
  }

  void _onPointerLeave(MapEventPointerLeave event) {
    widget.onPointerLeave?.call(event);
    _hoverGeneration++;
    final input = _hoverInput;
    _hoverInput = null;
    if (input != null) _updateHovered(const [], input);
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
  void _updateHovered(List<_LayerHit> hits, MapEventUserInput input) {
    final now = <int, _LayerHit>{};
    for (final hit in hits) {
      // Rendered features come topmost first.
      now.putIfAbsent(hit.layerIndex, () => hit);
    }
    for (final MapEntry(key: layerIndex, value: hit) in _hovered.entries) {
      if (now[layerIndex]?.featureIndex == hit.featureIndex) continue;
      _emitLayerEvent(
        hit,
        input,
        widget.layers.elementAtOrNull(layerIndex)?.onLeave,
      );
    }
    for (final MapEntry(key: layerIndex, value: hit) in now.entries) {
      if (_hovered[layerIndex]?.featureIndex == hit.featureIndex) continue;
      _emitLayerEvent(
        hit,
        input,
        widget.layers.elementAtOrNull(layerIndex)?.onEnter,
      );
    }
    _hovered
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
    if (moved != null) layerManager?.moveDrag(moved);
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
    if (moved != null) layerManager?.moveDrag(moved);
    layerManager?.endDrag();
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
    final layer = widget.layers.elementAtOrNull(drag.layerIndex);
    if (layer == null ||
        !layer.draggable ||
        drag.featureIndex >= layer.list.length) {
      return null;
    }
    final delta = screenPoint - drag.start;
    final geometry = _moved(drag.geometry, delta);
    final (point, target) = switch (geometry) {
      Point(:final position) => (
        Geographic.from(position),
        toScreenLocation(Geographic.from(position)),
      ),
      _ => (toLngLat(screenPoint), screenPoint),
    };
    callback(layer)?.call(
      LayerFeatureEvent(
        index: drag.featureIndex,
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

  @override
  Widget build(BuildContext context) {
    final gestureCamera = this.gestureCamera;
    final platformWidget = buildPlatformWidget(context);
    final widget = this.widget;
    final layersDraggable = _layersDraggable;
    final layersClickable = _layersClickable;
    final layersHoverable = _layersHoverable;
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
                onClick: layersClickable || widget.onClick != null
                    ? _onClick
                    : null,
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
                onPointerMove: layersHoverable || widget.onPointerMove != null
                    ? _onPointerMove
                    : null,
                onPointerLeave: layersHoverable || widget.onPointerLeave != null
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

/// A feature of [MapLibreMap.layers] that a query found.
class _LayerHit {
  const _LayerHit(this.layerIndex, this.featureIndex, this.geometry);

  final int layerIndex;
  final int featureIndex;
  final Geometry geometry;
}

/// A feature of [MapLibreMap.layers] that a drag moves.
class _LayerDrag {
  _LayerDrag(this.layerIndex, this.featureIndex, this.geometry, this.start);

  final int layerIndex;
  final int featureIndex;

  /// The geometry of the feature where the drag started.
  final Geometry geometry;

  /// Where the drag started, in logical pixels of the map.
  final Offset start;
}
