part of 'interop.dart';

/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/QueryRenderedFeaturesOptions/
extension type QueryRenderedFeaturesOptions._(JSObject _) implements JSObject {
  /// Create a new JS [QueryRenderedFeaturesOptions].
  external const QueryRenderedFeaturesOptions({
    List<String>? layers,
    FilterSpecification? filter,
    List<String>? availableImages,
    bool? validate,
  });

  external List<String>? layers;
  external FilterSpecification? filter;
  external List<String>? availableImages;
  external bool? validate;
}
