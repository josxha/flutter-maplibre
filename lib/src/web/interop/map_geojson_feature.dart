part of 'interop.dart';

/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/MapGeoJSONFeature/
extension type MapGeoJSONFeature._(JSObject _) implements JSObject {
  external LayerSpecification layer;
  external String? source;
  external String? sourceLayer;
  external JSObject state;
}
