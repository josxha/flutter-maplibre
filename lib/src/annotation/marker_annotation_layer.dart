part of 'annotation_layer.dart';

/// A marker layer.
@immutable
class MarkerAnnotationLayer extends AnnotationLayer<Point> {
  /// Create a new [MarkerAnnotationLayer] instance.
  const MarkerAnnotationLayer({
    required List<Point> points,
    this.iconAllowOverlap = false,
    this.iconIgnorePlacement = false,
    this.iconOptional = false,
    this.iconSize = 1,
    this.iconImage,
    this.iconRotate = 0,
    this.iconPadding = 2,
    this.iconKeepUpright = false,
    this.iconOffset = const [0, 0],
    this.textField = '',
    this.textFont = const ['Open Sans Regular', 'Arial Unicode MS Regular'],
    this.textSize = 16,
    this.textMaxWidth = 10,
    this.textLineHeight = 1.2,
    this.textLetterSpacing = 0,
    this.textRadialOffset = 0,
    this.textMaxAngle = 45,
    this.textRotate = 0,
    this.textPadding = 2,
    this.textKeepUpright = true,
    this.textOffset = const [0, 0],
    this.textAllowOverlap = false,
    this.textIgnorePlacement = false,
    this.textOptional = false,
    this.iconOpacity = 1,
    this.iconColor = const Color(0xFF000000),
    this.iconHaloColor = const Color(0xFF000000),
    this.iconHaloWidth = 0,
    this.iconHaloBlur = 0,
    this.iconTranslate = const [0, 0],
    this.textColor = const Color(0xFF000000),
    this.textOpacity = 1,
    this.textHaloColor = const Color(0xFF000000),
    this.textHaloWidth = 0,
    this.textHaloBlur = 0,
    this.textTranslate = const [0, 0],
    this.iconAnchor = IconAnchor.center,
  }) : super._(list: points);

  /// If true, the icon will be visible even if it collides with other
  /// previously drawn symbols.
  final bool iconAllowOverlap;

  /// If true, other symbols can be visible even if they collide with the icon.
  final bool iconIgnorePlacement;

  /// If true, text will display without their corresponding icons when the
  /// icon collides with other symbols and the text does not.
  final bool iconOptional;

  /// Scales the original size of the icon by the provided factor. The new
  /// pixel size of the image will be the original pixel size multiplied by
  /// icon-size. 1 is the original size; 3 triples the size of the image.
  final double iconSize;

  /// Name of image in sprite to use for drawing an image background.
  final String? iconImage;

  /// Rotates the icon clockwise.
  final double iconRotate;

  /// Size of additional area round the icon bounding box used for detecting
  /// symbol collisions.
  final int iconPadding;

  /// If true, the icon may be flipped to prevent it from being rendered
  /// upside-down.
  final bool iconKeepUpright;

  /// Offset distance of icon from its anchor. Positive values indicate right
  /// and down, while negative values indicate left and up. Each component is
  /// multiplied by the value of icon-size to obtain the final offset in
  /// pixels. When combined with icon-rotate the offset will be as if the
  /// rotated direction was up.
  final List<int> iconOffset;

  /// Value to use for a text label. If a plain string is provided, it will
  /// be treated as a formatted with default/inherited formatting options.
  final String textField;

  /// Font stack to use for displaying text.
  final List<String> textFont;

  /// Font stack to use for displaying text.
  final int textSize;

  /// Font stack to use for displaying text.
  final int textMaxWidth;

  /// Text leading value for multi-line text.
  final double textLineHeight;

  /// Text tracking amount.
  final double textLetterSpacing;

  /// Radial offset of text, in the direction of the symbol's anchor. Useful in
  /// combination with text-variable-anchor, which defaults to using the
  /// two-dimensional text-offset if present.
  final double textRadialOffset;

  /// Maximum angle change between adjacent characters.
  final double textMaxAngle;

  /// Rotates the text clockwise.
  final double textRotate;

  /// Size of the additional area around the text bounding box used for
  /// detecting symbol collisions.
  final double textPadding;

