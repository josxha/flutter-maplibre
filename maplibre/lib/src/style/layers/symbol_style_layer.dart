part of 'style_layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class SymbolStyleLayer
    implements StyleLayerWithSource, StyleLayerWithSortKey {
  /// Default constructor for a [SymbolStyleLayer] instance.
  factory SymbolStyleLayer({
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.filter,
    super.metadata,
    super.sourceLayerId,
  });

  /// {@macro symbol-placement}
  ///
  /// Layout property. Optional enum. Defaults to [SymbolPlacement.point].
  PropertyValue<SymbolPlacement> get placement;

  set placement(PropertyValue<SymbolPlacement> value);

  /// Distance between two symbol anchors.
  ///
  /// Layout property. Optional number in range `[1, ∞)`. Units in pixels.
  /// Defaults to `250`. Requires [placement] to be line. Supports [interpolate]
  /// expressions.
  PropertyValue<double> get spacing;

  set spacing(PropertyValue<double> value);

  /// If true, the symbols will not cross tile edges to avoid mutual collisions.
  /// Recommended in layers that don't have enough padding in the vector tile to
  /// prevent collisions, or if it is a point symbol layer placed after a line
  /// symbol layer. When using a client that supports global collision
  /// detection, like MapLibre GL JS version 0.42.0 or greater, enabling this
  /// property is not needed to prevent clipped labels at tile boundaries.
  ///
  /// Layout property. Optional boolean. Defaults to `false`.
  PropertyValue<bool> get avoidEdges;

  set avoidEdges(PropertyValue<bool> value);

  /// {@macro symbol-z-order}
  ///
  /// Layout property. Optional enum. Defaults to [SymbolZOrder.auto].
  PropertyValue<SymbolZOrder> get zOrder;

  set zOrder(PropertyValue<SymbolZOrder> value);

  /// If true, the icon will be visible even if it collides with other
  /// previously drawn symbols.
  ///
  /// Layout property. Optional boolean. Defaults to `false`.
  /// Requires [iconImage]. Disabled by icon-overlap.
  PropertyValue<bool> get iconAllowOverlap;

  set iconAllowOverlap(PropertyValue<bool> value);

  /// Allows for control over whether to show an icon when it overlaps other
  /// symbols on the map. If [iconOverlap] is not set, [iconAllowOverlap] is
  /// used instead.
  ///
  /// Layout property. Optional enum. Requires [iconImage].
  PropertyValue<SymbolOverlap> get iconOverlap;

  set iconOverlap(PropertyValue<SymbolOverlap> value);

  /// If true, other symbols can be visible even if they collide with the icon.
  ///
  /// Layout property. Optional boolean. Defaults to `false`.
  /// Requires [iconImage].
  PropertyValue<bool> get iconIgnorePlacement;

  set iconIgnorePlacement(PropertyValue<bool> value);

  /// If true, text will display without their corresponding icons when the
  /// icon collides with other symbols and the text does not.
  ///
  /// Layout property. Optional boolean. Defaults to `false`.
  /// Requires [iconImage]. Requires [textField].
  PropertyValue<bool> get iconOptional;

  set iconOptional(PropertyValue<bool> value);

  /// {@macro icon-rotation-alignment}
  ///
  /// Layout property. Optional enum. Defaults to "auto". Requires [iconImage].
  PropertyValue<IconRotationAlignment> get iconRotationAlignment;

  set iconRotationAlignment(PropertyValue<IconRotationAlignment> value);

  /// Scales the original size of the icon by the provided factor. The new
  /// pixel size of the image will be the original pixel size multiplied by
  /// [iconSize]. 1 is the original size; 3 triples the size of the image.
  ///
  /// Layout property. Optional number in range `[0, ∞)`. Units in factor of
  /// the original icon size. Defaults to `1`. Requires [iconImage]. Supports
  /// [interpolate] expressions.
  PropertyValue<double> get iconSize;

  set iconSize(PropertyValue<double> value);

  /// {@macro icon-text-fit}
  ///
  /// Layout property. Optional enum. Defaults to [IconTextFit.none].
  /// Requires [iconImage]. Requires [textField].
  PropertyValue<IconTextFit> get iconTextFit;

  set iconTextFit(PropertyValue<IconTextFit> value);

  /// Size of the additional area added to dimensions determined by
  /// [iconTextFit], in clockwise order: top, right, bottom, left.
  ///
  /// Layout property. Optional array. Units in pixels. Defaults to
  /// [EdgeInsets.zero]. Requires [iconImage]. Requires [textField]. Requires
  /// [iconTextFit] to be one of [IconTextFit.both], [IconTextFit.width],
  /// [IconTextFit.height]. Supports [interpolate] expressions.
  PropertyValue<EdgeInsets> get iconTextFitPadding;

  set iconTextFitPadding(PropertyValue<EdgeInsets> value);

  /// Name of image in sprite to use for drawing an image background.
  ///
  /// Layout property. Optional resolvedImage.
  PropertyValue<String>? get iconImage;

  set iconImage(PropertyValue<String>? value);

  /// Rotates the icon clockwise.
  ///
  /// Layout property. Optional number. Units in degrees. Defaults to `0`.
  /// Requires [iconImage]. Supports [interpolate] expressions.
  PropertyValue<double> get iconRotate;

  set iconRotate(PropertyValue<double> value);

  /// Size of additional area round the icon bounding box used for detecting
  /// symbol collisions.
  ///
  /// Layout property. Optional padding. Units in pixels. Defaults to `[2]`.
  /// Requires [iconImage]. Supports [interpolate] expressions.
  PropertyValue<EdgeInsets> get iconPadding;

  set iconPadding(PropertyValue<EdgeInsets> value);

  /// If true, the icon may be flipped to prevent it from being rendered
  /// upside-down.
  ///
  /// Layout property. Optional boolean. Defaults to `false`. Requires
  /// [iconImage]. Requires [iconRotationAlignment] to be
  /// [IconRotationAlignment.map]. Requires [placement] to be one of
  /// [SymbolPlacement.line], [SymbolPlacement.lineCenter].
  PropertyValue<bool> get iconKeepUpright;

  set iconKeepUpright(PropertyValue<bool> value);

  /// Offset distance of icon from its anchor. Positive values indicate right
  /// and down, while negative values indicate left and up. Each component is
  /// multiplied by the value of [iconSize] to obtain the final offset in
  /// pixels. When combined with [iconRotate] the offset will be as if the
  /// rotated direction was up.
  ///
  /// Layout property. Optional array. Defaults to [Offset.zero]. Requires
  /// [iconImage]. Supports [interpolate] expressions.
  PropertyValue<Offset> get iconOffset;

  set iconOffset(PropertyValue<Offset> value);

  /// {@macro icon-anchor}
  ///
  /// Layout property. Optional enum. Defaults to [IconAnchor.center].
  /// Requires [iconImage].
  PropertyValue<IconAnchor> get iconAnchor;

  set iconAnchor(PropertyValue<IconAnchor> value);

  /// {@macro icon-pitch-alignment}
  ///
  /// Layout property. Optional enum. Defaults to [IconPitchAlignment.auto].
  /// Requires [iconImage].
  PropertyValue<IconPitchAlignment> get iconPitchAlignment;

  set iconPitchAlignment(PropertyValue<IconPitchAlignment> value);

  /// {@macro text-pitch-alignment}
  ///
  /// Layout property. Optional enum. Defaults to [TextPitchAlignment.auto].
  /// Requires [textField].
  PropertyValue<TextPitchAlignment> get textPitchAlignment;

  set textPitchAlignment(PropertyValue<TextPitchAlignment> value);

  /// {@macro text-rotation-alignment}
  ///
  /// Layout property. Optional enum. Defaults to
  /// [TextRotationAlignment.auto]. Requires [textField].
  PropertyValue<TextRotationAlignment> get textRotationAlignment;

  set textRotationAlignment(PropertyValue<TextRotationAlignment> value);

  /// Value to use for a text label. If a plain `string` is provided, it will be
  /// treated as a `formatted` with default/inherited formatting options.
  ///
  /// Layout property. Optional formatted. Defaults to `""`.
  PropertyValue<String> get textField;

  set textField(PropertyValue<String> value);

  /// Fonts to use for displaying text. If the `glyphs` root property is
  /// specified, this array is joined together and interpreted as a font stack
  /// name. Otherwise, it is interpreted as a cascading fallback list of local
  /// font names.
  ///
  /// Layout property. Optional `array`. Defaults to
  /// `["Open Sans Regular","Arial Unicode MS Regular"]`. Requires [textField].
  PropertyValue<List<String>> get textFont;

  set textFont(PropertyValue<List<String>> value);

  /// Font size.
  ///
  /// Layout property. Optional `number` in range `[0, ∞)`. Units in pixels.
  /// Defaults to `16`. Requires [textField]. Supports [interpolate]
  /// expressions.
  PropertyValue<double> get textSize;

  set textSize(PropertyValue<double> value);

  /// The maximum line width for text wrapping.
  ///
  /// Layout property. Optional `number` in range `[0, ∞)`. Units in ems.
  /// Defaults to `10`. Requires [textField]. Supports [interpolate]
  /// expressions.
  PropertyValue<double> get textMaxWidth;

  set textMaxWidth(PropertyValue<double> value);

  /// Text leading value for multi-line text.
  ///
  /// Layout property. Optional `number`. Units in ems. Defaults to `1.2`.
  /// Requires [textField]. Supports [interpolate] expressions.
  PropertyValue<double> get textLineHeight;

  set textLineHeight(PropertyValue<double> value);

  /// Text tracking amount.
  ///
  /// Layout property. Optional `number`. Units in ems. Defaults to `0`.
  /// Requires [textField]. Supports [interpolate] expressions.
  PropertyValue<double> get textLetterSpacing;

  set textLetterSpacing(PropertyValue<double> value);

  /// {@macro text-justify}
  ///
  /// Layout property. Optional enum. Defaults to [TextJustify.center].
  /// Requires [textField].
  PropertyValue<TextJustify> get textJustify;

  set textJustify(PropertyValue<TextJustify> value);

  /// Radial offset of text, in the direction of the symbol's anchor. Useful in
  /// combination with [textVariableAnchor], which defaults to using the
  /// two-dimensional [textOffset] if present.
  ///
  /// Layout property. Optional `number`. Units in ems. Defaults to 0. Requires text-field. Supports interpolate expressions.
  PropertyValue<double> get textRadialOffset;

  set textRadialOffset(PropertyValue<double> value);

  /// To increase the chance of placing high-priority labels on the map, you can provide an array of text-anchor locations: the renderer will attempt to place the label at each location, in order, before moving onto the next label. Use text-justify: auto to choose justification based on anchor position. To apply an offset, use the text-radial-offset or the two-dimensional text-offset. For example:
  /// ```json
  /// "text-variable-anchor": ["center", "left", "right"]
  /// ```
  ///
  /// Layout property. Optional `array`. Requires [textField]. Requires
  /// [placement] to be [SymbolPlacement.point].
  PropertyValue<List<IconAnchor>> get textVariableAnchor;

  set textVariableAnchor(PropertyValue<List<IconAnchor>> value);

  /// To increase the chance of placing high-priority labels on the map, you
  /// can provide an array of text-anchor locations, each paired with an offset
  /// value. The renderer will attempt to place the label at each location, in
  /// order, before moving on to the next location+offset. Use
  /// [textJustify]: [TextJustify.auto] to choose justification based on anchor
  /// position.
  ///
  /// The length of the array must be even, and must alternate between enum and
  /// point entries. i.e., each anchor location must be accompanied by a point,
  /// and that point defines the offset when the corresponding anchor location
  /// is used. Positive offset values indicate right and down, while negative
  /// values indicate left and up. Anchor locations may repeat, allowing the
  /// renderer to try multiple offsets to try and place a label using the same
  /// anchor.
  ///
  /// When present, this property takes precedence over [textAnchor],
  /// [textVariableAnchor], [textOffset], and [textRadialOffset].
  /// ```json
  /// {
  ///   "text-variable-anchor-offset": [
  ///     "top", [0, 4],
  ///     "left", [3,0],
  ///     "bottom", [1, 1]
  ///   ]
  /// }
  /// ```
  ///
  /// When the renderer chooses the top anchor, `[0, 4]` will be used for
  /// [textOffset]; the text will be shifted down by `4 ems`.
  ///
  /// When the renderer chooses the left anchor, `[3, 0]` will be used for
  /// [textOffset]; the text will be shifted right by `3 ems`.
  ///
  /// ```json
  /// "text-variable-anchor-offset": [
  ///   "top", [0, 4],
  ///   "left", [3, 0],
  ///   "bottom", [1, 1]
  /// ]
  /// ```
  ///
  /// Layout property. Optional. Requires [textField]. Requires [placement] to
  /// be [SymbolPlacement.point]. Supports [interpolate] expressions.
  PropertyValue<List<Object>> get textVariableAnchorOffset;

  set textVariableAnchorOffset(PropertyValue<List<Object>> value);

  /// {@macro text-anchor}
  ///
  /// Layout property. Optional enum. Defaults to [TextAnchor.center]. Requires
  /// [textField]. Disabled by [textVariableAnchor].
  PropertyValue<TextAnchor> get textAnchor;

  set textAnchor(PropertyValue<TextAnchor> value);

  /// Maximum angle change between adjacent characters.
  ///
  /// Layout property. Optional `number`. Units in degrees. Defaults to `45`.
  /// Requires [textField]. Requires [placement] to be one of
  /// [SymbolPlacement.line], [SymbolPlacement.lineCenter]. Supports
  /// [interpolate] expressions.
  PropertyValue<double> get textMaxAngle;

  set textMaxAngle(PropertyValue<double> value);

  /// {@macro text-writing-mode}
  ///
  /// Note that the
  /// property values act as a hint, so that a symbol whose language doesn’t
  /// support the provided orientation will be laid out in its natural
  /// orientation. Example: English point symbol will be rendered horizontally
  /// even if array value contains single 'vertical' enum value. The order of
  /// elements in an array define priority order for the placement of an
  /// orientation variant.
  ///
  /// Layout property. Optional array. Requires [textField]. Requires
  /// [placement] to be [SymbolPlacement.point].
  PropertyValue<List<TextWritingMode>> get textWritingMode;

  /// Rotates the text clockwise.
  ///
  /// Layout property. Optional number. Units in degrees. Defaults to `0`.
  /// Requires [textField]. Supports [interpolate] expressions.
  PropertyValue<double> get textRotate;

  set textRotate(PropertyValue<double> value);

  /// Size of the additional area around the text bounding box used for
  /// detecting symbol collisions.
  ///
  /// Layout property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `2`. Requires [textField]. Supports [interpolate] expressions.
  PropertyValue<double> get textPadding;

  set textPadding(PropertyValue<double> value);

  /// If `true`, the text may be flipped vertically to prevent it from being
  /// rendered upside-down.
  ///
  /// Layout property. Optional `boolean`. Defaults to `true`. Requires
  /// [textField]. Requires [textRotationAlignment] to be
  /// [TextRotationAlignment.map]. Requires [placement] to be one of
  /// [SymbolPlacement.line], [SymbolPlacement.lineCenter].
  PropertyValue<bool> get textKeepUpright;

  set textKeepUpright(PropertyValue<bool> value);

  /// Specifies how to capitalize text, similar to the CSS text-transform
  /// property.
  ///
  /// Layout property. Optional enum. Defaults to [TextTransform.none].
  /// Requires [textField].
  PropertyValue<TextTransform> get textTransform;

  set textTransform(PropertyValue<TextTransform> value);

  /// Offset distance of text from its anchor. Positive values indicate right
  /// and down, while negative values indicate left and up. If used with
  /// text-variable-anchor, input values will be taken as absolute values.
  /// Offsets along the x- and y-axis will be applied automatically based on
  /// the anchor position.
  ///
  /// Layout property. Optional array. Units in ems. Defaults to `[0,0]`.
  /// Requires [textField]. Disabled by [textRadialOffset]. Supports
  /// [interpolate] expressions.
  PropertyValue<Offset> get textOffset;

  set textOffset(PropertyValue<Offset> value);

  /// Allows for control over whether to show symbol text when it overlaps
  /// other symbols on the map. If [textOverlap] is not set, [textAllowOverlap]
  /// is used instead.
  ///
  /// Layout property. Optional enum. Requires [textField].
  PropertyValue<SymbolOverlap> get textOverlap;

  set textOverlap(PropertyValue<SymbolOverlap> value);

  /// If `true`, other symbols can be visible even if they collide with the
  /// text.
  ///
  /// Layout property. Optional `boolean`. Defaults to `false`. Requires
  /// [textField].
  PropertyValue<bool> get textIgnorePlacement;

  set textIgnorePlacement(PropertyValue<bool> value);

  /// If true, icons will display without their corresponding text when the
  /// text collides with other symbols and the icon does not.
  ///
  /// Layout property. Optional `boolean`. Defaults to `false`. Requires
  /// [textField]. Requires [iconImage].
  PropertyValue<bool> get textOptional;

  set textOptional(PropertyValue<bool> value);

  /// The opacity at which the icon will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Requires [iconImage]. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<double> get iconOpacity;

  set iconOpacity(PropertyValue<double> value);

  /// The color of the icon. This can only be used with SDF icons.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"`. Requires
  /// [iconImage]. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<Color> get iconColor;

  set iconColor(PropertyValue<Color> value);

  /// The color of the icon's halo. Icon halos can only be used with SDF icons.
  ///
  /// Paint property. Optional [Color]. Defaults to `"rgba(0, 0, 0, 0)"`.
  /// Requires iconImage. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<Color> get iconHaloColor;

  set iconHaloColor(PropertyValue<Color> value);

  /// Distance of halo to the icon outline.
  ///
  /// The unit is in pixels only for SDF sprites that were created with a blur
  /// radius of 8, multiplied by the display density. I.e., the radius needs to
  /// be 16 for @2x sprites, etc.
  ///
  /// Paint property. Optional `number` in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Requires [iconImage]. Supports [featureState] and
  /// [interpolate] expressions. Transitionable.
  PropertyValue<double> get iconHaloWidth;

  set iconHaloWidth(PropertyValue<double> value);

  /// Fade out the halo towards the outside.
  ///
  /// Paint property. Optional `number` in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Requires [iconImage]. Supports [featureState] and
  /// [interpolate] expressions. Transitionable.
  PropertyValue<double> get iconHaloBlur;

  /// Distance that the icon's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  ///
  /// Paint property. Optional array. Units in pixels. Defaults to `[0,0]`.
  /// Requires [iconImage]. Supports [interpolate] expressions. Transitionable.
  PropertyValue<List<double>> get iconTranslate;

  set iconHaloBlur(PropertyValue<double> value);

  /// Controls the frame of reference for [iconTranslate].
  ///
  /// Paint property. Optional enum. Defaults to [ReferenceSpace.map].
  /// Requires [iconImage]. Requires [iconTranslate].
  PropertyValue<ReferenceSpace> get iconTranslateAnchor;

  set iconTranslateAnchor(PropertyValue<ReferenceSpace> value);

  /// The opacity at which the text will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Requires [textField]. Supports [featureState] and [interpolate]
  /// expressions. Transitionable.
  PropertyValue<double> get textOpacity;

  set textOpacity(PropertyValue<double> value);

  /// The color with which the text will be drawn.
  ///
  /// Paint property. Optional [Color]. Defaults to `"#000000"`. Requires
  /// [textField]. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<Color> get textColor;

  set textColor(PropertyValue<Color> value);

  /// The color of the text's halo, which helps it stand out from backgrounds.
  ///
  /// Paint property. Optional color. Defaults to "rgba(0, 0, 0, 0)". Requires
  /// [textField]. Supports [featureState] and [interpolate] expressions.
  /// Transitionable.
  PropertyValue<Color> get textHaloColor;

  set textHaloColor(PropertyValue<Color> value);

  /// Distance of halo to the font outline. Max text halo width is 1/4 of the
  /// [textSize].
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Requires [textField]. Supports [featureState] and
  /// [interpolate] expressions. Transitionable.
  PropertyValue<double> get textHaloWidth;

  set textHaloWidth(PropertyValue<double> value);

  /// The halo's fadeout distance towards the outside.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in pixels.
  /// Defaults to `0`. Requires [textField]. Supports [featureState] and
  /// [interpolate] expressions. Transitionable.
  PropertyValue<double> get textHaloBlur;

  set textHaloBlur(PropertyValue<double> value);

  /// Distance that the text's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  ///
  /// Paint property. Optional array. Units in pixels. Defaults to `[0,0]`.
  /// Requires [textField]. Supports [interpolate] expressions. Transitionable.
  PropertyValue<List<double>> get textTranslate;

  set textTranslate(PropertyValue<List<double>> value);

  /// Controls the frame of reference for [textTranslate].
  ///
  /// Paint property. Optional enum. Defaults to [ReferenceSpace.map].
  /// Requires [textField]. Requires [textTranslate].
  PropertyValue<ReferenceSpace> get textTranslateAnchor;

  set textTranslateAnchor(PropertyValue<ReferenceSpace> value);
}

