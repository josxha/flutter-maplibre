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
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.filter,
    super.metadata,
    super.sourceLayerId,
  });

  /// The opacity of the entire fill extrusion layer. This is rendered on a
  /// per-layer, not per-feature, basis, and data-driven styling is not
  /// available.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports interpolate expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

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

  /// The height with which to extrude the base of this layer. Must be less
  /// than or equal to [height].
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in meters.
  /// Defaults to `0`. Requires [height]. Supports [featureState] and
  /// [interpolate] expressions. Transitionable.
  PropertyValue<double> get base;

  set base(PropertyValue<double> value);

  /// Whether to apply a vertical gradient to the sides of a
  /// [FillExtrusionStyleLayer]. If true, sides will be shaded slightly darker
  /// farther down.
  ///
  /// Paint property. Optional boolean. Defaults to `true`.
  PropertyValue<bool> get verticalGradient;

  set verticalGradient(PropertyValue<bool> value);
}
