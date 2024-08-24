part of 'interop.dart';

@JS()
extension type Map._(JSObject _) implements JSObject {
  external Map(MapOptions options);

  external void addControl(IControl control);

  /// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/ui/map.ts#L1383
  external void on(String type, JSExportedDartFunction listener);

  external void addSource(String id, SourceSpecification source);

  external void addLayer(AddLayerObject layer, [String? beforeId]);

  external Point project(LngLat lngLat);

  external HTMLElement getContainer();

  external HTMLCanvasElement getCanvas();

  external void resize();
}

@anonymous
@JS()
extension type MapOptions._(JSObject _) implements JSObject {
  external factory MapOptions({
    required String style,
    required JSObject container,
    double zoom = 0,
    LngLat? center,
  });
}

@anonymous
@JS()
extension type LngLat._(JSObject _) implements JSObject {
  external factory LngLat({
    required num lng,
    required num lat,
  });

  external num lng;
  external num lat;

  Position toPosition() => Position(lng, lat);
}

@anonymous
@JS()
extension type FitBoundsOptions._(JSObject _) implements JSObject {
  external factory FitBoundsOptions({
    bool? linear,
    // TODO  Offset? offset,
    num? maxZoom,
    // TODO All parameters from FlyToOptions
  });
}

@anonymous
@JS()
extension type SourceSpecification._(JSObject _) implements JSObject {
  external factory SourceSpecification({required String type});

  external factory SourceSpecification.geoJson({
    required String type,
    required JSAny data,
    num? maxzoom,
    String? attribution,
    num? buffer,
  });
}

@anonymous
@JS()
extension type AddLayerObject._(JSObject _) implements JSObject {
  external factory AddLayerObject({
    required String id,
    required String type,
    required String source,
  });
}