/// {@template symbol-placement}
/// Label placement relative to its geometry.
/// {@endtemplate}
enum SymbolPlacement {
  /// The label is placed at the point where the geometry is located.
  point('point'),

  /// The label is placed along the line of the geometry. Can only be used on
  /// `LineString` and `Polygon` geometries.
  line('line'),

  /// The label is placed at the center of the line of the geometry. Can only be
  /// used on `LineString` and `Polygon` geometries. Note that a single feature
  /// in a vector tile may contain multiple line geometries.
  lineCenter('line-center');

  const SymbolPlacement(this.name);

  /// The MapLibre Style spec compatible name.
  final String name;
}

/// {@template symbol-z-order}
/// Determines whether overlapping symbols in the same layer are rendered in
/// the order that they appear in the data source or by their y-position
/// relative to the viewport. To control the order and prioritization of
/// symbols otherwise, use [SymbolStyleLayer.sortKey].
/// {@endtemplate}
enum SymbolZOrder {
  /// Sorts symbols by [SymbolStyleLayer.sortKey] if set. Otherwise, sorts
  /// symbols by their y-position relative to the viewport if [iconAllowOverlap]
  /// or [textAllowOverlap] is set to true or [iconIgnorePlacement] or
  /// [textIgnorePlacement] is false.
  auto('auto'),

