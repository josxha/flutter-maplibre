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
    PropertyValue<Color> color = defaultColor,
    PropertyValue<double> blur = defaultBlur,
    PropertyValue<double> opacity = defaultOpacity,
    PropertyValue<ReferenceSpace> pitchScale = defaultPitchScale,
    PropertyValue<ReferenceSpace> pitchAlignment = defaultPitchAlignment,
    PropertyValue<double> strokeWidth = defaultStrokeWidth,
    PropertyValue<Color> strokeColor = defaultStrokeColor,
    PropertyValue<double> strokeOpacity = defaultStrokeOpacity,
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
      color: color,
      blur: blur,
      opacity: opacity,
      pitchScale: pitchScale,
      pitchAlignment: pitchAlignment,
      strokeWidth: strokeWidth,
      strokeColor: strokeColor,
      strokeOpacity: strokeOpacity,
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
        color: color,
        blur: blur,
        opacity: opacity,
        pitchScale: pitchScale,
        pitchAlignment: pitchAlignment,
        strokeWidth: strokeWidth,
        strokeColor: strokeColor,
        strokeOpacity: strokeOpacity,
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
        color: color,
        blur: blur,
        opacity: opacity,
        pitchScale: pitchScale,
        pitchAlignment: pitchAlignment,
        strokeWidth: strokeWidth,
        strokeColor: strokeColor,
        strokeOpacity: strokeOpacity,
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

  /// The default value of [radius].
  static const defaultRadius = PropertyValue<double>.value(5);

  /// The fill color of the circle.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"` (black).
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// The default value of [color].
  static const defaultColor = PropertyValue<Color>.value(Color(0xFF000000));

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// centerpoint is full opacity.
  ///
  /// Paint property. Optional number. Defaults to `0`. Supports [featureState]
  /// and [interpolate] expressions. Transitionable.
  PropertyValue<double> get blur;

  set blur(PropertyValue<double> value);

  /// The default value of [blur].
  static const defaultBlur = PropertyValue<double>.value(0);

  /// The opacity at which the circle will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// The default value of [opacity].
  static const defaultOpacity = PropertyValue<double>.value(1);

  /// Controls the scaling behavior of the circle when the map is pitched.
  ///
  /// Paint property. Optional enum. Defaults to [ReferenceSpace.map].
  PropertyValue<ReferenceSpace> get pitchScale;

  set pitchScale(PropertyValue<ReferenceSpace> value);

  /// The default value of [pitchScale].
  static const defaultPitchScale = PropertyValue<ReferenceSpace>.value(
    ReferenceSpace.map,
  );

  /// Orientation of circle when map is pitched.
  ///
  /// Paint property. Optional enum. Defaults to [ReferenceSpace.viewport].
  PropertyValue<ReferenceSpace> get pitchAlignment;

  set pitchAlignment(PropertyValue<ReferenceSpace> value);

  /// The default value of [pitchAlignment].
  static const defaultPitchAlignment = PropertyValue<ReferenceSpace>.value(
    ReferenceSpace.viewport,
  );

  /// The width of the circle's stroke. Strokes are placed outside of
  /// the [radius].
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get strokeWidth;

  set strokeWidth(PropertyValue<double> value);

  /// The default value of [strokeWidth].
  static const defaultStrokeWidth = PropertyValue<double>.value(0);

  /// The stroke color of the circle.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"`. Supports
  /// [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<Color> get strokeColor;

  set strokeColor(PropertyValue<Color> value);

  /// The default value of [strokeColor].
  static const defaultStrokeColor = PropertyValue<Color>.value(
    Color(0xFF000000),
  );

  /// The opacity of the circle's stroke.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get strokeOpacity;

  set strokeOpacity(PropertyValue<double> value);

  /// The default value of [strokeOpacity].
  static const defaultStrokeOpacity = PropertyValue<double>.value(1);
}
