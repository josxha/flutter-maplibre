part of 'interop.dart';

/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/QueryRenderedFeaturesOptions/
extension type QueryRenderedFeaturesOptions._(JSObject _) implements JSObject {
  /// Create a new JS [QueryRenderedFeaturesOptions].
  external const QueryRenderedFeaturesOptions({
    JSArray<JSString>? layers,
    FilterSpecification? filter,
    JSArray<JSString>? availableImages,
    bool? validate,
  });

  external JSArray<JSString> layers;
  external FilterSpecification? filter;
  external JSArray<JSString>? availableImages;
  external bool? validate;
}