  /// Sorts symbols by their y-position relative to the viewport if
  /// [allowOverlap] or [textAllowOverlap] is set to true or
  /// [iconIgnorePlacement] or [textIgnorePlacement] is `false`.
  viewportY('viewport-y'),

  /// Sorts symbols by [SymbolStyleLayer.sortKey] if set. Otherwise, no sorting
  /// is applied; symbols are rendered in the same order as the source data.
  source('source');

  const SymbolZOrder(this.name);

  /// The MapLibre Style spec compatible name.
  final String name;
}

/// {@template icon-overlap}
/// Allows for control over whether to show an icon when it overlaps other
/// symbols on the map. If [SymbolStyleLayer.iconOverlap] is not set,
/// [SymbolStyleLayer.iconAllowOverlap] is used instead.
/// {@endtemplate}
enum SymbolOverlap {
  /// The icon will be hidden if it collides with any other previously drawn
  /// symbol.
  never,

  /// The icon will be visible even if it collides with any other previously
  /// drawn symbol.
  always,

  /// If the icon collides with another previously drawn symbol, the overlap
  /// mode for that symbol is checked. If the previous symbol was placed using
  /// never overlap mode, the new icon is hidden. If the previous symbol was
  /// placed using [always] or [cooperative] overlap mode, the new icon is
  /// visible.
  cooperative;
}

