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
    required String id,
    required String sourceId,
    bool visible = StyleLayer.defaultVisible,
    PropertyValue<Color>? color,
    PropertyValue<String>? pattern,
    PropertyValue<double> opacity = ColorReliefStyleLayer.defaultOpacity,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
  }) => switch (kIsWeb) {
    true => ColorReliefStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      visible: visible,
      color: color,
      pattern: pattern,
      opacity: opacity,
      minZoom: minZoom,
      maxZoom: maxZoom,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => ColorReliefStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        visible: visible,
        color: color,
        pattern: pattern,
        opacity: opacity,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      TargetPlatform.iOS => ColorReliefStyleLayerIos(
        id: id,
        sourceId: sourceId,
        visible: visible,
        color: color,
        pattern: pattern,
        opacity: opacity,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      _ => throw UnsupportedError(
        'ColorReliefStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// The opacity at which the color-relief will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

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
  /// Paint property. Optional [Color]. Supports [interpolate] expressions.
  PropertyValue<Color>? get color;

  set color(PropertyValue<Color>? value);
}
