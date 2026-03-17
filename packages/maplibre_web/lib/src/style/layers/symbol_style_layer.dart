part of 'style_layer.dart';

/// Web implementation of [SymbolStyleLayer].
class SymbolStyleLayerWeb extends StyleLayerWeb implements SymbolStyleLayer {
  /// Default constructor for a [SymbolStyleLayerWeb] instance.
  SymbolStyleLayerWeb({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<SymbolPlacement> placement,
    required PropertyValue<double> spacing,
    required PropertyValue<bool> avoidEdges,
    required PropertyValue<SymbolZOrder> zOrder,
    required PropertyValue<bool> iconAllowOverlap,
    required PropertyValue<SymbolOverlap> iconOverlap,
    required PropertyValue<bool> iconIgnorePlacement,
    required PropertyValue<bool> iconOptional,
    required PropertyValue<IconRotationAlignment> iconRotationAlignment,
    required PropertyValue<double> iconSize,
    required PropertyValue<IconTextFit> iconTextFit,
    required PropertyValue<EdgeInsets> iconTextFitPadding,
    required PropertyValue<String>? iconImage,
    required PropertyValue<double> iconRotate,
    required PropertyValue<EdgeInsets> iconPadding,
    required PropertyValue<bool> iconKeepUpright,
    required PropertyValue<Offset> iconOffset,
    required PropertyValue<IconAnchor> iconAnchor,
    required PropertyValue<IconPitchAlignment> iconPitchAlignment,
    required PropertyValue<TextPitchAlignment> textPitchAlignment,
    required PropertyValue<TextRotationAlignment> textRotationAlignment,
    required PropertyValue<String> textField,
    required PropertyValue<List<String>> textFont,
    required PropertyValue<double> textSize,
    required PropertyValue<double> textMaxWidth,
    required PropertyValue<double> textLineHeight,
    required PropertyValue<double> textLetterSpacing,
    required PropertyValue<TextJustify> textJustify,
    required PropertyValue<double> textRadialOffset,
    required PropertyValue<List<IconAnchor>>? textVariableAnchor,
    required PropertyValue<Map<String, Offset>>? textVariableAnchorOffset,
    required PropertyValue<TextAnchor> textAnchor,
    required PropertyValue<double> textMaxAngle,
    required PropertyValue<List<TextWritingMode>>? textWritingMode,
    required PropertyValue<double> textRotate,
    required PropertyValue<double> textPadding,
    required PropertyValue<bool> textKeepUpright,
    required PropertyValue<TextTransform> textTransform,
    required PropertyValue<Offset> textOffset,
    required PropertyValue<bool> textAllowOverlap,
    required PropertyValue<SymbolOverlap>? textOverlap,
    required PropertyValue<bool> textIgnorePlacement,
    required PropertyValue<bool> textOptional,
    required PropertyValue<double> iconOpacity,
    required PropertyValue<Color> iconColor,
    required PropertyValue<Color> iconHaloColor,
    required PropertyValue<double> iconHaloWidth,
    required PropertyValue<double> iconHaloBlur,
    required PropertyValue<Offset> iconTranslate,
    required PropertyValue<ReferenceSpace> iconTranslateAnchor,
    required PropertyValue<double> textOpacity,
    required PropertyValue<Color> textColor,
    required PropertyValue<Color> textHaloColor,
    required PropertyValue<double> textHaloWidth,
    required PropertyValue<double> textHaloBlur,
    required PropertyValue<Offset> textTranslate,
    required PropertyValue<ReferenceSpace> textTranslateAnchor,
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'symbol',
           maxzoom: maxZoom,
           minzoom: minZoom,
           source: sourceId,
           layout: createSymbolLayout(
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
           ).jsify(),
           paint: createSymbolPaint(
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
           ).jsify(),
         ),
       ) {
    if (sourceLayerId case final id?) jsLayer.sourceLayer = id;
    if (filter case final filter?) jsLayer.filter = filter.json.jsify();
  }

  @override
  PropertyValue<SymbolPlacement> get placement =>
      requireMap
          .getLayoutProperty(id, 'symbol-placement')
          .toEnumPropertyValue(SymbolPlacement.values) ??
      SymbolStyleLayer.defaultPlacement;