/// {@template icon-rotation-alignment}
/// In combination with [SymbolStyleLayer.placement], determines the
/// rotation behavior of icons.
/// {@endtemplate}
enum IconRotationAlignment {
  /// When [SymbolStyleLayer.placement] is set to [SymbolPlacement.point],
  /// aligns icons east-west. When [SymbolStyleLayer.placement] is set to
  /// [SymbolPlacement.line] or [SymbolPlacement.lineCenter], aligns icon
  /// x-axes with the line.
  map,

  /// Produces icons whose x-axes are aligned with the x-axis of the viewport,
  /// regardless of the value of [SymbolStyleLayer.placement].
  viewport,

  /// When [SymbolStyleLayer.placement] is set to [SymbolPlacement.point], this
  /// is equivalent to [viewport]. When [SymbolStyleLayer.placement] is set to
  /// [SymbolPlacement.line] or [SymbolPlacement.lineCenter], this is
  /// equivalent to [map].
  auto;
}

/// {@template icon-text-fit}
/// Scales the icon to fit around the associated text.
/// {@endtemplate}
enum IconTextFit {
  /// The icon is displayed at its intrinsic aspect ratio.
  none,

  /// The icon is scaled in the x-dimension to fit the width of the text.
  width,

  /// The icon is scaled in the y-dimension to fit the height of the text.
  height,

