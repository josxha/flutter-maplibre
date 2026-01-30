part of 'interop.dart';

/// https://maplibre.org/maplibre-gl-js/docs/API/interfaces/GeoJSONFeature/
extension type GeoJSONFeature._(JSObject _) implements JSObject {
  external JSAny? id;
  external JSObject properties;
}

/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/MapGeoJSONFeature/
extension type MapGeoJSONFeature._(JSObject _)
    implements JSObject, GeoJSONFeature {
  external LayerSpecification layer;
  external String source;
  external String? sourceLayer;
  external JSObject state;
}
