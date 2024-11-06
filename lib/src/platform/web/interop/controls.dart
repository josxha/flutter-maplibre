part of 'interop.dart';

/// Base class for web-only UI controls.
extension type IControl._(JSObject _) implements JSObject {}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/scale_control.ts
@JS()
extension type ScaleControl._(IControl _) implements IControl {
  /// Create a new [ScaleControl].
  external ScaleControl([ScaleControlOptions? options]);
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/scale_control.ts#L14
@anonymous
@JS()
extension type ScaleControlOptions._(JSObject _) implements JSObject {
  /// Create a new [ScaleControlOptions].
  external factory ScaleControlOptions({
    num? maxWidth,
    // Unit could be some day an enum, https://github.com/dart-lang/sdk/issues/49243
    String? unit,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/geolocate_control.ts
@JS()
extension type GeolocateControl._(IControl _) implements IControl {
  /// Create a new [GeolocateControl].
  external GeolocateControl([GeolocateControlOptions? options]);
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/geolocate_control.ts#L16
@anonymous
@JS()
extension type GeolocateControlOptions._(JSObject _) implements JSObject {
  /// Create a new [GeolocateControlOptions].
  external factory GeolocateControlOptions({
    PositionOptions? positionOptions,
    FitBoundsOptions? fitBoundsOptions,
    bool? trackUserLocation,
    bool? showAccuracyCircle,
    bool? showUserLocation,
  });
}

/// https://developer.mozilla.org/en-US/docs/Web/API/PositionOptions
@anonymous
@JS()
extension type PositionOptions._(JSObject _) implements JSObject {
  /// Create a new [PositionOptions].
  external factory PositionOptions({
    bool enableHighAccuracy,
    int maximumAge,
    int timeout,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/attribution_control.ts
@JS()
extension type AttributionControl._(IControl _) implements IControl {
  /// Create a new [AttributionControl].
  external AttributionControl([AttributionControlOptions? options]);
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/attribution_control.ts#L10
@anonymous
@JS()
extension type AttributionControlOptions._(JSObject _) implements JSObject {
  /// Create a new [AttributionControlOptions].
  external factory AttributionControlOptions({
    bool? compact,
    String? customAttribution,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/fullscreen_control.ts
@JS()
extension type FullscreenControl._(IControl _) implements IControl {
  /// Create a new [FullscreenControl].
  external FullscreenControl([FullscreenControlOptions? options]);
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/fullscreen_control.ts#L12
@anonymous
@JS()
extension type FullscreenControlOptions._(JSObject _) implements JSObject {
  /// Create a new [FullscreenControlOptions].
  external factory FullscreenControlOptions({
    String? container,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/logo_control.ts
@JS()
extension type LogoControl._(IControl _) implements IControl {
  /// Create a new [LogoControl].
  external LogoControl([LogoControlOptions? options]);
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/logo_control.ts#L9
@anonymous
@JS()
extension type LogoControlOptions._(JSObject _) implements JSObject {
  /// Create a new [LogoControlOptions].
  external factory LogoControlOptions({
    bool? compact,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/navigation_control.ts
@JS()
extension type NavigationControl._(IControl _) implements IControl {
  /// Create a new [NavigationControl].
  external NavigationControl([NavigationControlOptions? options]);
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/navigation_control.ts#L14
@anonymous
@JS()
extension type NavigationControlOptions._(JSObject _) implements JSObject {
  /// Create a new [NavigationControlOptions].
  external factory NavigationControlOptions({
    bool? showCompass,
    bool? showZoom,
    bool? visualizePitch,
  });
}

/// https://github.com/maplibre/maplibre-gl-js/blob/main/src/ui/control/terrain_control.ts
@JS()
extension type TerrainControl._(IControl _) implements IControl {
  /// Create a new [TerrainControl].
  external TerrainControl([TerrainControlOptions? options]);
}

/// TerrainSpecification from https://github.com/maplibre/maplibre-style-spec
@anonymous
@JS()
extension type TerrainControlOptions._(JSObject _) implements JSObject {
  /// Create a new [TerrainControlOptions].
  external factory TerrainControlOptions({
    String source,
  });
}
