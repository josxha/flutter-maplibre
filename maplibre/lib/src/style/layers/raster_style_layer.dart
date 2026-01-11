part of 'style_layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class RasterStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [RasterStyleLayer] instance.
  factory RasterStyleLayer({
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.metadata,
  });

  /// The opacity at which the image will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Rotates hues around the color wheel.
  ///
  /// Paint property. Optional number. Units in degrees. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get hueRotate;

  set hueRotate(PropertyValue<double> value);

  /// Increase or reduce the brightness of the image. The value is the minimum
  /// brightness.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get brightnessMin;

  set brightnessMin(PropertyValue<double> value);

  /// Increase or reduce the brightness of the image. The value is the maximum
  /// brightness.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get brightnessMax;

  set brightnessMax(PropertyValue<double> value);

  /// Increase or reduce the saturation of the image.
  ///
  /// Paint property. Optional number in range `[-1, 1]`. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get saturation;

  set saturation(PropertyValue<double> value);

  /// Increase or reduce the contrast of the image.
  ///
  /// Paint property. Optional number in range `[-1, 1]`. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get contrast;

  set contrast(PropertyValue<double> value);

  /// {@macro raster-resampling}
  ///
  /// Paint property. Optional enum. Defaults to "linear".
  PropertyValue<RasterResampling> get resampling;

  set resampling(PropertyValue<RasterResampling> value);

  /// Fade duration when a new tile is added, or when a video is started or its
  /// coordinates are updated.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in milliseconds.
  /// Defaults to `300`. Supports [interpolate] expressions.
  PropertyValue<double> get fadeDuration;

  set fadeDuration(PropertyValue<double> value);
}

/// {@template raster-resampling}
/// The resampling/interpolation method to use for overscaling, also known as
/// texture magnification filter.
/// {@endtemplate}
enum RasterResampling {
  /// (Bi)linear filtering interpolates pixel values using the weighted average
  /// of the four closest original source pixels creating a smooth but blurry
  /// look when overscaled.
  linear,

  /// Nearest neighbor filtering interpolates pixel values using the nearest
  /// original source pixel creating a sharp but pixelated look when overscaled.
  nearest,
}