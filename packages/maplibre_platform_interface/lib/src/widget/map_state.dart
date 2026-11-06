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

  FutureOr<void> _onDragStart(MapEventDragStart event) {
    _layerDrag = null;
    final onDragStart = widget.onDragStart;
    if (!_layersDraggable) return onDragStart?.call(event);
    return _grabFeature(event).then((_) => onDragStart?.call(event));
  }

  /// Finds the feature of a draggable layer that [event] went down on, and
  /// keeps the drag from panning the map if it found one.
  Future<void> _grabFeature(MapEventDragStart event) async {
    final layerIndexes = <String, int>{
      for (final (index, layer) in widget.layers.indexed)
        if (layer.draggable) layer.getLayerId(index): index,
    };
    final List<RenderedFeature> features;
    try {
      features = await queryRenderedFeatures(
        .rect(
          Rect.fromCenter(
            center: event.screenPoint,
            width: _grabSize,
            height: _grabSize,
          ),
        ),
        layerIds: layerIndexes.keys.toList(),
      );
    } on Object catch (error, stack) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'maplibre',
          context: ErrorDescription('while finding the feature to drag'),
        ),
      );
      return;
    }
    if (!mounted) return;
    _LayerDrag? nearest;
    var nearestDistance = double.infinity;
    for (final feature in features) {
      final layerIndex = layerIndexes[feature.layerId];
      final featureIndex =
          feature.properties[LayerManager.featureIndexProperty];
      if (layerIndex == null || featureIndex is! num) continue;
      final index = featureIndex.toInt();
      final layer = widget.layers.elementAtOrNull(layerIndex);
      if (layer == null || !layer.draggable || index >= layer.list.length) {
        continue;
      }
      final geometry = layer.list[index].geometry;
      if (geometry == null) continue;
      final drag = _LayerDrag(layerIndex, index, geometry, event.screenPoint);
      // Of several points, the nearest wins.
      var distance = 0.0;
      if (drag.geometry case Point(:final position)) {
        distance =
            (toScreenLocation(Geographic.from(position)) - event.screenPoint)
                .distance;
      }
      if (distance < nearestDistance) {
        nearest = drag;
        nearestDistance = distance;
      }
    }
    if (nearest == null) return;
    event.preventDefault();
    _layerDrag = nearest;
    layerManager?.startDrag(nearest.layerIndex, nearest.featureIndex);
    _emitLayerDrag(event.screenPoint, (layer) => layer.onDragStart);
  }

  void _onDrag(MapEventDrag event) {
    final moved = _emitLayerDrag(event.screenPoint, (layer) => layer.onDrag);
    if (moved != null) layerManager?.moveDrag(moved);
    widget.onDrag?.call(event);
  }

  void _onDragEnd(MapEventDragEnd event) {
    final moved = _emitLayerDrag(event.screenPoint, (layer) => layer.onDragEnd);
    if (moved != null) layerManager?.moveDrag(moved);
    _layerDrag = null;
    layerManager?.endDrag();
    widget.onDragEnd?.call(event);
  }

  /// Reports the pointer at [screenPoint] to the callback that [callback]
  /// picks of the layer of the current drag, with the dragged geometry,
  /// which it returns.
  Geometry? _emitLayerDrag(
    Offset screenPoint,
    LayerDragCallback? Function(Layer layer) callback,
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
      LayerDragEvent(
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
                onClick: widget.onClick,
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
