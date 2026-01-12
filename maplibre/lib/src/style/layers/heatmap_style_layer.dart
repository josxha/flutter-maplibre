part of 'style_layer.dart';

/// A layer that contains heatmaps.
///
/// https://maplibre.org/maplibre-style-spec/layers/#heatmap
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class HeatmapStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [HeatmapStyleLayer] instance.
  factory HeatmapStyleLayer({
    required String id,
    required String sourceId,
    String? sourceLayerId,
    Expression? filter,
    bool visible = StyleLayer.defaultVisible,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
    PropertyValue<Offset> translate = StyleLayerWithTranslate.defaultTranslate,
    PropertyValue<ReferenceSpace> translateAnchor =
        StyleLayerWithTranslate.defaultTranslateAnchor,
    PropertyValue<double>? sortKey,
    PropertyValue<double> radius = defaultRadius,
    PropertyValue<double> weight = defaultWeight,
    PropertyValue<double> intensity = defaultIntensity,
    PropertyValue<Color>? color,
    PropertyValue<double> opacity = defaultOpacity,
  }) => switch (kIsWeb) {
    true => CircleStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      sourceLayerId: sourceLayerId,
      filter: filter,
      visible: visible,
      minZoom: minZoom,
      maxZoom: maxZoom,
      translate: translate,
      translateAnchor: translateAnchor,
      sortKey: sortKey,
      radius: radius,
      weight: weight,
      intensity: intensity,
      color: color,
      opacity: opacity,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => CircleStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        sourceLayerId: sourceLayerId,
        filter: filter,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        translate: translate,
        translateAnchor: translateAnchor,
        sortKey: sortKey,
        radius: radius,
        weight: weight,
        intensity: intensity,
        color: color,
        opacity: opacity,
      ),
      TargetPlatform.iOS => CircleStyleLayerIos(
        id: id,
        sourceId: sourceId,
        sourceLayerId: sourceLayerId,
        filter: filter,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        translate: translate,
        translateAnchor: translateAnchor,
        sortKey: sortKey,
        radius: radius,
        weight: weight,
        intensity: intensity,
        color: color,
        opacity: opacity,
      ),
      _ => throw UnsupportedError(
        'CircleStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// Radius of influence of one heatmap point in pixels. Increasing the value
  /// makes the heatmap smoother, but less detailed.
  ///
  /// Paint property. Optional number in range `[1, ∞)`. Units in pixels.
  /// Defaults to `30`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get radius;

  set radius(PropertyValue<double> value);

  /// Default value of [radius].
  static const defaultRadius = PropertyValue<double>.value(30);

  /// A measure of how much an individual point contributes to the heatmap.
  /// A value of 10 would be equivalent to having 10 points of weight 1 in the
  /// same spot. Especially useful when combined with clustering.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Defaults to `1`.
  /// Supports [featureState] and [interpolate] expressions.
  PropertyValue<double> get weight;

  set weight(PropertyValue<double> value);

  /// Default value of [weight].
  static const defaultWeight = PropertyValue<double>.value(1);

  /// Similar to [weight] but controls the intensity of the heatmap globally.
  /// Primarily used for adjusting the heatmap based on zoom level.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get intensity;

  set intensity(PropertyValue<double> value);

  /// Default value of [intensity].
  static const defaultIntensity = PropertyValue<double>.value(1);

  /// Defines the color of each pixel based on its density value in a heatmap.
  /// Should be an expression that uses `["heatmap-density"]` as input.
  ///
  /// Paint property. Optional color. Defaults to:
  /// ```json
  /// [
  ///   "interpolate",
  ///   ["linear"],
  ///   ["heatmap-density"],
  ///   0, "rgba(0, 0, 255, 0)",
  ///   0.1,"royalblue",
  ///   0.3,"cyan",
  ///   0.5,"lime",
  ///   0.7,"yellow",
  ///   1,"red"
  /// ]
  /// ```
  /// Supports [interpolate] expressions.
  PropertyValue<Color>? get color;

  set color(PropertyValue<Color>? value);

  /// The global opacity at which the heatmap layer will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Default value of [opacity].
  static const defaultOpacity = PropertyValue<double>.value(1);
}
