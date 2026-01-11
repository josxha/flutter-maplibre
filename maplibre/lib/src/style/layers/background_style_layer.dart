part of 'style_layer.dart';

/// A simple background layer.
///
/// https://maplibre.org/maplibre-style-spec/layers/#background
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class BackgroundStyleLayer extends StyleLayer {
  /// Create a platform-specific implementation of [BackgroundStyleLayer].
  factory BackgroundStyleLayer({
    required String id,
    bool visible = true,
    PropertyValue<Color> color = const PropertyValue<Color>.value(
      Color(0xFF000000),
    ),
    PropertyValue<String>? pattern,
    PropertyValue<double> opacity = const PropertyValue.value(1),
    double minZoom = 0,
    double maxZoom = 24,
  }) => switch (defaultTargetPlatform) {
    TargetPlatform.android => BackgroundStyleLayerAndroid(
      id: id,
      visible: visible,
      color: color,
      pattern: pattern,
      opacity: opacity,
      minZoom: minZoom,
      maxZoom: maxZoom,
    ),
    /*TargetPlatform.iOS || TargetPlatform.macOS => IosBackgroundStyleLayer(
      id: id,
      visible: visible,
      color: color,
      pattern: pattern,
      opacity: opacity,
      minZoom: minZoom,
      maxZoom: maxZoom,
    ),*/
    _ => throw UnsupportedError(
      'BackgroundStyleLayer is not supported for the current platform.',
    ),
  };

  /// Whether this layer is displayed.
  ///
  /// Defaults to true ("visible").
  bool get visible;

  set visible(bool value);

  /// The color with which the background will be drawn.
  ///
  /// Defaults to #000000 (black).
  PropertyValue<Color> get color;

  /// Sets the color with which the background will be drawn.
  set color(PropertyValue<Color> value);

  /// Name of image in sprite to use for drawing an image background. For
  /// seamless patterns, image width and height must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  PropertyValue<String>? get pattern;

  set pattern(PropertyValue<String>? value);

  /// The opacity at which the background will be drawn.
  ///
  /// Defaults to 1.0.
  PropertyValue<double> get opacity;

  /// Sets the opacity at which the background will be drawn.
  set opacity(PropertyValue<double> value);
}
