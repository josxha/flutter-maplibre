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
    bool visible = true,
    double minZoom = 0,
    double maxZoom = 24,
    PropertyValue<double>? sortKey,
    PropertyValue<bool> antialias = const PropertyValue.value(true),
    PropertyValue<Color> color = const PropertyValue.value(Color(0xFF000000)),
    PropertyValue<double> opacity = const PropertyValue.value(1.0),
    PropertyValue<double> outlineColor = const PropertyValue.value(0xFF000000),
    PropertyValue<List<double>> translate = const PropertyValue.value([0, 0]),
    PropertyValue<ReferenceSpace> translateAnchor = const PropertyValue.value(
      ReferenceSpace.map,
    ),
    PropertyValue<String>? pattern,
  }) => switch (kIsWeb) {
    true => FillStyleLayerWeb(
      id: id,
      visible: visible,
      minZoom: minZoom,
      maxZoom: maxZoom,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => FillStyleLayerAndroid(
        id: id,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      TargetPlatform.iOS => FillStyleLayerIos(
        id: id,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
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

  /// The color of the filled part of this layer. This color can be specified
  /// as `rgba` with an alpha component and the color's opacity will not affect
  /// the opacity of the 1px stroke, if it is used.
  ///
  /// Paint property. Optional color. Defaults to `#000000` (black).
  /// Disabled by [pattern]. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// The opacity of the entire fill layer. In contrast to the fill-color, this
  /// value will also affect the 1px stroke around the fill, if the stroke is
  /// used.
  ///
  /// Paint property. Optional number in range `0,1`. Defaults to `1.0`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// The outline color of the fill. Matches the value of [color] if
  /// unspecified.
  ///
  /// Paint property. Optional color. Disabled by [pattern]. Requires
  /// [antialias] to be `true`. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get outlineColor;

  set outlineColor(PropertyValue<double> value);

  /// Name of image in sprite to use for drawing image fills. For seamless
  /// patterns, image width and height must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  ///
  /// Paint property. Optional resolvedImage. Transitionable.
  PropertyValue<String>? get pattern;

  set pattern(PropertyValue<String>? value);
}
