part of 'style_layer.dart';

class SymbolStyleLayerWebView extends StyleLayerWebView
    implements SymbolStyleLayer {
  SymbolStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.visible,
    required this.minZoom,
    required this.maxZoom,
    required this.sourceLayerId,
    required this.filter,
    required this.sortKey,
    required this.placement,
    required this.spacing,
    required this.avoidEdges,
    required this.zOrder,
    required this.iconAllowOverlap,
    required this.iconOverlap,
    required this.iconIgnorePlacement,
    required this.iconOptional,
    required this.iconRotationAlignment,
    required this.iconSize,
    required this.iconTextFit,
    required this.iconTextFitPadding,
    required this.iconImage,
    required this.iconRotate,
    required this.iconPadding,
    required this.iconKeepUpright,
    required this.iconOffset,
    required this.iconAnchor,
    required this.iconPitchAlignment,
    required this.textPitchAlignment,
    required this.textRotationAlignment,
    required this.textField,
    required this.textFont,
    required this.textSize,
    required this.textMaxWidth,
    required this.textLineHeight,
    required this.textLetterSpacing,
    required this.textJustify,
    required this.textRadialOffset,
    required this.textVariableAnchor,
    required this.textVariableAnchorOffset,
    required this.textAnchor,
    required this.textMaxAngle,
    required this.textWritingMode,
    required this.textRotate,
    required this.textPadding,
    required this.textKeepUpright,
    required this.textTransform,
    required this.textOffset,
    required this.textAllowOverlap,
    required this.textOverlap,
    required this.textIgnorePlacement,
    required this.textOptional,
    required this.iconOpacity,
    required this.iconColor,
    required this.iconHaloColor,
    required this.iconHaloWidth,
    required this.iconHaloBlur,
    required this.iconTranslate,
    required this.iconTranslateAnchor,
    required this.textOpacity,
    required this.textColor,
    required this.textHaloColor,
    required this.textHaloWidth,
    required this.textHaloBlur,
    required this.textTranslate,
    required this.textTranslateAnchor,
  });

  @override
  Map<String, Object?> get layout => createSymbolLayout(
    visible: visible,
    sortKey: sortKey,
    placement: placement,
    spacing: spacing,
    avoidEdges: avoidEdges,
    zOrder: zOrder,
    iconAllowOverlap: iconAllowOverlap,
    iconOverlap: iconOverlap,
    iconIgnorePlacement: iconIgnorePlacement,
    iconOptional: iconOptional,
    iconRotationAlignment: iconRotationAlignment,
    iconSize: iconSize,
    iconTextFit: iconTextFit,
    iconTextFitPadding: iconTextFitPadding,
    iconImage: iconImage,
    iconRotate: iconRotate,
    iconPadding: iconPadding,
    iconKeepUpright: iconKeepUpright,
    iconOffset: iconOffset,
    iconAnchor: iconAnchor,
    iconPitchAlignment: iconPitchAlignment,
    textPitchAlignment: textPitchAlignment,
    textRotationAlignment: textRotationAlignment,
    textField: textField,
    textFont: textFont,
    textSize: textSize,
    textMaxWidth: textMaxWidth,
    textLineHeight: textLineHeight,
    textLetterSpacing: textLetterSpacing,
    textJustify: textJustify,
    textRadialOffset: textRadialOffset,
    textVariableAnchor: textVariableAnchor,
    textVariableAnchorOffset: textVariableAnchorOffset,
    textAnchor: textAnchor,
    textMaxAngle: textMaxAngle,
    textWritingMode: textWritingMode,
    textRotate: textRotate,
    textPadding: textPadding,
    textKeepUpright: textKeepUpright,
    textTransform: textTransform,
    textOffset: textOffset,
    textAllowOverlap: textAllowOverlap,
    textOverlap: textOverlap,
    textIgnorePlacement: textIgnorePlacement,
    textOptional: textOptional,
  );

  @override
  Map<String, Object?> get paint => createSymbolPaint(
    iconOpacity: iconOpacity,
    iconColor: iconColor,
    iconHaloColor: iconHaloColor,
    iconHaloWidth: iconHaloWidth,
    iconHaloBlur: iconHaloBlur,
    iconTranslate: iconTranslate,
    iconTranslateAnchor: iconTranslateAnchor,
    textOpacity: textOpacity,
    textColor: textColor,
    textHaloColor: textHaloColor,
    textHaloWidth: textHaloWidth,
    textHaloBlur: textHaloBlur,
    textTranslate: textTranslate,
    textTranslateAnchor: textTranslateAnchor,
  );

  @override
  String? sourceLayerId;

  @override
  Expression? filter;

  @override
  PropertyValue<double>? sortKey;

  @override
  PropertyValue<SymbolPlacement> placement;

  @override
  PropertyValue<double> spacing;

  @override
  PropertyValue<bool> avoidEdges;

  @override
  PropertyValue<SymbolZOrder> zOrder;

  @override
  PropertyValue<bool> iconAllowOverlap;

  @override
  PropertyValue<SymbolOverlap> iconOverlap;

  @override
  PropertyValue<bool> iconIgnorePlacement;

  @override
  PropertyValue<bool> iconOptional;

  @override
  PropertyValue<IconRotationAlignment> iconRotationAlignment;

  @override
  PropertyValue<double> iconSize;

  @override
  PropertyValue<IconTextFit> iconTextFit;

  @override
  PropertyValue<EdgeInsets> iconTextFitPadding;

  @override
  PropertyValue<String>? iconImage;

  @override
  PropertyValue<double> iconRotate;

  @override
  PropertyValue<EdgeInsets> iconPadding;

  @override
  PropertyValue<bool> iconKeepUpright;

  @override
  PropertyValue<Offset> iconOffset;

  @override
  PropertyValue<IconAnchor> iconAnchor;

  @override
  PropertyValue<IconPitchAlignment> iconPitchAlignment;

  @override
  PropertyValue<TextPitchAlignment> textPitchAlignment;

  @override
  PropertyValue<TextRotationAlignment> textRotationAlignment;

  @override
  PropertyValue<String> textField;

  @override
  PropertyValue<List<String>> textFont;

  @override
  PropertyValue<double> textSize;

  @override
  PropertyValue<double> textMaxWidth;

  @override
  PropertyValue<double> textLineHeight;

  @override
  PropertyValue<double> textLetterSpacing;

  @override
  PropertyValue<TextJustify> textJustify;

  @override
  PropertyValue<double> textRadialOffset;

  @override
  PropertyValue<List<IconAnchor>>? textVariableAnchor;

  @override
  PropertyValue<List<OneOf2<String, Offset>>>?
  textVariableAnchorOffset;

  @override
  PropertyValue<TextAnchor> textAnchor;

  @override
  PropertyValue<double> textMaxAngle;

  @override
  PropertyValue<List<TextWritingMode>>? textWritingMode;

  @override
  PropertyValue<double> textRotate;

  @override
  PropertyValue<double> textPadding;

  @override
  PropertyValue<bool> textKeepUpright;

  @override
  PropertyValue<TextTransform> textTransform;

  @override
  PropertyValue<Offset> textOffset;

  @override
  PropertyValue<bool> textAllowOverlap;

  @override
  PropertyValue<SymbolOverlap>? textOverlap;

  @override
  PropertyValue<bool> textIgnorePlacement;

  @override
  PropertyValue<bool> textOptional;

  @override
  PropertyValue<double> iconOpacity;

  @override
  PropertyValue<Color> iconColor;

  @override
  PropertyValue<Color> iconHaloColor;

  @override
  PropertyValue<double> iconHaloWidth;

  @override
  PropertyValue<double> iconHaloBlur;

  @override
  PropertyValue<Offset> iconTranslate;

  @override
  PropertyValue<ReferenceSpace> iconTranslateAnchor;

  @override
  PropertyValue<double> textOpacity;

  @override
  PropertyValue<Color> textColor;

  @override
  PropertyValue<Color> textHaloColor;

  @override
  PropertyValue<double> textHaloWidth;

  @override
  PropertyValue<double> textHaloBlur;

  @override
  PropertyValue<Offset> textTranslate;

  @override
  PropertyValue<ReferenceSpace> textTranslateAnchor;

  @override
  bool visible;

  @override
  double minZoom;

  @override
  double maxZoom;

  @override
  final String id;

  @override
  final String sourceId;
}