  /// The icon is scaled in both x- and y-dimensions.
  both;
}

/// {@template icon-anchor}
/// Part of the icon placed closest to the anchor.
/// {@endtemplate}
enum IconAnchor {
  /// The center of the icon is placed closest to the anchor.
  center('center'),

  /// The left side of the icon is placed closest to the anchor.
  left('left'),

  /// The right side of the icon is placed closest to the anchor.
  right('right'),

  /// The top of the icon is placed closest to the anchor.
  top('top'),

  /// The bottom of the icon is placed closest to the anchor.
  bottom('bottom'),

  /// The top left corner of the icon is placed closest to the anchor.
  topLeft('top-left'),

  /// The top right corner of the icon is placed closest to the anchor.
  topRight('top-right'),

  /// The bottom left corner of the icon is placed closest to the anchor.
  bottomLeft('bottom-left'),

  /// The bottom right corner of the icon is placed closest to the anchor.
  bottomRight('bottom-right');

  const IconAnchor(this.name);

  /// The MapLibre Style spec compatible name.
  final String name;
}

/// {@template icon-pitch-alignment}
/// Orientation of icon when map is pitched.
/// {@endtemplate}
enum IconPitchAlignment {
  /// The icon is aligned to the plane of the map.
  map,

  /// The icon is aligned to the plane of the viewport.
  viewport,