  @override
  set placement(PropertyValue<SymbolPlacement> property) => requireMap
      .setLayoutProperty(id, 'symbol-placement', property.toJson().jsify());

  @override
  PropertyValue<double> get spacing =>
      requireMap
          .getLayoutProperty(id, 'symbol-spacing')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultSpacing;

  @override
  set spacing(PropertyValue<double> property) => requireMap.setLayoutProperty(
    id,
    'symbol-spacing',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<bool> get avoidEdges =>
      requireMap
          .getLayoutProperty(id, 'symbol-avoid-edges')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultAvoidEdges;

  @override
  set avoidEdges(PropertyValue<bool> property) => requireMap.setLayoutProperty(
    id,
    'symbol-avoid-edges',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<SymbolZOrder> get zOrder =>
      requireMap
          .getLayoutProperty(id, 'symbol-z-order')
          .toEnumPropertyValue(SymbolZOrder.values) ??
      SymbolStyleLayer.defaultZOrder;

  @override
  set zOrder(PropertyValue<SymbolZOrder> property) => requireMap
      .setLayoutProperty(id, 'symbol-z-order', property.toJson().jsify());

  @override
  PropertyValue<double>? get sortKey => requireMap
      .getLayoutProperty(id, 'symbol-sort-key')
      .toPropertyValue<double>();

  @override
  set sortKey(PropertyValue<double>? property) => requireMap.setLayoutProperty(
    id,
    'symbol-sort-key',
    property?.toJson().jsify(),
  );

  @override
  PropertyValue<bool> get iconAllowOverlap =>
      requireMap
          .getLayoutProperty(id, 'icon-allow-overlap')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultIconAllowOverlap;

  @override
  set iconAllowOverlap(PropertyValue<bool> property) => requireMap
      .setLayoutProperty(id, 'icon-allow-overlap', property.toJson().jsify());

  @override
  PropertyValue<SymbolOverlap> get iconOverlap =>
      requireMap
          .getLayoutProperty(id, 'icon-overlap')
          .toEnumPropertyValue(SymbolOverlap.values) ??
      SymbolStyleLayer.defaultIconOverlap;

  @override
  set iconOverlap(PropertyValue<SymbolOverlap> property) => requireMap
      .setLayoutProperty(id, 'icon-overlap', property.toJson().jsify());

  @override
  PropertyValue<bool> get iconIgnorePlacement =>
      requireMap
          .getLayoutProperty(id, 'icon-ignore-placement')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultIconIgnorePlacement;

  @override
  set iconIgnorePlacement(PropertyValue<bool> property) =>
      requireMap.setLayoutProperty(
        id,
        'icon-ignore-placement',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<bool> get iconOptional =>
      requireMap
          .getLayoutProperty(id, 'icon-optional')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultIconOptional;

  @override
  set iconOptional(PropertyValue<bool> property) => requireMap
      .setLayoutProperty(id, 'icon-optional', property.toJson().jsify());

  @override
  PropertyValue<IconRotationAlignment> get iconRotationAlignment =>
      requireMap
          .getLayoutProperty(id, 'icon-rotation-alignment')
          .toEnumPropertyValue(IconRotationAlignment.values) ??
      SymbolStyleLayer.defaultIconRotationAlignment;

  @override
  set iconRotationAlignment(PropertyValue<IconRotationAlignment> property) =>
      requireMap.setLayoutProperty(
        id,
        'icon-rotation-alignment',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get iconSize =>
      requireMap.getLayoutProperty(id, 'icon-size').toPropertyValue<double>() ??
      SymbolStyleLayer.defaultIconSize;

  @override
  set iconSize(PropertyValue<double> property) =>
      requireMap.setLayoutProperty(id, 'icon-size', property.toJson().jsify());

  @override
  PropertyValue<IconTextFit> get iconTextFit =>
      requireMap
          .getLayoutProperty(id, 'icon-text-fit')
          .toEnumPropertyValue(IconTextFit.values) ??
      SymbolStyleLayer.defaultIconTextFit;

  @override
  set iconTextFit(PropertyValue<IconTextFit> property) => requireMap
      .setLayoutProperty(id, 'icon-text-fit', property.toJson().jsify());

  @override
  PropertyValue<EdgeInsets> get iconTextFitPadding =>
      requireMap
          .getLayoutProperty(id, 'icon-text-fit-padding')
          .toEdgeInsetsPropertyValue() ??
      SymbolStyleLayer.defaultIconTextFitPadding;

  @override
  set iconTextFitPadding(PropertyValue<EdgeInsets> property) =>
      requireMap.setLayoutProperty(
        id,
        'icon-text-fit-padding',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<String>? get iconImage =>
      requireMap.getLayoutProperty(id, 'icon-image').toPropertyValue<String>();

  @override
  set iconImage(PropertyValue<String>? property) => requireMap
      .setLayoutProperty(id, 'icon-image', property?.toJson().jsify());

  @override
  PropertyValue<double> get iconRotate =>
      requireMap
          .getLayoutProperty(id, 'icon-rotate')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultIconRotate;

  @override
  set iconRotate(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'icon-rotate', property.toJson().jsify());

  @override
  PropertyValue<EdgeInsets> get iconPadding =>
      requireMap
          .getLayoutProperty(id, 'icon-padding')
          .toEdgeInsetsPropertyValue() ??
      SymbolStyleLayer.defaultIconPadding;

  @override
  set iconPadding(PropertyValue<EdgeInsets> property) => requireMap
      .setLayoutProperty(id, 'icon-padding', property.toJson().jsify());

  @override
  PropertyValue<bool> get iconKeepUpright =>
      requireMap
          .getLayoutProperty(id, 'icon-keep-upright')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultIconKeepUpright;

  @override
  set iconKeepUpright(PropertyValue<bool> property) => requireMap
      .setLayoutProperty(id, 'icon-keep-upright', property.toJson().jsify());

  @override
  PropertyValue<Offset> get iconOffset =>
      requireMap.getLayoutProperty(id, 'icon-offset').toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultIconOffset;

  @override
  set iconOffset(PropertyValue<Offset> property) => requireMap
      .setLayoutProperty(id, 'icon-offset', property.toJson().jsify());

  @override
  PropertyValue<IconAnchor> get iconAnchor =>
      requireMap
          .getLayoutProperty(id, 'icon-anchor')
          .toEnumPropertyValue(IconAnchor.values) ??
      SymbolStyleLayer.defaultIconAnchor;

  @override
  set iconAnchor(PropertyValue<IconAnchor> property) => requireMap
      .setLayoutProperty(id, 'icon-anchor', property.toJson().jsify());

  @override
  PropertyValue<IconPitchAlignment> get iconPitchAlignment =>
      requireMap
          .getLayoutProperty(id, 'icon-pitch-alignment')
          .toEnumPropertyValue(IconPitchAlignment.values) ??
      SymbolStyleLayer.defaultIconPitchAlignment;

  @override
  set iconPitchAlignment(PropertyValue<IconPitchAlignment> property) =>
      requireMap.setLayoutProperty(
        id,
        'icon-pitch-alignment',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<TextPitchAlignment> get textPitchAlignment =>
      requireMap
          .getLayoutProperty(id, 'text-pitch-alignment')
          .toEnumPropertyValue(TextPitchAlignment.values) ??
      SymbolStyleLayer.defaultTextPitchAlignment;

  @override
  set textPitchAlignment(PropertyValue<TextPitchAlignment> property) =>
      requireMap.setLayoutProperty(
        id,
        'text-pitch-alignment',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<TextRotationAlignment> get textRotationAlignment =>
      requireMap
          .getLayoutProperty(id, 'text-rotation-alignment')
          .toEnumPropertyValue(TextRotationAlignment.values) ??
      SymbolStyleLayer.defaultTextRotationAlignment;

  @override
  set textRotationAlignment(PropertyValue<TextRotationAlignment> property) =>
      requireMap.setLayoutProperty(
        id,
        'text-rotation-alignment',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<String> get textField =>
      requireMap
          .getLayoutProperty(id, 'text-field')
          .toPropertyValue<String>() ??
      SymbolStyleLayer.defaultTextField;

  @override
  set textField(PropertyValue<String> property) =>
      requireMap.setLayoutProperty(id, 'text-field', property.toJson().jsify());

  @override
  PropertyValue<List<String>> get textFont =>
      requireMap
          .getLayoutProperty(id, 'text-font')
          .toPropertyValue<List<String>>() ??
      SymbolStyleLayer.defaultTextFont;

  @override
  set textFont(PropertyValue<List<String>> property) =>
      requireMap.setLayoutProperty(id, 'text-font', property.toJson().jsify());

  @override
  PropertyValue<double> get textSize =>
      requireMap.getLayoutProperty(id, 'text-size').toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextSize;

  @override
  set textSize(PropertyValue<double> property) =>
      requireMap.setLayoutProperty(id, 'text-size', property.toJson().jsify());

  @override
  PropertyValue<double> get textMaxWidth =>
      requireMap
          .getLayoutProperty(id, 'text-max-width')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextMaxWidth;

  @override
  set textMaxWidth(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-max-width', property.toJson().jsify());

  @override
  PropertyValue<double> get textLineHeight =>
      requireMap
          .getLayoutProperty(id, 'text-line-height')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextLineHeight;

  @override
  set textLineHeight(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-line-height', property.toJson().jsify());

  @override
  PropertyValue<double> get textLetterSpacing =>
      requireMap
          .getLayoutProperty(id, 'text-letter-spacing')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextLetterSpacing;

  @override
  set textLetterSpacing(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-letter-spacing', property.toJson().jsify());

  @override
  PropertyValue<TextJustify> get textJustify =>
      requireMap
          .getLayoutProperty(id, 'text-justify')
          .toEnumPropertyValue(TextJustify.values) ??
      SymbolStyleLayer.defaultTextJustify;

  @override
  set textJustify(PropertyValue<TextJustify> property) => requireMap
      .setLayoutProperty(id, 'text-justify', property.toJson().jsify());

  @override
  PropertyValue<double> get textRadialOffset =>
      requireMap
          .getLayoutProperty(id, 'text-radial-offset')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextRadialOffset;

  @override
  set textRadialOffset(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-radial-offset', property.toJson().jsify());

  @override
  PropertyValue<List<IconAnchor>>? get textVariableAnchor => requireMap
      .getLayoutProperty(id, 'text-variable-anchor')
      .toEnumListPropertyValue(IconAnchor.values);

  @override
  set textVariableAnchor(PropertyValue<List<IconAnchor>>? property) =>
      requireMap.setLayoutProperty(
        id,
        'text-variable-anchor',
        property?.toJson().jsify(),
      );

  @override
  PropertyValue<Map<String, Offset>>? get textVariableAnchorOffset => requireMap
      .getLayoutProperty(id, 'text-variable-anchor-offset')
      .toStringOffsetMapPropertyValue();

  @override
  set textVariableAnchorOffset(PropertyValue<Map<String, Offset>>? property) =>
      requireMap.setLayoutProperty(
        id,
        'text-variable-anchor-offset',
        property?.toJson().jsify(),
      );

  @override
  PropertyValue<TextAnchor> get textAnchor =>
      requireMap
          .getLayoutProperty(id, 'text-anchor')
          .toEnumPropertyValue(TextAnchor.values) ??
      SymbolStyleLayer.defaultTextAnchor;

  @override
  set textAnchor(PropertyValue<TextAnchor> property) => requireMap
      .setLayoutProperty(id, 'text-anchor', property.toJson().jsify());

  @override
  PropertyValue<double> get textMaxAngle =>
      requireMap
          .getLayoutProperty(id, 'text-max-angle')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextMaxAngle;

  @override
  set textMaxAngle(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-max-angle', property.toJson().jsify());

  @override
  PropertyValue<List<TextWritingMode>>? get textWritingMode => requireMap
      .getLayoutProperty(id, 'text-writing-mode')
      .toEnumListPropertyValue(TextWritingMode.values);

  @override
  set textWritingMode(PropertyValue<List<TextWritingMode>>? property) =>
      requireMap.setLayoutProperty(
        id,
        'text-writing-mode',
        property?.toJson().jsify(),
      );

  @override
  PropertyValue<double> get textRotate =>
      requireMap
          .getLayoutProperty(id, 'text-rotate')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextRotate;

  @override
  set textRotate(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-rotate', property.toJson().jsify());

  @override
  PropertyValue<double> get textPadding =>
      requireMap
          .getLayoutProperty(id, 'text-padding')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextPadding;

  @override
  set textPadding(PropertyValue<double> property) => requireMap
      .setLayoutProperty(id, 'text-padding', property.toJson().jsify());

  @override
  PropertyValue<bool> get textKeepUpright =>
      requireMap
          .getLayoutProperty(id, 'text-keep-upright')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultTextKeepUpright;

  @override
  set textKeepUpright(PropertyValue<bool> property) => requireMap
      .setLayoutProperty(id, 'text-keep-upright', property.toJson().jsify());

  @override
  PropertyValue<TextTransform> get textTransform =>
      requireMap
          .getLayoutProperty(id, 'text-transform')
          .toEnumPropertyValue(TextTransform.values) ??
      SymbolStyleLayer.defaultTextTransform;

  @override
  set textTransform(PropertyValue<TextTransform> property) => requireMap
      .setLayoutProperty(id, 'text-transform', property.toJson().jsify());

  @override
  PropertyValue<Offset> get textOffset =>
      requireMap.getLayoutProperty(id, 'text-offset').toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultTextOffset;

  @override
  set textOffset(PropertyValue<Offset> property) => requireMap
      .setLayoutProperty(id, 'text-offset', property.toJson().jsify());

  @override
  PropertyValue<bool> get textAllowOverlap =>
      requireMap
          .getLayoutProperty(id, 'text-allow-overlap')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultTextAllowOverlap;

  @override
  set textAllowOverlap(PropertyValue<bool> property) => requireMap
      .setLayoutProperty(id, 'text-allow-overlap', property.toJson().jsify());

  @override
  PropertyValue<SymbolOverlap>? get textOverlap => requireMap
      .getLayoutProperty(id, 'text-overlap')
      .toEnumPropertyValue(SymbolOverlap.values);

  @override
  set textOverlap(PropertyValue<SymbolOverlap>? property) => requireMap
      .setLayoutProperty(id, 'text-overlap', property?.toJson().jsify());

  @override
  PropertyValue<bool> get textIgnorePlacement =>
      requireMap
          .getLayoutProperty(id, 'text-ignore-placement')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultTextIgnorePlacement;

  @override
  set textIgnorePlacement(PropertyValue<bool> property) =>
      requireMap.setLayoutProperty(
        id,
        'text-ignore-placement',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<bool> get textOptional =>
      requireMap
          .getLayoutProperty(id, 'text-optional')
          .toPropertyValue<bool>() ??
      SymbolStyleLayer.defaultTextOptional;

  @override
  set textOptional(PropertyValue<bool> property) => requireMap
      .setLayoutProperty(id, 'text-optional', property.toJson().jsify());

  @override
  PropertyValue<double> get iconOpacity =>
      requireMap
          .getPaintProperty(id, 'icon-opacity')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultIconOpacity;

  @override
  set iconOpacity(PropertyValue<double> property) => requireMap
      .setPaintProperty(id, 'icon-opacity', property.toJson().jsify());

  @override
  PropertyValue<Color> get iconColor =>
      requireMap.getPaintProperty(id, 'icon-color').toColorPropertyValue() ??
      SymbolStyleLayer.defaultIconColor;

  @override
  set iconColor(PropertyValue<Color> property) =>
      requireMap.setPaintProperty(id, 'icon-color', property.toJson().jsify());

  @override
  PropertyValue<Color> get iconHaloColor =>
      requireMap
          .getPaintProperty(id, 'icon-halo-color')
          .toColorPropertyValue() ??
      SymbolStyleLayer.defaultIconHaloColor;

  @override
  set iconHaloColor(PropertyValue<Color> property) => requireMap
      .setPaintProperty(id, 'icon-halo-color', property.toJson().jsify());

  @override
  PropertyValue<double> get iconHaloWidth =>
      requireMap
          .getPaintProperty(id, 'icon-halo-width')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultIconHaloWidth;

  @override
  set iconHaloWidth(PropertyValue<double> property) => requireMap
      .setPaintProperty(id, 'icon-halo-width', property.toJson().jsify());

  @override
  PropertyValue<double> get iconHaloBlur =>
      requireMap
          .getPaintProperty(id, 'icon-halo-blur')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultIconHaloBlur;

  @override
  set iconHaloBlur(PropertyValue<double> property) => requireMap
      .setPaintProperty(id, 'icon-halo-blur', property.toJson().jsify());

  @override
  PropertyValue<Offset> get iconTranslate =>
      requireMap
          .getPaintProperty(id, 'icon-translate')
          .toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultIconTranslate;

  @override
  set iconTranslate(PropertyValue<Offset> property) => requireMap
      .setPaintProperty(id, 'icon-translate', property.toJson().jsify());

  @override
  PropertyValue<ReferenceSpace> get iconTranslateAnchor =>
      requireMap
          .getPaintProperty(id, 'icon-translate-anchor')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      SymbolStyleLayer.defaultIconTranslateAnchor;

  @override
  set iconTranslateAnchor(PropertyValue<ReferenceSpace> property) => requireMap
      .setPaintProperty(id, 'icon-translate-anchor', property.toJson().jsify());

  @override
  PropertyValue<double> get textOpacity =>
      requireMap
          .getPaintProperty(id, 'text-opacity')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextOpacity;

  @override
  set textOpacity(PropertyValue<double> property) => requireMap
      .setPaintProperty(id, 'text-opacity', property.toJson().jsify());

  @override
  PropertyValue<Color> get textColor =>
      requireMap.getPaintProperty(id, 'text-color').toColorPropertyValue() ??
      SymbolStyleLayer.defaultTextColor;

  @override
  set textColor(PropertyValue<Color> property) =>
      requireMap.setPaintProperty(id, 'text-color', property.toJson().jsify());

  @override
  PropertyValue<Color> get textHaloColor =>
      requireMap
          .getPaintProperty(id, 'text-halo-color')
          .toColorPropertyValue() ??
      SymbolStyleLayer.defaultTextHaloColor;

  @override
  set textHaloColor(PropertyValue<Color> property) => requireMap
      .setPaintProperty(id, 'text-halo-color', property.toJson().jsify());

  @override
  PropertyValue<double> get textHaloWidth =>
      requireMap
          .getPaintProperty(id, 'text-halo-width')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextHaloWidth;

  @override
  set textHaloWidth(PropertyValue<double> property) => requireMap
      .setPaintProperty(id, 'text-halo-width', property.toJson().jsify());

  @override
  PropertyValue<double> get textHaloBlur =>
      requireMap
          .getPaintProperty(id, 'text-halo-blur')
          .toPropertyValue<double>() ??
      SymbolStyleLayer.defaultTextHaloBlur;

  @override
  set textHaloBlur(PropertyValue<double> property) => requireMap
      .setPaintProperty(id, 'text-halo-blur', property.toJson().jsify());

  @override
  PropertyValue<Offset> get textTranslate =>
      requireMap
          .getPaintProperty(id, 'text-translate')
          .toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultTextTranslate;

  @override
  set textTranslate(PropertyValue<Offset> property) => requireMap
      .setPaintProperty(id, 'text-translate', property.toJson().jsify());

  @override
  PropertyValue<ReferenceSpace> get textTranslateAnchor =>
      requireMap
          .getPaintProperty(id, 'text-translate-anchor')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      SymbolStyleLayer.defaultTextTranslateAnchor;

  @override
  set textTranslateAnchor(PropertyValue<ReferenceSpace> property) => requireMap
      .setPaintProperty(id, 'text-translate-anchor', property.toJson().jsify());

  @override
  Expression? get filter => switch (jsLayer.filter.dartify()) {
    final List<Object?> json => Expression.fromJson(json),
    _ => null,
  };

  @override
  set filter(Expression? value) => jsLayer.filter = value?.json.jsify();

  @override
  String? get sourceLayerId => jsLayer.sourceLayer;

  @override
  set sourceLayerId(String? value) => jsLayer.sourceLayer = value;

  @override
  String get sourceId => jsLayer.source!;
}
