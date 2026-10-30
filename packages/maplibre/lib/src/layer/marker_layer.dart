import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A [Point] layer.
///
/// {@category Layers}
@immutable
class MarkerLayer extends Layer<Feature<Point>> {
  /// Create a new [MarkerLayer] instance.
  const MarkerLayer({
    required List<Feature<Point>> points,
    this.iconAllowOverlap = const .literal(false),
    this.iconIgnorePlacement = const .literal(false),
    this.iconOptional = const .literal(false),
    this.iconSize = const .literal(1),
    this.iconImage,
    this.iconRotate = const .literal(0),
    this.iconPadding = const .literal([2]),
    this.iconKeepUpright = const .literal(false),
    this.iconOffset = const .literal(Offset.zero),
    this.textField = const .literal(''),
    this.textFont = const .literal([
      'Open Sans Regular',
      'Arial Unicode MS Regular',
    ]),
    this.textSize = const .literal(16),
    this.textMaxWidth = const .literal(10),
    this.textLineHeight = const .literal(1.2),
    this.textLetterSpacing = const .literal(0),
    this.textRadialOffset = const .literal(0),
    this.textMaxAngle = const .literal(45),
    this.textRotate = const .literal(0),
    this.textPadding = const .literal(2),
    this.textKeepUpright = const .literal(true),
    this.textOffset = const .literal(Offset.zero),
    this.textAllowOverlap = const .literal(false),
    this.textIgnorePlacement = const .literal(false),
    this.textOptional = const .literal(false),
    this.iconOpacity = const .literal(1),
    this.iconColor = const .literal(Color(0xFF000000)),
    this.iconHaloColor = const .literal(Color(0xFF000000)),
    this.iconHaloWidth = const .literal(0),
    this.iconHaloBlur = const .literal(0),
    this.iconTranslate = const .literal(Offset.zero),
    this.textColor = const .literal(Color(0xFF000000)),
    this.textOpacity = const .literal(1),
    this.textHaloColor = const .literal(Color(0xFF000000)),
    this.textHaloWidth = const .literal(0),
    this.textHaloBlur = const .literal(0),
    this.textTranslate = const .literal(Offset.zero),
    this.iconAnchor = const .literal(IconAnchor.center),
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super(list: points);

  /// If true, the icon will be visible even if it collides with other
  /// previously drawn symbols.
  final Expression<bool> iconAllowOverlap;

  /// If true, other symbols can be visible even if they collide with the icon.
  final Expression<bool> iconIgnorePlacement;

  /// If true, text will display without their corresponding icons when the
  /// icon collides with other symbols and the text does not.
  final Expression<bool> iconOptional;

  /// Scales the original size of the icon by the provided factor. The new
  /// pixel size of the image will be the original pixel size multiplied by
  /// icon-size. 1 is the original size; 3 triples the size of the image.
  final Expression<num> iconSize;

  /// Name of image in sprite to use for drawing an image background.
  final Expression<String>? iconImage;

  /// Rotates the icon clockwise.
  final Expression<num> iconRotate;

  /// Size of additional area round the icon bounding box used for detecting
  /// symbol collisions.
  final Expression<List<num>> iconPadding;

  /// If true, the icon may be flipped to prevent it from being rendered
  /// upside-down.
  final Expression<bool> iconKeepUpright;

  /// Offset distance of icon from its anchor. Positive values indicate right
  /// and down, while negative values indicate left and up. Each component is
  /// multiplied by the value of icon-size to obtain the final offset in
  /// pixels. When combined with icon-rotate the offset will be as if the
  /// rotated direction was up.
  final Expression<Offset> iconOffset;

  /// Value to use for a text label. If a plain string is provided, it will
  /// be treated as a formatted with default/inherited formatting options.
  final Expression<String> textField;

  /// Font stack to use for displaying text.
  final Expression<List<String>> textFont;

  /// Font stack to use for displaying text.
  final Expression<num> textSize;

  /// Font stack to use for displaying text.
  final Expression<num> textMaxWidth;

  /// Text leading value for multi-line text.
  final Expression<num> textLineHeight;

  /// Text tracking amount.
  final Expression<num> textLetterSpacing;

  /// Radial offset of text, in the direction of the symbol's anchor. Useful in
  /// combination with text-variable-anchor, which defaults to using the
  /// two-dimensional text-offset if present.
  final Expression<num> textRadialOffset;

  /// Maximum angle change between adjacent characters.
  final Expression<num> textMaxAngle;

  /// Rotates the text clockwise.
  final Expression<num> textRotate;

  /// Size of the additional area around the text bounding box used for
  /// detecting symbol collisions.
  final Expression<num> textPadding;

  /// If true, the text may be flipped vertically to prevent it from being
  /// rendered upside-down.
  final Expression<bool> textKeepUpright;

  /// Offset distance of text from its anchor. Positive values indicate right
  /// and down, while negative values indicate left and up. If used with
  /// text-variable-anchor, input values will be taken as absolute values.
  /// Offsets along the x- and y-axis will be applied automatically based on
  /// the anchor position.
  final Expression<Offset> textOffset;

  /// If true, the text will be visible even if it collides with other
  /// previously drawn symbols.
  final Expression<bool> textAllowOverlap;

  /// If true, other symbols can be visible even if they collide with the text.
  final Expression<bool> textIgnorePlacement;

  /// If true, icons will display without their corresponding text when the
  /// text collides with other symbols and the icon does not.
  final Expression<bool> textOptional;

  /// The opacity at which the icon will be drawn.
  final Expression<num> iconOpacity;

  /// The color of the icon. This can only be used with SDF icons.
  final Expression<Color> iconColor;

  /// The color of the icon's halo. Icon halos can only be used with SDF icons.
  final Expression<Color> iconHaloColor;

  /// The unit is in pixels only for SDF sprites that were created with a blur
  /// radius of 8, multiplied by the display density. I.e., the radius needs
  /// to be 16 for @2x sprites, etc.
  final Expression<num> iconHaloWidth;

  /// Fade out the halo towards the outside.
  final Expression<num> iconHaloBlur;

  /// Distance that the icon's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  final Expression<Offset> iconTranslate;

  /// The opacity at which the text will be drawn.
  final Expression<num> textOpacity;

  /// The color with which the text will be drawn.
  final Expression<Color> textColor;

  /// The color of the text's halo, which helps it stand out from backgrounds.
  final Expression<Color> textHaloColor;

  /// Distance of halo to the font outline. Max text halo width is 1/4 of the
  /// font-size.
  final Expression<num> textHaloWidth;

  /// The halo's fadeout distance towards the outside.
  final Expression<num> textHaloBlur;

  /// Distance that the text's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  final Expression<Offset> textTranslate;

  /// Part of the icon placed closest to the anchor.
  final Expression<IconAnchor> iconAnchor;

  @override
  StyleLayer createStyleLayer(int index) => SymbolStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    minZoom: minZoom,
    maxZoom: maxZoom,
    iconAllowOverlap: iconAllowOverlap,
    iconIgnorePlacement: iconIgnorePlacement,
    iconOptional: iconOptional,
    iconSize: iconSize,
    iconImage: iconImage,
    iconRotate: iconRotate,
    iconPadding: iconPadding,
    iconKeepUpright: iconKeepUpright,
    iconOffset: iconOffset,
    iconAnchor: iconAnchor,
    textField: textField,
    textFont: textFont,
    textSize: textSize,
    textMaxWidth: textMaxWidth,
    textLineHeight: textLineHeight,
    textLetterSpacing: textLetterSpacing,
    textRadialOffset: textRadialOffset,
    textMaxAngle: textMaxAngle,
    textRotate: textRotate,
    textPadding: textPadding,
    textKeepUpright: textKeepUpright,
    textOffset: textOffset,
    textAllowOverlap: textAllowOverlap,
    textIgnorePlacement: textIgnorePlacement,
    textOptional: textOptional,
    iconOpacity: iconOpacity,
    iconColor: iconColor,
    iconHaloColor: iconHaloColor,
    iconHaloWidth: iconHaloWidth,
    iconHaloBlur: iconHaloBlur,
    iconTranslate: iconTranslate,
    textOpacity: textOpacity,
    textColor: textColor,
    textHaloColor: textHaloColor,
    textHaloWidth: textHaloWidth,
    textHaloBlur: textHaloBlur,
    textTranslate: textTranslate,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is MarkerLayer &&
          runtimeType == other.runtimeType &&
          iconAllowOverlap == other.iconAllowOverlap &&
          iconIgnorePlacement == other.iconIgnorePlacement &&
          iconOptional == other.iconOptional &&
          iconSize == other.iconSize &&
          iconImage == other.iconImage &&
          iconRotate == other.iconRotate &&
          iconPadding == other.iconPadding &&
          iconKeepUpright == other.iconKeepUpright &&
          iconOffset == other.iconOffset &&
          textField == other.textField &&
          textFont == other.textFont &&
          textSize == other.textSize &&
          textMaxWidth == other.textMaxWidth &&
          textLineHeight == other.textLineHeight &&
          textLetterSpacing == other.textLetterSpacing &&
          textRadialOffset == other.textRadialOffset &&
          textMaxAngle == other.textMaxAngle &&
          textRotate == other.textRotate &&
          textPadding == other.textPadding &&
          textKeepUpright == other.textKeepUpright &&
          textOffset == other.textOffset &&
          textAllowOverlap == other.textAllowOverlap &&
          textIgnorePlacement == other.textIgnorePlacement &&
          textOptional == other.textOptional &&
          iconOpacity == other.iconOpacity &&
          iconColor == other.iconColor &&
          iconHaloColor == other.iconHaloColor &&
          iconHaloWidth == other.iconHaloWidth &&
          iconHaloBlur == other.iconHaloBlur &&
          iconTranslate == other.iconTranslate &&
          textOpacity == other.textOpacity &&
          textColor == other.textColor &&
          textHaloColor == other.textHaloColor &&
          textHaloWidth == other.textHaloWidth &&
          textHaloBlur == other.textHaloBlur &&
          textTranslate == other.textTranslate &&
          iconAnchor == other.iconAnchor;

  @override
  int get hashCode => Object.hashAll([
    super.hashCode,
    iconAllowOverlap,
    iconIgnorePlacement,
    iconOptional,
    iconSize,
    iconImage,
    iconRotate,
    iconPadding,
    iconKeepUpright,
    iconOffset,
    textField,
    textFont,
    textSize,
    textMaxWidth,
    textLineHeight,
    textLetterSpacing,
    textRadialOffset,
    textMaxAngle,
    textRotate,
    textPadding,
    textKeepUpright,
    textOffset,
    textAllowOverlap,
    textIgnorePlacement,
    textOptional,
    iconOpacity,
    iconColor,
    iconHaloColor,
    iconHaloWidth,
    iconHaloBlur,
    iconTranslate,
    textOpacity,
    textColor,
    textHaloColor,
    textHaloWidth,
    textHaloBlur,
    textTranslate,
    iconAnchor,
  ]);
}