  /// Automatically matches the value of
  /// [SymbolStyleLayer.iconRotationAlignment].
  auto;
}

/// {@template text-pitch-alignment}
/// Orientation of icon when map is pitched.
/// {@endtemplate}
enum TextPitchAlignment {
  /// The text is aligned to the plane of the map.
  map,

  /// The text is aligned to the plane of the viewport.
  viewport,

  /// Automatically matches the value of
  /// [SymbolStyleLayer.textRotationAlignment].
  auto;
}

/// {@template text-rotation-alignment}
/// In combination with [SymbolStyleLayer.placement], determines the rotation
/// behavior of the individual glyphs forming the text.
/// {@endtemplate}
enum TextRotationAlignment {
  /// When [SymbolStyleLayer.placement] is set to [SymbolPlacement.point],
  /// aligns text east-west. When [SymbolStyleLayer.placement] is set to
  /// [SymbolPlacement.line] or line-center, aligns text x-axes with the line.
  map('map'),

  /// Produces glyphs whose x-axes are aligned with the x-axis of the viewport,
  /// regardless of the value of symbol-placement.
  viewport('viewport'),

  ///  When [SymbolStyleLayer.placement] is set to [SymbolPlacement.point],
  ///  aligns text to the x-axis of the viewport. When
  ///  [SymbolStyleLayer.placement] is set to [SymbolPlacement.line] or
  ///  [SymbolPlacement.lineCenter], aligns glyphs to the x-axis of the
  ///  viewport and places them along the line.
  viewportGlyphs('viewport-glyphs'),

