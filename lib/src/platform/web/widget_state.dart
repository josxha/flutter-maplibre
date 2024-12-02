import 'dart:async';
import 'dart:js_interop';
import 'dart:math';
import 'dart:ui_web';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/web/extensions.dart';
import 'package:maplibre/src/platform/web/interop/interop.dart' as interop;
import 'package:maplibre/src/platform/web/interop/json.dart';
import 'package:web/web.dart';

part 'style_controller.dart';

/// The web specific implementation of the [MapLibreMap] widget.
final class MapLibreMapStateWeb extends MapLibreMapState {
  late HTMLDivElement _htmlElement;
  late interop.JsMap _map;
  Completer<interop.MapLibreEvent>? _movementCompleter;
  bool _nextGestureCausedByController = false;
  LayerManager? _layerManager;

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  StyleControllerWeb? style;

  @override
  void initState() {
    platformViewRegistry.registerViewFactory(
      viewName,
      (int viewId, [dynamic params]) {
        _htmlElement = HTMLDivElement()
          ..style.padding = '0'
          ..style.margin = '0'
          ..style.height = '100%'
          ..style.width = '100%';

        _map = interop.JsMap(
          interop.MapOptions(
            container: _htmlElement,
            style: options.initStyle,
            zoom: options.initZoom,
            center: options.initCenter?.toLngLat(),
            bearing: options.initBearing,
            pitch: options.initPitch,
            attributionControl: false,
          ),
        );

        document.body?.appendChild(_htmlElement);
        // Invoke the onMapCreated callback async to avoid getting it called
        // during the widget build.
        Future.delayed(Duration.zero, () {
          widget.onEvent?.call(MapEventMapCreated(mapController: this));
          widget.onMapCreated?.call(this);
          setState(() => isInitialized = true);
        });
        _resizeMap();

        // set options
        _map.setMinZoom(options.minZoom);
        _map.setMaxZoom(options.maxZoom);
        _map.setMinPitch(options.minPitch);
        _map.setMaxPitch(options.maxPitch);
        _map.setMaxBounds(options.maxBounds?.toJsLngLatBounds());
        _updateGestures(options.gestures);

        // add callbacks
        _map.on(
          interop.MapEventType.load,
          (interop.MapMouseEvent event) {
            final styleCtrl = StyleControllerWeb(_map);
            widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
            widget.onStyleLoaded?.call(styleCtrl);
            _layerManager = LayerManager(styleCtrl, widget.layers);
            // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
            setState(() {});
          }.toJS,
        );
        _map.on(
          interop.MapEventType.click,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventClick(point: point));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.dblclick,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventDoubleClick(point: point));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.contextmenu,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventSecondaryClick(point: point));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.idle,
          (interop.MapMouseEvent event) {
            widget.onEvent?.call(const MapEventIdle());
          }.toJS,
        );
        _map.on(
          interop.MapEventType.moveStart,
          (interop.MapLibreEvent event) {
            final CameraChangeReason reason;
            if (_nextGestureCausedByController) {
              _nextGestureCausedByController = false;
              reason = CameraChangeReason.developerAnimation;
            } else if (event.originalEvent != null) {
              reason = CameraChangeReason.apiGesture;
            } else {
              reason = CameraChangeReason.apiAnimation;
            }
            widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.move,
          (interop.MapLibreEvent event) {
            final mapCamera = MapCamera(
              center: _map.getCenter().toPosition(),
              zoom: _map.getZoom().toDouble(),
              pitch: _map.getPitch().toDouble(),
              bearing: _map.getBearing().toDouble(),
            );
            setState(() => camera = mapCamera);
            widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.moveEnd,
          (interop.MapLibreEvent event) {
            widget.onEvent?.call(const MapEventCameraIdle());
            if (!(_movementCompleter?.isCompleted ?? true)) {
              _movementCompleter?.complete(event);
            }
          }.toJS,
        );

        return _htmlElement;
      },
    );
    super.initState();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) =>
      HtmlElementView(viewType: viewName);

  void _resizeMap() {
    final jsContainer = _map.getContainer();
    final jsCanvas = _map.getCanvas();
    final matchWidth = jsCanvas.clientWidth == jsContainer.clientWidth;
    final matchHeight = jsCanvas.clientHeight == jsContainer.clientHeight;
    if (matchWidth && matchHeight) return;
    _map.resize();
  }

  @override
  void dispose() {
    _map.remove();
    _htmlElement.remove();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    if (options.minZoom != oldWidget.options.minZoom) {
      _map.setMinZoom(options.minZoom);
    }
    if (options.maxZoom != oldWidget.options.maxZoom) {
      _map.setMaxZoom(options.maxZoom);
    }
    if (options.minPitch != oldWidget.options.minPitch) {
      _map.setMinPitch(options.minPitch);
    }
    if (options.maxPitch != oldWidget.options.maxPitch) {
      _map.setMaxPitch(options.maxPitch);
    }
    if (options.maxBounds != oldWidget.options.maxBounds) {
      _map.setMaxBounds(options.maxBounds?.toJsLngLatBounds());
    }
    if (options.gestures != oldWidget.options.gestures) {
      _updateGestures(options.gestures);
    }
    _layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Position toLngLatSync(Offset screenLocation) =>
      _map.unproject(screenLocation.toJsPoint()).toPosition();

  @override
  List<Position> toLngLatsSync(List<Offset> screenLocations) => screenLocations
      .map((offset) => _map.unproject(offset.toJsPoint()).toPosition())
      .toList(growable: false);

  @override
  Offset toScreenLocationSync(Position lngLat) =>
      _map.project(lngLat.toLngLat()).toOffset();

  @override
  List<Offset> toScreenLocationsSync(List<Position> lngLats) => lngLats
      .map((lngLat) => _map.project(lngLat.toLngLat()).toOffset())
      .toList(growable: false);

  @override
  Future<Position> toLngLat(Offset screenLocation) async =>
      toLngLatSync(screenLocation);

  @override
  Future<Offset> toScreenLocation(Position lngLat) async =>
      toScreenLocationSync(lngLat);

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) async =>
      toLngLatsSync(screenLocations);

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) async =>
      toScreenLocationsSync(lngLats);

  @override
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    _nextGestureCausedByController = true;
    _map.jumpTo(
      interop.JumpToOptions(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      ),
    );
  }

  @override
  Future<void> animateCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) async {
    final destination = center?.toLngLat();
    _nextGestureCausedByController = true;
    _map.flyTo(
      interop.FlyToOptions(
        center: destination,
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
        speed: webSpeed,
        maxDuration: webMaxDuration?.inMilliseconds,
      ),
    );
    final completer = _movementCompleter = Completer<interop.MapLibreEvent>();
    final _ = await completer.future;
    _movementCompleter = null;

    // check if the targeted values were reached or if the flight was cancelled
    final newCenter = _map.getCenter();
    bool reachedCenter;
    if (destination == null) {
      reachedCenter = true;
    } else {
      final reachedLng = (destination.lng - newCenter.lng).abs() < 0.0000001;
      final reachedLat = (destination.lat - newCenter.lat).abs() < 0.0000001;
      reachedCenter = reachedLat && reachedLng;
    }
    final reachedZoom = zoom == null || zoom == _map.getZoom();
    final reachedBearing = bearing == null || bearing == _map.getBearing();
    final reachedPitch = pitch == null || pitch == _map.getPitch();

    if (reachedCenter && reachedZoom && reachedBearing && reachedPitch) return;

    throw PlatformException(
      code: 'CancellationException',
      message: 'Animation cancelled.',
    );
  }

  @override
  Future<void> fitBounds({
    required LngLatBounds bounds,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
    Offset offset = Offset.zero,
    double webMaxZoom = double.maxFinite,
    bool webLinear = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) async =>
      _map.fitBounds(
        bounds.toJsLngLatBounds(),
        interop.FitBoundsOptions(
          offset: offset.toJsPoint(),
          maxZoom: webMaxZoom,
          linear: webLinear,
          maxDuration: webMaxDuration?.inMilliseconds,
          padding: padding.toPaddingOptions(),
          speed: webSpeed,
          pitch: pitch,
          bearing: bearing,
        ),
      );

  @override
  MapCamera getCamera() => MapCamera(
        center: _map.getCenter().toPosition(),
        zoom: _map.getZoom().toDouble(),
        pitch: _map.getPitch().toDouble(),
        bearing: _map.getBearing().toDouble(),
      );

  /// https://wiki.openstreetmap.org/wiki/Zoom_levels
  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      getMetersPerPixelAtLatitudeSync(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async => getVisibleRegionSync();

  @override
  double getMetersPerPixelAtLatitudeSync(double latitude) =>
      circumferenceOfEarth *
      cos(latitude * degree2Radian) /
      pow(2, _map.getZoom() + 9);

  @override
  LngLatBounds getVisibleRegionSync() {
    final bounds = _map.getBounds();
    return LngLatBounds(
      longitudeWest: bounds.getWest().toDouble(),
      longitudeEast: bounds.getEast().toDouble(),
      latitudeSouth: bounds.getSouth().toDouble(),
      latitudeNorth: bounds.getNorth().toDouble(),
    );
  }

  void _updateGestures(MapGestures gestures) {
    if (gestures.pan) {
      _map.dragPan.enable();
    } else {
      _map.dragPan.disable();
    }
    if (gestures.zoom) {
      _map.touchZoomRotate.enable();
      _map.doubleClickZoom.enable();
      _map.scrollZoom.enable();
      _map.boxZoom.enable();
    } else {
      _map.touchZoomRotate.disable(); // this disables rotation as well
      _map.doubleClickZoom.disable();
      _map.scrollZoom.disable();
      _map.boxZoom.disable();
    }
    if (gestures.rotate) {
      _map.dragRotate.enable();
      _map.touchZoomRotate.disableRotation();
    } else {
      _map.touchZoomRotate.enableRotation();
      _map.dragRotate.disable();
    }
    if (gestures.pitch) {
      // TODO dragRotate allows to pitch too but has no option to disable pitch.
      _map.touchPitch.enable();
    } else {
      _map.touchPitch.disable();
    }
    // It's not possible to disable just some gestures for the KeyboardHandler.
    // That's why we disable it completely if not all gestures are enabled.
    if (gestures.allEnabled) {
      _map.keyboard.enable();
    } else {
      _map.keyboard.disable();
    }
  }

  @override
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
  }) async {
    debugPrint("Can't enable the user location on web programmatically.");
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    debugPrint("Can't track the user location on web.");
  }

  @override
  Future<List<QueriedLayer>> queryLayers(
    Offset screenLocation,
  ) async {
    final features =
        _map.queryRenderedFeatures(screenLocation.toJsPoint(), null);
    return features.toDart
        .map(
          (e) => QueriedLayer(
            layerId: e.layer.id,
            sourceId: e.source,
            sourceLayer: e.sourceLayer,
          ),
        )
        .toList(growable: false);
  }
}
