part of '../interop.dart';

/// The specifications of map layers.
@anonymous
@JS()
extension type LayerSpecification._(JSObject _) implements JSObject {
  /// The default constructor for a [LayerSpecification].
  external LayerSpecification({
    required String id,
    required String type,
    required double? minzoom,
    required double? maxzoom,
    JSAny? layout,
    JSAny? paint,
    String? source,
  });

  /// The layer id.
  external String id;

  /// The minimum zoom level.
  external double? minzoom;

  /// The maximum zoom level.
  external double? maxzoom;

  /// The source id.
  external String? source;

  external JSAny filter;
  @JS('source-layer')
  external String? sourceLayer;

  /// The layout properties of the layer.
  external JSAny? layout;

  /// The paint properties of the layer.
  external JSAny? paint;
}

/// Image data used by [JsMap.addImage].
///
/// https://github.com/maplibre/maplibre-gl-js/blob/42ecfef53c25150227256bb0b5daa29af6efd9e7/src/style/style_image.ts#L92-L93
@anonymous
@JS()
extension type ImageSpecification._(JSObject _) implements JSObject {
  /// Create a new [ImageSpecification] object.
  external ImageSpecification({
    required int width,
    required int height,
    required JSUint8Array data,
  });
}

/// The style's image metadata
///
/// https://github.com/maplibre/maplibre-gl-js/blob/42ecfef53c25150227256bb0b5daa29af6efd9e7/src/style/style_image.ts#L58-L59
@anonymous
@JS()
extension type StyleImageMetadata._(JSObject _) implements JSObject {
  /// Create a new [StyleImageMetadata] object.
  external StyleImageMetadata({
    /// The ratio of pixels in the image to physical pixels on the screen
    double? pixelRatio,

    /// Whether the image should be interpreted as an SDF image
    bool? sdf,
  });
}

/// Projection used by [JsMap.setProjection].
///
/// Defaults to mercator. Supports interpolate expressions.
@anonymous
@JS()
extension type ProjectionSpecification._(JSObject _) implements JSObject {
  /// Create a new [ProjectionSpecification] object.
  external ProjectionSpecification({
    /// The projection definition type. Can be specified as a string, a
    /// transition state, or an expression.
    required String type,
  });
}

/// StyleSwapOptions
///
/// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/style/style.ts#L159
@anonymous
@JS()
extension type StyleSwapOptions._(JSObject _) implements JSObject {
  /// Create a new [StyleSwapOptions] object.
  external StyleSwapOptions({
    /// If false, force a 'full' update, removing the current style
    /// and building the given one instead of attempting a diff-based update.
    bool? diff,
  });
}
