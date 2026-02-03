// ignore_for_file: unnecessary_underscores

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_ios/src/extensions.dart';
import 'package:maplibre_ios/src/maplibre_ffi.g.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:objective_c/objective_c.dart';

part 'style_controller.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateIos extends MapLibreMapState
    implements MLNMapViewDelegate$Builder {
  // ignore: unused_field
  late final int _viewId;
  MLNMapView? _mapView;

  @override
  StyleControllerIos? style;

  @override
  Widget buildPlatformWidget(BuildContext context) {
    const viewType = 'plugins.flutter.io/maplibre';
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      gestureRecognizers: widget.gestureRecognizers,
      onPlatformViewCreated: _onPlatformViewCreated,
    );
  }

  /// This method gets called when the platform view is created. It is not
  /// guaranteed that the map is ready.
  void _onPlatformViewCreated(int viewId) {
    _viewId = viewId;
    final mapView = MapLibreRegistry.getMapWithViewId(viewId)!;
    _mapView = mapView;
    // setStyle(options.initStyle);
    mapView.automaticallyAdjustsContentInset = true;
    // Use listener callbacks to marshal onto the Dart isolate.
    final delegate = MLNMapViewDelegate$Builder.implementAsListener(
      // Camera & region events
      mapView_regionWillChangeWithReason_animated_: _regionWillChangeWithReason,
      mapView_regionDidChangeWithReason_animated_: _regionDidChangeWithReason,
      mapView_regionDidChangeAnimated_: _regionDidChange,
      mapViewRegionIsChanging_: _regionIsChanging,
      mapView_regionIsChangingWithReason_: _regionIsChangingWithReason,
      mapView_regionWillChangeAnimated_: _regionWillChangeAnimated,
      mapView_shouldChangeFromCamera_toCamera_reason_:
          (mapView, fromCamera, toCamera, reason) {
            print(
              '[MapDelegate] shouldChangeFromCamera toCamera reason called',
            );
            return true;
          },

      // Map loading & rendering
      mapView_didFinishLoadingStyle_: (mapView, style) =>
          print('[MapDelegate] Style finished loading'),
      mapViewDidFinishLoadingMap_: (mapView) =>
          print('[MapDelegate] Map finished loading'),
      mapViewDidFailLoadingMap_withError_: (mapView, error) => print(
        '[MapDelegate] Map failed to load: ${error.localizedDescription}',
      ),
      mapViewDidFinishRenderingFrame_fullyRendered_: (mapView, fullyRendered) =>
          print(
            '[MapDelegate] Finished rendering frame, fullyRendered: $fullyRendered',
          ),
      mapViewDidFinishRenderingFrame_fullyRendered_frameEncodingTime_frameRenderingTime_:
          (
            mapView,
            fullyRendered,
            frameEncodingTime,
            frameRenderingTime,
          ) => print(
            '[MapDelegate] Frame finished, fullyRendered: $fullyRendered, encoding: $frameEncodingTime, rendering: $frameRenderingTime',
          ),
      mapViewDidFinishRenderingFrame_fullyRendered_renderingStats_:
          (mapView, fullyRendered, stats) => print(
            '[MapDelegate] Frame finished, fullyRendered: $fullyRendered, stats: $stats',
          ),
      mapViewDidFinishRenderingMap_fullyRendered_: (mapView, fullyRendered) =>
          print(
            '[MapDelegate] Map finished rendering, fullyRendered: $fullyRendered',
          ),
      mapViewDidBecomeIdle_: (mapView) =>
          print('[MapDelegate] Map became idle'),
      mapViewDidStopLocatingUser_: (mapView) =>
          print('[MapDelegate] Stopped locating user'),

      // Annotations
      mapView_didAddAnnotationViews_: (mapView, views) =>
          print('[MapDelegate] Added annotation views'),
      mapView_didSelectAnnotation_: (mapView, annotation) =>
          print('[MapDelegate] Annotation selected'),
      mapView_didDeselectAnnotation_: (mapView, annotation) =>
          print('[MapDelegate] Annotation deselected'),
      mapView_didUpdateUserLocation_: (mapView, location) =>
          print('[MapDelegate] User location updated'),

      // Callouts
      mapView_annotation_calloutAccessoryControlTapped_:
          (mapView, annotation, control) =>
              print('[MapDelegate] Callout accessory tapped'),
      mapView_leftCalloutAccessoryViewForAnnotation_: (mapView, annotation) {
        print('[MapDelegate] Left callout accessory view requested');
        return null;
      },
      mapView_rightCalloutAccessoryViewForAnnotation_: (mapView, annotation) {
        print('[MapDelegate] Right callout accessory view requested');
        return null;
      },
      mapView_calloutViewForAnnotation_: (mapView, annotation) {
        print('[MapDelegate] Callout view requested');
        return null;
      },
      mapView_tapOnCalloutForAnnotation_: (mapView, annotation) =>
          print('[MapDelegate] Callout tapped'),

      // Shapes
      mapView_alphaForShapeAnnotation_: (mapView, shape) {
        print('[MapDelegate] Alpha for shape requested');
        return 1.0;
      },
      /*mapView_fillColorForPolygonAnnotation_: (mapView, polygon) {
        print('[MapDelegate] Fill color for polygon requested');
        return MLNMapViewDelegate$Builder.mapView_fillColorForPolygonAnnotation_);
      },
      mapView_strokeColorForShapeAnnotation_: (mapView, shape) {
        print('[MapDelegate] Stroke color for shape requested');
        return UIColor.black;
      },*/
      mapView_shapeAnnotationIsEnabled_: (mapView, shape) {
        print('[MapDelegate] Shape annotation enabled check');
        return true;
      },
      mapView_lineWidthForPolylineAnnotation_: (mapView, polyline) {
        print('[MapDelegate] Line width for polyline requested');
        return 2.0;
      },

      // Images
      mapView_imageForAnnotation_: (mapView, annotation) {
        print('[MapDelegate] Image for annotation requested');
        return null;
      },
      mapView_didFailToLoadImage_: (mapView, name) {
        print('[MapDelegate] Failed to load image: $name');
        return null;
      },

      // Sprite & style events
      mapView_spriteDidLoad_url_: (mapView, url, id) =>
          print('[MapDelegate] Sprite loaded: $url'),
      mapView_spriteWillLoad_url_: (mapView, url, id) =>
          print('[MapDelegate] Sprite will load: $url'),
      mapView_spriteDidError_url_: (mapView, url, id) =>
          print('[MapDelegate] Sprite error: $url'),
      mapView_sourceDidChange_: (mapView, source) =>
          print('[MapDelegate] Source did change: $source'),
      mapView_shouldRemoveStyleImage_: (mapView, name) {
        print('[MapDelegate] Should remove style image: $name');
        return true;
      },

      // Shaders
      mapView_shaderDidCompile_backend_defines_: (mapView, a, b, name) =>
          print('[MapDelegate] Shader compiled: $name'),
      mapView_shaderDidFailCompile_backend_defines_: (mapView, a, b, name) =>
          print('[MapDelegate] Shader failed: $name'),
      mapView_shaderWillCompile_backend_defines_: (mapView, a, b, name) =>
          print('[MapDelegate] Shader will compile: $name'),

      // Tiles
      mapView_tileDidTriggerAction_x_y_z_wrap_overscaledZ_sourceID_:
          (mapView, x, y, z, wrap, over, scaledZ, sourceID) =>
              print('[MapDelegate] Tile action triggered: $sourceID'),

      // User location
      /*mapViewStyleForDefaultUserLocationAnnotationView_: (_) {
        print('[MapDelegate] Default user location style requested');
        return mapViewStyleForDefaultUserLocationAnnotationView_;
      },
      mapViewUserLocationAnchorPoint_: (_) {
        print('[MapDelegate] User location anchor point requested');
        return const objc.CGPoint(x: 0.5, y: 0.5);
      },*/

      // Rendering lifecycle
      mapViewWillStartLoadingMap_: (_) =>
          print('[MapDelegate] Will start loading map'),
      mapViewWillStartLocatingUser_: (_) =>
          print('[MapDelegate] Will start locating user'),
      mapViewWillStartRenderingFrame_: (_) =>
          print('[MapDelegate] Will start rendering frame'),
      mapViewWillStartRenderingMap_: (_) =>
          print('[MapDelegate] Will start rendering map'),
    );

    mapView.delegate = delegate;

    // disable the default UI because they are rebuilt in Flutter
    mapView.showsCompassView = false;
    mapView.showsAttributionButton = false;
    mapView.showsLogoView = false;

    // apply initial options
    mapView.minimumZoomLevel = options.minZoom;
    mapView.maximumZoomLevel = options.maxZoom;
    mapView.minimumPitch = options.minPitch;
    mapView.maximumPitch = options.maxPitch;
    mapView.isRotateEnabled = options.gestures.rotate;
    mapView.isScrollEnabled = options.gestures.pan;
    mapView.isZoomEnabled = options.gestures.zoom;
    mapView.isPitchEnabled = options.gestures.pitch;
    if (options.maxBounds case final bounds?) {
      mapView.maximumScreenBounds = bounds.toMLNCoordinateBounds();
    }
    if (options.initCenter case final center?) {
      mapView.setCenterCoordinate(
        center.toCLLocationCoordinate2D(),
        animated: false,
      );
    }
    mapView.zoomLevel = options.initZoom;
    mapView.direction = options.initBearing;
    // TODO apply initial pitch
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
    setState(() {
      camera = getCamera();
      isInitialized = true;
    });
    mapView.addGestureRecognizer(gestureRecognizer);
    /*
                let doubleTap = UITapGestureRecognizer(
                    target: self, action: #selector(self.onDoubleTap(sender:))
                )
                doubleTap.numberOfTapsRequired = 2
                doubleTap.delegate = self
                self._mapView.addGestureRecognizer(doubleTap)

                let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
                singleTap.require(toFail: doubleTap)
                singleTap.delegate = self
                if #available(iOS 13.4, *) {
                    singleTap.buttonMaskRequired = .primary
                }
                self._mapView.addGestureRecognizer(singleTap)

                if #available(iOS 13.4, *) {
                    let secondaryTap = UITapGestureRecognizer(
                        target: self, action: #selector(self.onSecondaryTap(sender:))
                    )
                    secondaryTap.buttonMaskRequired = .secondary
                    secondaryTap.delegate = self
                    self._mapView.addGestureRecognizer(secondaryTap)
                }

                let longPress = UILongPressGestureRecognizer(
                    target: self,
                    action: #selector(self.onLongPress(sender:))
                )
                longPress.delegate = self
                self._mapView.addGestureRecognizer(longPress)
            }*/
  }

  @override
  Future<void> animateCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) async {
    final mapView = _mapView;
    if (mapView == null) return;

    if (zoom != null) mapView.zoomLevel = zoom;
    final ffiCamera = mapView.camera;
    if (pitch != null) ffiCamera.pitch = pitch;
    if (bearing != null) ffiCamera.heading = bearing;
    if (center != null) {
      ffiCamera.centerCoordinate = center.toCLLocationCoordinate2D();
    }
    mapView.flyToCamera$2(
      ffiCamera,
      withDuration: nativeDuration.inMicroseconds / 1000000,
    );
  }

  @override
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
    BearingRenderMode bearingRenderMode = BearingRenderMode.gps,
  }) async {
    final mapView = _mapView;
    if (mapView == null) return;

    mapView.showsUserLocation = true;
    // TODO: apply bearingRenderMode
    mapView.showsUserHeadingIndicator =
        bearingRenderMode != BearingRenderMode.none;
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
  }) async {
    final mapView = _mapView;
    if (mapView == null) return;

    final ffiBounds = bounds.toMLNCoordinateBounds();
    final ffiPadding = padding.toUIEdgeInsets();
    mapView.setVisibleCoordinateBounds$1(
      ffiBounds,
      edgePadding: ffiPadding,
      animated: true,
    );
  }

  @override
  MapCamera getCamera() {
    final mapView = _mapView!;
    final ffiCamera = mapView.camera;
    return MapCamera(
      center: ffiCamera.centerCoordinate.toGeographic(),
      zoom: mapView.zoomLevel,
      bearing: mapView.direction,
      pitch: ffiCamera.pitch,
    );
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    final mapView = _mapView;
    if (mapView == null) return;
    if (zoom != null) mapView.zoomLevel = zoom;
    final ffiCamera = mapView.camera;
    if (pitch != null) ffiCamera.pitch = pitch;
    if (bearing != null) ffiCamera.heading = bearing;
    if (center != null) {
      ffiCamera.centerCoordinate = center.toCLLocationCoordinate2D();
    }
    mapView.setCamera(ffiCamera, animated: false);
  }

  @override
  void dispose() {
    style?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _updateOptions(oldWidget);
    layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _updateOptions(MapLibreMap oldWidget) async {
    final mapView = _mapView;
    if (mapView == null) return;
    final oldOptions = oldWidget.options;
    final options = this.options;
    mapView.minimumZoomLevel = options.minZoom;
    mapView.maximumZoomLevel = options.maxZoom;
    mapView.minimumPitch = options.minPitch;
    mapView.maximumPitch = options.maxPitch;

    // map bounds
    final oldBounds = oldOptions.maxBounds;
    final newBounds = options.maxBounds;
    if (oldBounds != null && newBounds == null) {
      mapView.maximumScreenBounds = Struct.create<MLNCoordinateBounds>();
    } else if ((oldBounds == null && newBounds != null) ||
        (newBounds != null && oldBounds != newBounds)) {
      final bounds = newBounds.toMLNCoordinateBounds();
      mapView.maximumScreenBounds = bounds;
    }

    // gestures
    if (options.gestures.rotate != oldOptions.gestures.rotate) {
      mapView.isRotateEnabled = options.gestures.rotate;
    }
    if (options.gestures.pan != oldOptions.gestures.pan) {
      mapView.isScrollEnabled = options.gestures.pan;
    }
    if (options.gestures.zoom != oldOptions.gestures.zoom) {
      mapView.isZoomEnabled = options.gestures.zoom;
    }
    if (options.gestures.pitch != oldOptions.gestures.pitch) {
      mapView.isPitchEnabled = options.gestures.pitch;
    }
  }

  List<RenderedFeature> _nativeQueryToRenderedFeatures(NSArray query) {
    final features = query.asDart().map(MLNFeature.as);
    return features
        .map(
          (f) => RenderedFeature(
            id: f.identifier == null ? null : toDartObject(f.identifier!),
            properties: f.attributes.toDartMap().map(
              (k, v) => MapEntry(k.toString(), v),
            ),
          ),
        )
        .toList(growable: false);
  }

  @override
  List<RenderedFeature> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  }) {
    final style = this.style;
    if (style == null) {
      return [];
    }
    if (layerIds?.isEmpty ?? false) {
      // https://github.com/maplibre/maplibre-native/issues/2828
      return [];
    }

    final query = _mapView!.visibleFeaturesAtPoint$1(
      point.toCGPoint(),
      inStyleLayersWithIdentifiers: layerIds == null
          ? null
          : NSSet.of(layerIds.map((s) => s.toNSString())),
    );

    return _nativeQueryToRenderedFeatures(query);
  }

  @override
  List<RenderedFeature> featuresInRect(Rect rect, {List<String>? layerIds}) {
    final style = this.style;
    if (style == null) {
      return [];
    }
    if (layerIds?.isEmpty ?? false) {
      // https://github.com/maplibre/maplibre-native/issues/2828
      return [];
    }

    final query = _mapView!.visibleFeaturesInRect$1(
      rect.toCGRect(),
      inStyleLayersWithIdentifiers: layerIds == null
          ? null
          : NSSet.of(layerIds.map((s) => s.toNSString())),
    );

    return _nativeQueryToRenderedFeatures(query);
  }

  @override
  List<QueriedLayer> queryLayers(Offset screenLocation) {
    final style = this.style;
    if (style == null) return [];
    final layers = style._getLayers();

    final point = screenLocation.toCGPoint();
    final queriedLayers = <QueriedLayer>[];
    for (var i = layers.length - 1; i >= 0; i--) {
      final layer = layers[i];
      final features = _mapView!
          .visibleFeaturesAtPoint$1(
            point,
            inStyleLayersWithIdentifiers: NSSet.setWithObject(layer.identifier),
          )
          .asDart();
      if (features.isEmpty) continue;
      if (features.isNotEmpty && MLNVectorStyleLayer.isA(layer)) {
        final vectorLayer = MLNVectorStyleLayer.as(layer);
        final queriedLayer = QueriedLayer(
          layerId: layer.identifier.toDartString(),
          sourceId: vectorLayer.sourceIdentifier?.toDartString(),
          sourceLayer: vectorLayer.sourceLayerIdentifier?.toDartString(),
        );
        queriedLayers.add(queriedLayer);
      }
    }
    return queriedLayers;
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    final mapView = _mapView!;
    if (!trackLocation) {
      mapView.userTrackingMode = MLNUserTrackingMode.MLNUserTrackingModeNone;
      return;
    }
    mapView.userTrackingMode = switch (trackBearing) {
      BearingTrackMode.none => MLNUserTrackingMode.MLNUserTrackingModeFollow,
      BearingTrackMode.compass =>
        MLNUserTrackingMode.MLNUserTrackingModeFollowWithHeading,
      BearingTrackMode.gps =>
        MLNUserTrackingMode.MLNUserTrackingModeFollowWithCourse,
    };
  }

  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      _mapView?.metersPerPointAtLatitude(latitude) ?? 0;

  @override
  LngLatBounds getVisibleRegion() {
    final bounds = _mapView!.visibleCoordinateBounds;
    return LngLatBounds(
      longitudeWest: bounds.sw.longitude,
      longitudeEast: bounds.ne.longitude,
      latitudeSouth: bounds.sw.latitude,
      latitudeNorth: bounds.ne.latitude,
    );
  }

  @override
  Geographic toLngLat(Offset screenLocation) => _mapView!
      .convertPoint(
        screenLocation.toCGPoint(),
        toCoordinateFromView: _mapView,
      )
      .toGeographic();

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      screenLocations.map(toLngLat).toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) => _mapView!
      .convertCoordinate(
        lngLat.toCLLocationCoordinate2D(),
        toPointToView: _mapView,
      )
      .toOffset();

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) =>
      lngLats.map(toScreenLocation).toList(growable: false);

  @override
  Future<void> setStyle(String style) async {
    final prepared = await _prepareStyle(style);
    if (NSString.isA(prepared)) {
      _mapView!.styleJSON = NSString.as(prepared);
    } else if (NSURL.isA(prepared)) {
      _mapView!.styleURL = NSURL.as(prepared);
    } else {
      throw UnsupportedError('Unsupported style format');
    }
  }

  Future<NSObject> _prepareStyle(String style) async {
    final trimmed = style.trim();
    if (trimmed.startsWith('{')) {
      // Raw JSON
      return trimmed.toNSString();
    } else if (trimmed.startsWith('/')) {
      return 'file://$trimmed'.toNSURL()!;
    } else if (!trimmed.startsWith('http://') &&
        !trimmed.startsWith('https://') &&
        !trimmed.startsWith('mapbox://')) {
      // flutter asset
      final content = await rootBundle.loadString(trimmed);
      return content.toNSString();
    } else {
      // URI
      return trimmed.toNSURL()!;
    }
  }

  /// MLNMapViewDelegate method called when map has finished loading
  void _didFinishLoadingStyle(MLNMapView mapView, MLNStyle mlnStyle) {
    debugPrint('Style loaded');
    // We need to refresh the cached style for when the style reloads.
    style?.dispose();
    final styleCtrl = style = StyleControllerIos._(mlnStyle);
    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  /* TODO
  @override
  void onDoubleClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventClick(point: position, screenPoint: screenOffset),
    );
  }

  @override
  void onSecondaryClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventClick(point: position, screenPoint: screenOffset),
    );
  }

  @override
  void onClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventClick(point: position, screenPoint: screenOffset),
    );
  }

  @override
  void onLongClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventLongClick(point: position, screenPoint: screenOffset),
    );
  }
*/

  /// MLNMapViewDelegate method called when camera is about to start changing
  void _regionWillChangeWithReason(
    MLNMapView mapView,
    int mlnChangeReason,
    bool animated,
  ) {
    debugPrint('Region will change with reason: $mlnChangeReason');
    const apiReasons = {
      MLNCameraChangeReason.MLNCameraChangeReasonGestureOneFingerZoom,
      MLNCameraChangeReason.MLNCameraChangeReasonGesturePan,
      MLNCameraChangeReason.MLNCameraChangeReasonGesturePinch,
      MLNCameraChangeReason.MLNCameraChangeReasonGestureRotate,
      MLNCameraChangeReason.MLNCameraChangeReasonGestureTilt,
      MLNCameraChangeReason.MLNCameraChangeReasonGestureZoomIn,
      MLNCameraChangeReason.MLNCameraChangeReasonGestureZoomOut,
      MLNCameraChangeReason.MLNCameraChangeReasonTransitionCancelled,
    };
    final CameraChangeReason reason;
    if (apiReasons.contains(mlnChangeReason)) {
      reason = CameraChangeReason.apiGesture;
    } else if (mlnChangeReason ==
        MLNCameraChangeReason.MLNCameraChangeReasonProgrammatic) {
      reason = CameraChangeReason.apiAnimation;
    } else {
      reason = CameraChangeReason.developerAnimation;
    }
    widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
  }

  /// MLNMapViewDelegate method called when camera has finished changing
  void _regionDidChangeWithReason(
    MLNMapView mapView,
    int reason,
    bool animated,
  ) {
    debugPrint('Region did change with reason: $reason');
    widget.onEvent?.call(const MapEventCameraIdle());
  }

  /// MLNMapViewDelegate method called when camera has changed
  void _regionDidChange(MLNMapView mapView, bool animated) =>
      _onCameraMoved(mapView);

  /// MLNMapViewDelegate method called when camera is changing
  void _regionIsChanging(MLNMapView mapView) => _onCameraMoved(mapView);

  void _onCameraMoved(MLNMapView mapView) {
    debugPrint('Camera moved');
    final ffiCamera = mapView.camera;
    final mapCamera = MapCamera(
      center: ffiCamera.centerCoordinate.toGeographic(),
      zoom: mapView.zoomLevel,
      pitch: ffiCamera.pitch,
      bearing: ffiCamera.heading,
    );
    widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
  }

  /// MLNMapViewDelegate method called when map becomes idle
  void _didBecomeIdle(MLNMapView mapView) {
    debugPrint('Map became idle');
    widget.onEvent?.call(const MapEventIdle());
  }

  void _regionIsChangingWithReason(MLNMapView mapView, int reason) {
    debugPrint('Region is changing with reason: $reason');
    _onCameraMoved(mapView);
  }

  void _regionWillChangeAnimated(MLNMapView mapView, bool animated) {
    debugPrint('Region will change animated: $animated');
    widget.onEvent?.call(
      const MapEventStartMoveCamera(
        reason: CameraChangeReason.developerAnimation,
      ),
    );
  }
}
