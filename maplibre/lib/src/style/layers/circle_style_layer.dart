part of 'style_layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class CircleStyleLayer
    implements
        StyleLayerWithSource,
        StyleLayerWithSortKey,
        StyleLayerWithTranslate {
  /// Create a platform-specific implementation of [CircleStyleLayer].
  factory CircleStyleLayer({
    required String id,
    bool visible = true,
    double minZoom = 0,
    double maxZoom = 24,
  }) => switch (kIsWeb) {
    true => CircleStyleLayerWeb(
      id: id,
      visible: visible,
      minZoom: minZoom,
      maxZoom: maxZoom,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => CircleStyleLayerAndroid(
        id: id,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      TargetPlatform.iOS => CircleStyleLayerIos(
        id: id,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      _ => throw UnsupportedError(
        'CircleStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// The radius of the circle.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `5`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get radius;

  set radius(PropertyValue<double> value);

  /// The fill color of the circle.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"` (black).
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// centerpoint is full opacity.
  ///
  /// Paint property. Optional number. Defaults to `0`. Supports [featureState]
  /// and [interpolate] expressions. Transitionable.
  PropertyValue<double> get blur;

  set blur(PropertyValue<double> value);

  /// The opacity at which the circle will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Controls the scaling behavior of the circle when the map is pitched.
  ///
  /// Paint property. Optional enum. Defaults to [ReferenceSpace.map].
  PropertyValue<ReferenceSpace> get pitchScale;

  set pitchScale(PropertyValue<ReferenceSpace> value);

  /// Orientation of circle when map is pitched.
  ///
  /// Paint property. Optional enum. Defaults to [ReferenceSpace.viewport].
  PropertyValue<ReferenceSpace> get pitchAlignment;

  set pitchAlignment(PropertyValue<ReferenceSpace> value);

  /// The width of the circle's stroke. Strokes are placed outside of
  /// the [radius].
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get strokeWidth;

  set strokeWidth(PropertyValue<double> value);

  /// The stroke color of the circle.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"`. Supports
  /// [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<Color> get strokeColor;

  set strokeColor(PropertyValue<Color> value);

  /// The opacity of the circle's stroke.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get strokeOpacity;

  set strokeOpacity(PropertyValue<double> value);
}
