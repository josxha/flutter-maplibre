part of 'style_layer.dart';

/// A layer that contains polygons.
///
/// https://maplibre.org/maplibre-style-spec/layers/#fill
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class FillStyleLayer
    implements
        StyleLayerWithSource,
        StyleLayerWithSortKey,
        StyleLayerWithTranslate {
  /// Create a platform-specific implementation of [FillStyleLayer].
  factory FillStyleLayer({
    required String id,
    required String sourceId,
    bool visible = StyleLayer.defaultVisible,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
    String? sourceLayerId,
    Expression? filter,
    PropertyValue<double>? sortKey,
    PropertyValue<Offset> translate = StyleLayerWithTranslate.defaultTranslate,
    PropertyValue<ReferenceSpace> translateAnchor =
        StyleLayerWithTranslate.defaultTranslateAnchor,
    PropertyValue<bool> antialias = defaultAntialias,
    PropertyValue<Color> color = defaultColor,
    PropertyValue<double> opacity = defaultOpacity,
    PropertyValue<Color> outlineColor = defaultOutlineColor,
    PropertyValue<String>? pattern,
  }) => switch (kIsWeb) {
    true => FillStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      visible: visible,
      minZoom: minZoom,
      maxZoom: maxZoom,
      sourceLayerId: sourceLayerId,
      filter: filter,
      sortKey: sortKey,
      translate: translate,
      translateAnchor: translateAnchor,
      antialias: antialias,
      color: color,
      opacity: opacity,
      outlineColor: outlineColor,
      pattern: pattern,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => FillStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        sourceLayerId: sourceLayerId,
        filter: filter,
        sortKey: sortKey,
        translate: translate,
        translateAnchor: translateAnchor,
        antialias: antialias,
        color: color,
        opacity: opacity,
        outlineColor: outlineColor,
        pattern: pattern,
      ),
      TargetPlatform.iOS => FillStyleLayerIos(
        id: id,
        sourceId: sourceId,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        sourceLayerId: sourceLayerId,
        filter: filter,
        sortKey: sortKey,
        translate: translate,
        translateAnchor: translateAnchor,
        antialias: antialias,
        color: color,
        opacity: opacity,
        outlineColor: outlineColor,
        pattern: pattern,
      ),
      _ => throw UnsupportedError(
        'FillStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// Whether or not the fill should be antialiased.
  ///
  /// Paint property. Optional boolean. Defaults to `true`.
  PropertyValue<bool> get antialias;

  set antialias(PropertyValue<bool> value);

  /// Default value of [antialias].
  static const defaultAntialias = PropertyValue<bool>.value(true);

  /// The color of the filled part of this layer. This color can be specified
  /// as `rgba` with an alpha component and the color's opacity will not affect
  /// the opacity of the 1px stroke, if it is used.
  ///
  /// Paint property. Optional color. Defaults to `#000000` (black).
  /// Disabled by [pattern]. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// Default value of [color].
  static const defaultColor = PropertyValue<Color>.value(Color(0xFF000000));

  /// The opacity of the entire fill layer. In contrast to the fill-color, this
  /// value will also affect the 1px stroke around the fill, if the stroke is
  /// used.
  ///
  /// Paint property. Optional number in range `0,1`. Defaults to `1.0`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Default value of [opacity].
  static const defaultOpacity = PropertyValue<double>.value(1);

  /// The outline color of the fill. Matches the value of [color] if
  /// unspecified.
  ///
  /// Paint property. Optional color. Disabled by [pattern]. Requires
  /// [antialias] to be `true`. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get outlineColor;

  set outlineColor(PropertyValue<double> value);

  /// Default value of [outlineColor].
  static const defaultOutlineColor = PropertyValue<Color>.value(
    Color(0xFF000000),
  );

  /// Name of image in sprite to use for drawing image fills. For seamless
  /// patterns, image width and height must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  ///
  /// Paint property. Optional resolvedImage. Transitionable.
  PropertyValue<String>? get pattern;

  set pattern(PropertyValue<String>? value);
}
