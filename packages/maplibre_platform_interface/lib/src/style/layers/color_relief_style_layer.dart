part of 'style_layer.dart';

/// A layer that renders elevation-based color gradients (color relief) from a
/// raster or DEM source.
///
/// https://maplibre.org/maplibre-style-spec/layers/#color-relief
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class ColorReliefStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [ColorReliefStyleLayer] instance.
  factory ColorReliefStyleLayer({
    required String id,
    required String sourceId,
    bool visible = StyleLayer.defaultVisible,
    PropertyValue<Color>? color,
    PropertyValue<double> opacity = ColorReliefStyleLayer.defaultOpacity,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
  }) => MapLibrePlatform.instance.createColorReliefStyleLayer(
    id: id,
    sourceId: sourceId,
    visible: visible,
    color: color,
    opacity: opacity,
    minZoom: minZoom,
    maxZoom: maxZoom,
  );

  /// The opacity at which the color-relief will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [Expression.interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> property);

  /// Default value for [opacity].
  static const defaultOpacity = PropertyValue<double>.value(1);

  /// Defines the color of each pixel based on its elevation. Should be an
  /// [Expression] that uses `["elevation"]` as input. For example:
  /// ```json
  /// "color-relief-color": [
  ///    "interpolate",
  ///    ["linear"],
  ///    ["elevation"],
  ///    0,
  ///    "black",
  ///    8849,
  ///    "white"
  /// ]
  /// ```
  ///
  /// Paint property. Optional [Color]. Supports [Expression.interpolate] expressions.
  PropertyValue<Color>? get color;

  set color(PropertyValue<Color>? property);
}
