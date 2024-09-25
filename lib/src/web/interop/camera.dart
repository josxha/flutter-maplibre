part of 'interop.dart';

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/camera.ts
@JS()
extension type Camera._(JSObject _) implements JSObject {
  /// Create a new JS [Camera].
  external Camera(CameraOptions options);

  /// Move the viewport of the map to a new location without animation.
  external void jumpTo(
    JumpToOptions options, [
    JSAny? eventData,
  ]);

  /// Animate the viewport of the map to a new location.
  external void flyTo(
    FlyToOptions options, [
    JSAny? eventData,
  ]);

  /// Animate the viewport of the map to fit [LngLatBounds].
  external void fitBounds(
    LngLatBounds bounds, [
    FitBoundsOptions? options,
  ]);
}

/// Options used for [Camera.jumpTo].
@anonymous
@JS()
extension type JumpToOptions._(CameraOptions _) implements CameraOptions {
  /// Create a new JS [JumpToOptions].
  external factory JumpToOptions({
    PaddingOptions? padding,
    num? pitch,
    LngLat? around,
    LngLat? center,
    num? zoom,
    num? bearing,
  });
}

/// Options used for [Camera.flyTo].
@anonymous
@JS()
extension type FlyToOptions._(CameraOptions _) implements CameraOptions {
  /// Create a new JS [FlyToOptions].
  external factory FlyToOptions({
    num? curve,
    num? minZoom,
    num? speed,
    num? screenSpeed,
    num? maxDuration,
    PaddingOptions? padding,
    num? pitch,
    LngLat? around,
    LngLat? center,
    num? zoom,
    num? bearing,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/8a005bd7d4769b62db470ce7e8cf2b08255c1d36/src/geo/edge_insets.ts#L129
@anonymous
@JS()
extension type PaddingOptions._(JSObject _) implements JSObject {
  /// Create a new JS [PaddingOptions].
  external factory PaddingOptions({num top, num bottom, num right, num left});
}

/// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/camera.ts#L57
@anonymous
@JS()
extension type CameraOptions._(CenterZoomBearing _)
    implements CenterZoomBearing {
  /// Create a new JS [CameraOptions].
  external factory CameraOptions({num? pitch, LngLat? around});
}

/// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/camera.ts#L74
@anonymous
@JS()
extension type CenterZoomBearing._(JSObject _) implements JSObject {
  /// Create a new JS [CenterZoomBearing].
  external factory CenterZoomBearing({LngLat? center, num? zoom, num? bearing});
}
