part of 'style_layer.dart';

/// A layer that contains lines.
///
/// https://maplibre.org/maplibre-style-spec/layers/#line
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class LineStyleLayer
    implements
        StyleLayerWithSource,
        StyleLayerWithSortKey,
        StyleLayerWithTranslate {
  /// Default constructor for a [LineStyleLayer] instance.
  factory LineStyleLayer({
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
    PropertyValue<LineCap> lineCap = defaultCap,
    PropertyValue<LineJoin> join = defaultJoin,
    PropertyValue<double> miterLimit = defaultMiterLimit,
    PropertyValue<double> roundLimit = defaultRoundLimit,
    PropertyValue<double> opacity = defaultOpacity,
    PropertyValue<Color> color = defaultColor,
    PropertyValue<double> width = defaultWidth,
    PropertyValue<double> gapWidth = defaultGapWidth,
    PropertyValue<double> offset = defaultOffset,
    PropertyValue<double> blur = defaultBlur,
    PropertyValue<List<double>>? dashArray,
    PropertyValue<String>? pattern,
    PropertyValue<Color>? gradient,
  }) => switch (kIsWeb) {
    true => LineStyleLayerWeb(
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
      cap: lineCap,
      join: join,
      miterLimit: miterLimit,
      roundLimit: roundLimit,
      opacity: opacity,
      color: color,
      width: width,
      gapWidth: gapWidth,
      offset: offset,
      blur: blur,
      dashArray: dashArray,
      pattern: pattern,
      gradient: gradient,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => LineStyleLayerAndroid(
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
        cap: lineCap,
        join: join,
        miterLimit: miterLimit,
        roundLimit: roundLimit,
        opacity: opacity,
        color: color,
        width: width,
        gapWidth: gapWidth,
        offset: offset,
        blur: blur,
        dashArray: dashArray,
        pattern: pattern,
        gradient: gradient,
      ),
      TargetPlatform.iOS => LineStyleLayerIos(
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
        cap: lineCap,
        join: join,
        miterLimit: miterLimit,
        roundLimit: roundLimit,
        opacity: opacity,
        color: color,
        width: width,
        gapWidth: gapWidth,
        offset: offset,
        blur: blur,
        dashArray: dashArray,
        pattern: pattern,
        gradient: gradient,
      ),
      _ => throw UnsupportedError(
        'LineStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// {@macro line-cap}
  ///
  /// Layout property. Optional enum. Defaults to [LineCap.butt].
  PropertyValue<LineCap> get cap;

  set cap(PropertyValue<LineCap> value);

  /// Default value for [cap].
  static const defaultCap = PropertyValue<LineCap>.value(LineCap.butt);

  /// {@macro line-join}
  ///
  /// Layout property. Optional enum. Defaults to [LineJoin.miter].
  PropertyValue<LineJoin> get join;

  set join(PropertyValue<LineJoin> value);

  /// Default value for [join].
  static const defaultJoin = PropertyValue<LineJoin>.value(LineJoin.miter);

  /// Used to automatically convert miter joins to bevel joins for sharp angles.
  ///
  /// Layout property. Optional number. Defaults to 2. Requires [join] to be
  /// miter. Supports [interpolate] expressions.
  PropertyValue<double> get miterLimit;

  set miterLimit(PropertyValue<double> value);

  /// Default value for [miterLimit].
  static const defaultMiterLimit = PropertyValue<double>.value(2);

  /// Used to automatically convert round joins to miter joins for shallow
  /// angles.
  ///
  /// Layout property. Optional number. Defaults to `1.05`. Requires [join] to
  /// be [LineJoin.round]. Supports [interpolate] expressions.
  PropertyValue<double> get roundLimit;

  set roundLimit(PropertyValue<double> value);

  /// Default value for [roundLimit].
  static const defaultRoundLimit = PropertyValue<double>.value(1.05);

  /// The opacity at which the line will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Default value of [opacity].
  static const defaultOpacity = PropertyValue<double>.value(1);

  /// The color with which the line will be drawn.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"` (black).
  /// Disabled by [pattern]. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// Default value of [color].
  static const defaultColor = PropertyValue<Color>.value(Color(0xFF000000));

  /// Stroke thickness.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `1`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get width;

  set width(PropertyValue<double> value);

  /// Default value of [width].
  static const defaultWidth = PropertyValue<double>.value(1);

  /// Draws a line casing outside of a line's actual path. Value indicates the
  /// width of the inner gap.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<double> get gapWidth;

  set gapWidth(PropertyValue<double> value);

  /// Default value of [gapWidth].
  static const defaultGapWidth = PropertyValue<double>.value(0);

  /// The line's offset. For linear features, a positive value offsets the line
  /// to the right, relative to the direction of the line, and a negative value
  /// to the left. For polygon features, a positive value results in an inset,
  /// and a negative value results in an outset.
  ///
  /// Paint property. Optional number. Units in pixels. Defaults to `0`.
  /// Supports [featureState] and [interpolate] expressions. Transitionable.
  PropertyValue<double> get offset;

  set offset(PropertyValue<double> value);

  /// Default value of [offset].
  static const defaultOffset = PropertyValue<double>.value(0);

  /// Blur applied to the line, in pixels.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Supports feature-state and interpolate expressions.
  /// Transitionable.
  PropertyValue<double> get blur;

  set blur(PropertyValue<double> value);

  /// Default value of [blur].
  static const defaultBlur = PropertyValue<double>.value(0);

  /// Specifies the lengths of the alternating dashes and gaps that form the
  /// dash pattern. The lengths are later scaled by the line width. To convert
  /// a dash length to pixels, multiply the length by the current line width.
  /// GeoJSON sources with lineMetrics: true specified won't render dashed lines
  /// to the expected scale. Zoom-dependent expressions will be evaluated only
  /// at integer zoom levels. The only way to create an array value is using
  /// `["literal", [...]]`; arrays cannot be read from or derived from feature
  /// properties.
  ///
  /// Paint property. Optional array in range [0, ∞). Units in line widths.
  /// Disabled by line-pattern. Transitionable.
  PropertyValue<List<double>>? get dashArray;

  set dashArray(PropertyValue<List<double>>? value);

  /// Name of image in sprite to use for drawing image lines. For seamless
  /// patterns, image width must be a factor of two (2, 4, 8, ..., 512). Note that
  /// zoom-dependent expressions will be evaluated only at integer zoom levels.
  ///
  /// Paint property. Optional `resolvedImage` string. Transitionable.
  PropertyValue<String>? get pattern;

  set pattern(PropertyValue<String>? value);

  /// Defines a gradient with which to color a line feature. Can only be used
  /// with GeoJSON sources that specify "lineMetrics": true.
  ///
  /// Paint property. Optional [Color]. Disabled by [dashArray]. Disabled by
  /// [pattern]. Requires source to be geojson. Supports [interpolate]
  /// expressions.
  PropertyValue<Color>? get gradient;

  set gradient(PropertyValue<Color>? value);
}

/// {@template line-cap}
/// The display of line endings.
/// {@endtemplate}
enum LineCap {
  /// A cap with a squared-off end which is drawn to the exact endpoint of the line.
  butt,

  /// A cap with a rounded end which is drawn beyond the endpoint of the line at a radius of one-half of the line's width and centered on the endpoint of the line.
  round,

  /// A cap with a squared-off end which is drawn beyond the endpoint of the line at a distance of one-half of the line's width.
  square,
}

/// {@template line-join}
/// The display of lines when joining.
/// {@endtemplate}
enum LineJoin {
  /// A join with a squared-off end which is drawn beyond the endpoint of the
  /// line at a distance of one-half of the line's width.
  bevel,

  /// A join with a rounded end which is drawn beyond the endpoint of the line
  /// at a radius of one-half of the line's width and centered on the endpoint
  /// of the line.
  round,

  /// A join with a sharp, angled corner which is drawn with the outer sides
  /// beyond the endpoint of the path until they meet.
  miter,
}