  /// If true, the text may be flipped vertically to prevent it from being
  /// rendered upside-down.
  final bool textKeepUpright;

  /// Offset distance of text from its anchor. Positive values indicate right
  /// and down, while negative values indicate left and up. If used with
  /// text-variable-anchor, input values will be taken as absolute values.
  /// Offsets along the x- and y-axis will be applied automatically based on
  /// the anchor position.
  final List<int> textOffset;

  /// If true, the text will be visible even if it collides with other
  /// previously drawn symbols.
  final bool textAllowOverlap;

  /// If true, other symbols can be visible even if they collide with the text.
  final bool textIgnorePlacement;

  /// If true, icons will display without their corresponding text when the
  /// text collides with other symbols and the icon does not.
  final bool textOptional;

  /// The opacity at which the icon will be drawn.
  final double iconOpacity;

  /// The color of the icon. This can only be used with SDF icons.
  final Color iconColor;

  /// The color of the icon's halo. Icon halos can only be used with SDF icons.
  final Color iconHaloColor;

  /// The unit is in pixels only for SDF sprites that were created with a blur
  /// radius of 8, multiplied by the display density. I.e., the radius needs
  /// to be 16 for @2x sprites, etc.
  final int iconHaloWidth;

  /// Fade out the halo towards the outside.
  final int iconHaloBlur;

  /// Distance that the icon's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  final List<int> iconTranslate;

  /// The opacity at which the text will be drawn.
  final double textOpacity;

  /// The color with which the text will be drawn.
  final Color textColor;

  /// The color of the text's halo, which helps it stand out from backgrounds.
  final Color textHaloColor;

  /// Distance of halo to the font outline. Max text halo width is 1/4 of the
  /// font-size.
  final double textHaloWidth;

  /// The halo's fadeout distance towards the outside.
  final int textHaloBlur;

  /// Distance that the text's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  final List<int> textTranslate;

  /// Part of the icon placed closest to the anchor.
  final IconAnchor iconAnchor;

  @override
  Map<String, Object> getPaint() => {
        'icon-opacity': iconOpacity,
        'icon-color': iconColor.toHexString(),
        'icon-halo-color': iconHaloColor.toHexStringNoOpacity(),
        'icon-halo-width': iconHaloWidth,
        'icon-halo-blur': iconHaloBlur,
        'text-opacity': iconOpacity,
        'text-color': textColor.toHexStringNoOpacity(),
        'text-halo-color': textHaloColor.toHexString(),
        'text-halo-width': textHaloWidth,
        'text-halo-blur': textHaloBlur,
        'text-translate': textTranslate,
      };

  @override
  Map<String, Object> getLayout() => {
        'icon-allow-overlap': iconAllowOverlap,
        'icon-ignore-placement': iconIgnorePlacement,
        'icon-optional': iconOptional,
        'icon-size': iconSize,
        if (iconImage case final String image) 'icon-image': image,
        'icon-rotate': iconRotate,
        'icon-padding': iconPadding,
        'icon-keep-upright': iconKeepUpright,
        'icon-offset': iconOffset,
        'icon-anchor': iconAnchor.name,
        'text-field': textField,
        'text-font': textFont,
        'text-size': textSize,
        'text-max-width': textMaxWidth,
        'text-line-height': textLineHeight,
        'text-letter-spacing': textLetterSpacing,
        'text-radial-offset': textRadialOffset,
        'text-max-angle': textMaxAngle,
        'text-rotate': textRotate,
        'text-padding': textPadding,
        'text-keep-upright': textKeepUpright,
        'text-offset': textOffset,
        'text-allow-overlap': textAllowOverlap,
        'text-ignore-placement': textIgnorePlacement,
        'text-optional': textOptional,
      };

  @override
  Layer createLayer(int index) => SymbolLayer(
        id: getLayerId(index),
        sourceId: getSourceId(index),
        paint: getPaint(),
        layout: getLayout(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is MarkerAnnotationLayer &&
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

/// Part of the icon placed closest to the anchor.
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
