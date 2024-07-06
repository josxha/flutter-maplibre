part of 'interop.dart';

extension type IControl._(JSObject _) implements JSObject {}

@JS()
extension type ScaleControl._(IControl _) implements IControl {
  external ScaleControl([ScaleControlOptions? options]);
}

@anonymous
@JS()
extension type ScaleControlOptions._(JSObject _) implements JSObject {
  external factory ScaleControlOptions({
    num? maxWidth,
    // Unit could be some day an enum, https://github.com/dart-lang/sdk/issues/49243
    String? unit,
  });
}

@JS()
extension type GeolocateControl._(IControl _) implements IControl {
  external GeolocateControl([GeolocateControlOptions? options]);
}

@anonymous
@JS()
extension type GeolocateControlOptions._(JSObject _) implements JSObject {
  external factory GeolocateControlOptions({
    PositionOptions? positionOptions,
    FitBoundsOptions? fitBoundsOptions,
    bool? trackUserLocation,
    bool? showAccuracyCircle,
    bool? showUserLocation,
  });
}

@anonymous
@JS()
extension type PositionOptions._(JSObject _) implements JSObject {
  external factory PositionOptions({
    bool enableHighAccuracy,
    int maximumAge,
    int timeout,
  });
}

@JS()
extension type AttributionControl._(IControl _) implements IControl {
  external AttributionControl([AttributionControlOptions? options]);
}

@anonymous
@JS()
extension type AttributionControlOptions._(JSObject _) implements JSObject {
  external factory AttributionControlOptions({
    bool? compact,
    String? customAttribution,
  });
}

@JS()
extension type FullscreenControl._(IControl _) implements IControl {
  external FullscreenControl([FullscreenControlOptions? options]);
}

@anonymous
@JS()
extension type FullscreenControlOptions._(JSObject _) implements JSObject {
  external factory FullscreenControlOptions({
    String? container,
  });
}

@JS()
extension type LogoControl._(IControl _) implements IControl {
  external LogoControl([LogoControlOptions? options]);
}

@anonymous
@JS()
extension type LogoControlOptions._(JSObject _) implements JSObject {
  external factory LogoControlOptions({
    bool? compact,
  });
}

@JS()
extension type NavigationControl._(IControl _) implements IControl {
  external NavigationControl([NavigationControlOptions? options]);
}

@anonymous
@JS()
extension type NavigationControlOptions._(JSObject _) implements JSObject {
  external factory NavigationControlOptions({
    bool? showCompass,
    bool? showZoom,
    bool? visualizePitch,
  });
}

@JS()
extension type TerrainControl._(IControl _) implements IControl {
  external TerrainControl([TerrainControlOptions? options]);
}

@anonymous
@JS()
extension type TerrainControlOptions._(JSObject _) implements JSObject {
  external factory TerrainControlOptions({
    String source,
  });
}
