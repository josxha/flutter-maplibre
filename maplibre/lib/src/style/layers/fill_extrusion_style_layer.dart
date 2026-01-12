part of 'style_layer.dart';

/// A layer that contains fill extrusions.
///
/// https://maplibre.org/maplibre-style-spec/layers/#fill-extrusion
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class FillExtrusionStyleLayer
    implements StyleLayerWithSource, StyleLayerWithTranslate {
  /// Default constructor for a [FillExtrusionStyleLayer] instance.
  factory FillExtrusionStyleLayer({
    required String id,
    required String sourceId,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
    bool visible = StyleLayer.defaultVisible,
    Expression? filter,
    String? sourceLayerId,
    PropertyValue<double> opacity = defaultOpacity,
    PropertyValue<Color> color = defaultColor,
    PropertyValue<String>? pattern,
    PropertyValue<double> height = defaultHeight,
    PropertyValue<double> base = defaultBase,
    PropertyValue<bool> verticalGradient = defaultVerticalGradient,
    PropertyValue<Offset> translate =
        StyleLayerWithTranslate.defaultTranslate,
    PropertyValue<ReferenceSpace> translateAnchor =
        StyleLayerWithTranslate.defaultTranslateAnchor,
  }) => switch (kIsWeb) {
    true => FillExtrusionStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      minZoom: minZoom,
      maxZoom: maxZoom,
      visible: visible,
      filter: filter,
      sourceLayerId: sourceLayerId,
      opacity: opacity,
      color: color,
      pattern: pattern,
      height: height,
      base: base,
      verticalGradient: verticalGradient,
      translate: translate,
      translateAnchor: translateAnchor,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => FillExtrusionStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        minZoom: minZoom,
        maxZoom: maxZoom,
        visible: visible,
        filter: filter,
        sourceLayerId: sourceLayerId,
        opacity: opacity,
        color: color,
        pattern: pattern,
        height: height,
        base: base,
        verticalGradient: verticalGradient,
        translate: translate,
        translateAnchor: translateAnchor,
      ),
      TargetPlatform.iOS => FillExtrusionStyleLayerIos(
        id: id,
        sourceId: sourceId,
        minZoom: minZoom,
        maxZoom: maxZoom,
        visible: visible,
        filter: filter,
        sourceLayerId: sourceLayerId,
        opacity: opacity,
        color: color,
        pattern: pattern,
        height: height,
        base: base,
        verticalGradient: verticalGradient,
        translate: translate,
        translateAnchor: translateAnchor,
      ),
      _ => throw UnsupportedError(
        'FillExtrusionStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// The opacity of the entire fill extrusion layer. This is rendered on a
  /// per-layer, not per-feature, basis, and data-driven styling is not
  /// available.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports interpolate expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Default value for [opacity].
  static const PropertyValue<double> defaultOpacity =
      PropertyValue<double>.value(1);

  /// The base color of the extruded fill. The extrusion's surfaces will be
  /// shaded differently based on this color in combination with the root light
  /// settings. If this color is specified as `rgba` with an alpha component,
  /// the alpha component will be ignored; use [opacity] to set layer
  /// opacity.
  ///
  /// Paint property. Optional color. Defaults to `"#000000"` (black).
  /// Disabled by [pattern]. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// Default value for [color].
  static const PropertyValue<Color> defaultColor = PropertyValue<Color>.value(
    Color(0xFF000000),
  );

  /// Name of image in sprite to use for drawing images on extruded fills. For
  /// seamless patterns, image width and height must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  ///
  /// Paint property. Optional resolvedImage. Transitionable.
  PropertyValue<String>? get pattern;

  set pattern(PropertyValue<String>? value);

  /// The height with which to extrude this layer.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in meters.
  /// Defaults to `0`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get height;

  set height(PropertyValue<double> value);

  /// Default value for [height].
  static const PropertyValue<double> defaultHeight =
      PropertyValue<double>.value(0);

  /// The height with which to extrude the base of this layer. Must be less
  /// than or equal to [height].
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in meters.
  /// Defaults to `0`. Requires [height]. Supports [featureState] and
  /// [interpolate] expressions. Transitionable.
  PropertyValue<double> get base;

  set base(PropertyValue<double> value);

  /// Default value for [base].
  static const PropertyValue<double> defaultBase = PropertyValue<double>.value(
    0,
  );

  /// Whether to apply a vertical gradient to the sides of a
  /// [FillExtrusionStyleLayer]. If true, sides will be shaded slightly darker
  /// farther down.
  ///
  /// Paint property. Optional boolean. Defaults to `true`.
  PropertyValue<bool> get verticalGradient;

  set verticalGradient(PropertyValue<bool> value);

  /// Default value for [verticalGradient].
  static const PropertyValue<bool> defaultVerticalGradient =
      PropertyValue<bool>.value(true);
}
