part of 'style_layer.dart';


/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#color-relief
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class ColorReliefStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [ColorReliefStyleLayer] instance.
  factory ColorReliefStyleLayer({
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.metadata,
  });

  /// The opacity at which the color-relief will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

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
  /// Paint property. Optional [Color]. Supports [interpolate] expressions.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

}