  /// When [SymbolStyleLayer.placement] is set to [SymbolPlacement.point], this
  /// is equivalent to [viewport]. When [SymbolStyleLayer.placement] is set to
  /// [SymbolPlacement.line] or [SymbolPlacement.lineCenter], this is
  /// equivalent to [map].
  auto('auto');

  const TextRotationAlignment(this.name);

  /// The MapLibre Style spec compatible name.
  final String name;
}

/// {@template text-justify}
/// Text justification options.
/// {@endtemplate}
enum TextJustify {
  /// The text is aligned towards the anchor position.
  auto,

  /// The text is aligned to the left.
  left,

  /// The text is centered.
  center,

  /// The text is aligned to the right.
  right;
}

/// {@template text-anchor}
/// Part of the text placed closest to the anchor.
/// {@endtemplate}
enum TextAnchor {
  /// The center of the text is placed closest to the anchor.
  center('center'),

  /// The left side of the text is placed closest to the anchor.
  left('left'),

  /// The right side of the text is placed closest to the anchor.
  right('right'),

  /// The top of the text is placed closest to the anchor.
  top('top'),

  /// The bottom of the text is placed closest to the anchor.
  bottom('bottom'),

  /// The top left corner of the text is placed closest to the anchor.
  topLeft('top-left'),

  /// The top right corner of the text is placed closest to the anchor.
  topRight('top-right'),

  /// The bottom left corner of the text is placed closest to the anchor.
  bottomLeft('bottom-left'),

  /// The bottom right corner of the text is placed closest to the anchor.
  bottomRight('bottom-right');

  const TextAnchor(this.name);

  /// The MapLibre Style spec compatible name.
  final String name;
}

/// {@template text-writing-mode}
/// The property allows control over a symbol's orientation.
/// {@endtemplate}
enum TextWritingMode {
  /// If a text's language supports horizontal writing mode, symbols with point
  /// placement would be laid out horizontally.
  horizontal,

  /// If a text's language supports vertical writing mode, symbols with point
  /// placement would be laid out vertically.
  vertical;
}

/// {@template text-transform}
/// Specifies how to capitalize text, similar to the CSS text-transform
/// property.
/// {@endtemplate}
enum TextTransform {
  /// No capitalization. Text is rendered as it is provided in the data
  /// source.
  none,

  /// Forces all letters to be displayed in uppercase.
  uppercase,

  /// Forces all letters to be displayed in lowercase.
  lowercase;
}