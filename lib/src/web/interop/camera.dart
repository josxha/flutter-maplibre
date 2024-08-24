part of 'interop.dart';

@JS()
extension type Camera._(JSObject _) implements JSObject {
  external Camera(CameraOptions options);

  external void jumpTo(
    JumpToOptions options, [
    JSAny? eventData,
  ]);

  external void flyTo(
    FlyToOptions options, [
    JSAny? eventData,
  ]);
}

@anonymous
@JS()
extension type JumpToOptions._(CameraOptions _) implements CameraOptions {
  external factory JumpToOptions({
    PaddingOptions? padding,
    num? pitch,
    LngLat? around,
    LngLat? center,
    num? zoom,
    num? bearing,
  });
}

@anonymous
@JS()
extension type FlyToOptions._(CameraOptions _) implements CameraOptions {
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
  external factory PaddingOptions({num top, num bottom, num right, num left});
}

@anonymous
@JS()
extension type CameraOptions._(CenterZoomBearing _)
    implements CenterZoomBearing {
  external factory CameraOptions({num? pitch, LngLat? around});
}

@anonymous
@JS()
extension type CenterZoomBearing._(JSObject _) implements JSObject {
  external factory CenterZoomBearing({LngLat? center, num? zoom, num? bearing});
}
