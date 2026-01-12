part of 'style_layer.dart';

/// A layer that contains hillshades.
///
/// https://maplibre.org/maplibre-style-spec/layers/#hillshade
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class HillshadeStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [HillshadeStyleLayer] instance.
  factory HillshadeStyleLayer({
    required String id,
    required String sourceId,
    String? sourceLayerId,
    Expression? filter,
    bool visible = StyleLayer.defaultVisible,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
    PropertyValue<NumberArray> illuminationDirection =
        defaultIlluminationDirection,
    PropertyValue<NumberArray> illuminationAltitude =
        defaultIlluminationAltitude,
    PropertyValue<IlluminationAnchor> illuminationAnchor =
        defaultIlluminationAnchor,
    PropertyValue<double> exaggeration = defaultExaggeration,
    PropertyValue<Color> shadowColor = defaultShadowColor,
    PropertyValue<Color> highlightColor = defaultHighlightColor,
    PropertyValue<Color> accentColor = defaultAccentColor,
    PropertyValue<HillshadeMethod> method = defaultMethod,
  }) => switch (kIsWeb) {
    true => HillshadeStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      sourceLayerId: sourceLayerId,
      filter: filter,
      visible: visible,
      minZoom: minZoom,
      maxZoom: maxZoom,
      illuminationDirection: illuminationDirection,
      illuminationAltitude: illuminationAltitude,
      illuminationAnchor: illuminationAnchor,
      exaggeration: exaggeration,
      shadowColor: shadowColor,
      highlightColor: highlightColor,
      accentColor: accentColor,
      method: method,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => HillshadeStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        sourceLayerId: sourceLayerId,
        filter: filter,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        illuminationDirection: illuminationDirection,
        illuminationAltitude: illuminationAltitude,
        illuminationAnchor: illuminationAnchor,
        exaggeration: exaggeration,
        shadowColor: shadowColor,
        highlightColor: highlightColor,
        accentColor: accentColor,
        method: method,
      ),
      TargetPlatform.iOS => HillshadeStyleLayerIos(
        id: id,
        sourceId: sourceId,
        sourceLayerId: sourceLayerId,
        filter: filter,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        illuminationDirection: illuminationDirection,
        illuminationAltitude: illuminationAltitude,
        illuminationAnchor: illuminationAnchor,
        exaggeration: exaggeration,
        shadowColor: shadowColor,
        highlightColor: highlightColor,
        accentColor: accentColor,
        method: method,
      ),
      _ => throw UnsupportedError(
        'HillshadeStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// The direction of the light source(s) used to generate the hillshading with
  /// `0` as the top of the viewport if [illuminationAnchor] is set to
  /// [IlluminationAnchor.viewport] and due north if [illuminationAnchor] is set
  /// to [IlluminationAnchor.map].
  ///
  /// {@template multiple-light-sources-notice}
  /// Only when [method] is set to [HillshadeMethod.multidirectional] can you
  /// specify multiple light sources.
  /// {@endtemplate}
  ///
  /// Paint property. Optional [NumberArray] with value(s) in range `[0, 359]`.
  /// Defaults to `335`. Supports [interpolate] expressions.
  PropertyValue<NumberArray> get illuminationDirection;

  set illuminationDirection(PropertyValue<NumberArray> value);

  /// Default value of [illuminationDirection].
  static const defaultIlluminationDirection = PropertyValue<NumberArray>.value(
    NumberArray.number(335),
  );

  /// The altitude of the light source(s) used to generate the hillshading with
  /// `0` as sunset and `90` as noon.
  ///
  /// {@macro multiple-light-sources-notice}
  ///
  /// Paint property. Optional [NumberArray] with value(s) in range `[0, 90]`.
  /// Defaults to `45`. Supports interpolate expressions.
  PropertyValue<NumberArray> get illuminationAltitude;

  set illuminationAltitude(PropertyValue<NumberArray> value);

  /// Default value of [illuminationAltitude].
  static const defaultIlluminationAltitude = PropertyValue<NumberArray>.value(
    NumberArray.number(45),
  );

  /// {@macro illumination-anchor}
  ///
  /// Paint property. Optional enum. Defaults to [IlluminationAnchor.viewport].
  PropertyValue<IlluminationAnchor> get illuminationAnchor;

  set illuminationAnchor(PropertyValue<IlluminationAnchor> value);

  /// Default value of [illuminationAnchor].
  static const defaultIlluminationAnchor =
      PropertyValue<IlluminationAnchor>.value(IlluminationAnchor.viewport);

  /// Intensity of the hillshade
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `0.5`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get exaggeration;

  set exaggeration(PropertyValue<double> value);

  /// Default value of [exaggeration].
  static const defaultExaggeration = PropertyValue<double>.value(0.5);

  /// The shading color of areas that face away from the light source(s).
  ///
  /// {@macro multiple-light-sources-notice}
  ///
  /// Paint property. Optional [ColorArray]. Defaults to `"#000000"`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<Color> get shadowColor;

  set shadowColor(PropertyValue<Color> value);

  /// Default value of [shadowColor].
  static const defaultShadowColor = PropertyValue<Color>.value(
    Color(0xFF000000),
  );

  /// The shading color of areas that faces towards the light source(s).
  ///
  /// {@macro multiple-light-sources-notice}
  ///
  /// Paint property. Optional [ColorArray]. Defaults to `"#FFFFFF"`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<Color> get highlightColor;

  set highlightColor(PropertyValue<Color> value);

  /// Default value of [highlightColor].
  static const defaultHighlightColor = PropertyValue<Color>.value(
    Color(0xFFFFFFFF),
  );

  /// The shading color used to accentuate rugged terrain like sharp cliffs and
  /// gorges.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<Color> get accentColor;

  set accentColor(PropertyValue<Color> value);

  /// Default value of [accentColor].
  static const defaultAccentColor = PropertyValue<Color>.value(
    Color(0xFF000000),
  );

  /// {@macro hillshade-method}
  ///
  /// Paint property. Optional enum. Defaults to [HillshadeMethod.standard].
  PropertyValue<HillshadeMethod> get method;

  set method(PropertyValue<HillshadeMethod> value);

  /// Default value of [method].
  static const defaultMethod = PropertyValue<HillshadeMethod>.value(
    HillshadeMethod.standard,
  );
}

/// {@template illumination-anchor}
/// Direction of light source when map is rotated.
/// {@endtemplate}
enum IlluminationAnchor {
  /// The hillshade illumination is relative to the north direction.
  map,

  /// The hillshade illumination is relative to the top of the viewport.
  viewport,
}

/// {@template hillshade-method}
/// The hillshade algorithm to use.
/// ![Preview](https://maplibre.org/maplibre-style-spec/assets/hillshade_methods.png)
/// {@endtemplate}
enum HillshadeMethod {
  /// The legacy hillshade method.
  standard,

  /// Basic hillshade. Uses a simple physics model where the reflected light
  /// intensity is proportional to the cosine of the angle between the incident
  /// light and the surface normal. Similar to GDAL's `gdaldem` default
  /// algorithm.
  basic,

  /// Hillshade algorithm whose intensity scales with slope. Similar to GDAL's
  /// `gdaldem` with `-combined` option.
  combined,

  /// Hillshade algorithm which tries to minimize effects on other map features
  /// beneath. Similar to GDAL's `gdaldem` with `-igor` option.
  igor,

  /// Hillshade with multiple illumination directions. Uses the basic hillshade
  /// model with multiple independent light sources.
  multidirectional,
}
