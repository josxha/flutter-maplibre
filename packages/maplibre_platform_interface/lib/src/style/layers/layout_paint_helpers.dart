part of 'style_layer.dart';

/// Helper functions to create layout and paint properties for different layer
/// types.
Map<String, Object?> createBackgroundLayout({required bool visible}) => {
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [BackgroundStyleLayer].
Map<String, Object?> createBackgroundPaint({
  required PropertyValue<Color> color,
  required PropertyValue<String>? pattern,
  required PropertyValue<double> opacity,
}) => {
  'background-color': color.toJson(),
  if (pattern case final pattern?) 'background-pattern': pattern.toJson(),
  'background-opacity': opacity.toJson(),
};

/// Creates a map of layout properties for a [CircleStyleLayer].
Map<String, Object?> createCircleLayout({
  required bool visible,
  required PropertyValue<double>? sortKey,
}) => {
  if (sortKey case final sortKey?) 'circle-sort-key': sortKey.toJson(),
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [CircleStyleLayer].
Map<String, Object?> createCirclePaint({
  required PropertyValue<double> radius,
  required PropertyValue<Color> color,
  required PropertyValue<double> blur,
  required PropertyValue<double> opacity,
  required PropertyValue<Offset> translate,
  required PropertyValue<ReferenceSpace> translateAnchor,
  required PropertyValue<ReferenceSpace> pitchScale,
  required PropertyValue<ReferenceSpace> pitchAlignment,
  required PropertyValue<double> strokeWidth,
  required PropertyValue<Color> strokeColor,
  required PropertyValue<double> strokeOpacity,
}) => {
  'circle-radius': radius.toJson(),
  'circle-color': color.toJson(),
  'circle-blur': blur.toJson(),
  'circle-opacity': opacity.toJson(),
  'circle-translate': translate.toJson(),
  'circle-translate-anchor': translateAnchor.toJson(),
  'circle-pitch-scale': pitchScale.toJson(),
  'circle-pitch-alignment': pitchAlignment.toJson(),
  'circle-stroke-width': strokeWidth.toJson(),
  'circle-stroke-color': strokeColor.toJson(),
  'circle-stroke-opacity': strokeOpacity.toJson(),
};

/// Creates a map of layout properties for a [ColorReliefStyleLayer].
Map<String, Object?> createColorReliefLayout({required bool visible}) => {
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [ColorReliefStyleLayer].
Map<String, Object?> createColorReliefPaint({
  required PropertyValue<Color>? color,
  required PropertyValue<double> opacity,
}) => {
  if (color case final color?) 'color-relief-color': color.toJson(),
  'color-relief-opacity': opacity.toJson(),
};

/// Creates a map of layout properties for a [FillExtrusionStyleLayer].
Map<String, Object?> createFillExtrusionLayout({required bool visible}) => {
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [FillExtrusionStyleLayer].
Map<String, Object?> createFillExtrusionPaint({
  required PropertyValue<double> opacity,
  required PropertyValue<Color> color,
  required PropertyValue<String>? pattern,
  required PropertyValue<double> height,
  required PropertyValue<double> base,
  required PropertyValue<bool> verticalGradient,
  required PropertyValue<Offset> translate,
  required PropertyValue<ReferenceSpace> translateAnchor,
}) => {
  'fill-extrusion-opacity': opacity.toJson(),
  'fill-extrusion-color': color.toJson(),
  'fill-extrusion-translate': translate.toJson(),
  'fill-extrusion-translate-anchor': translateAnchor.toJson(),
  if (pattern case final pattern?) 'fill-extrusion-pattern': pattern.toJson(),
  'fill-extrusion-height': height.toJson(),
  'fill-extrusion-base': base.toJson(),
  'fill-extrusion-vertical-gradient': verticalGradient.toJson(),
};

/// Creates a map of layout properties for a [FillStyleLayer].
Map<String, Object?> createFillLayout({
  required bool visible,
  required PropertyValue<double>? sortKey,
}) => {
  if (sortKey case final sortKey?) 'fill-sort-key': sortKey.toJson(),
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [FillStyleLayer].
Map<String, Object?> createFillPaint({
  required PropertyValue<bool> antialias,
  required PropertyValue<Color> color,
  required PropertyValue<double> opacity,
  required PropertyValue<Color> outlineColor,
  required PropertyValue<Offset> translate,
  required PropertyValue<ReferenceSpace> translateAnchor,
  required PropertyValue<String>? pattern,
}) => {
  'fill-antialias': antialias.toJson(),
  'fill-color': color.toJson(),
  'fill-opacity': opacity.toJson(),
  'fill-outline-color': outlineColor.toJson(),
  'fill-translate': translate.toJson(),
  'fill-translate-anchor': translateAnchor.toJson(),
  if (pattern case final pattern?) 'fill-pattern': pattern.toJson(),
};

/// Creates a map of layout properties for a [HeatmapStyleLayer].
Map<String, Object?> createHeatmapLayout({required bool visible}) => {
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [HeatmapStyleLayer].
Map<String, Object?> createHeatmapPaint({
  required PropertyValue<double> radius,
  required PropertyValue<double> weight,
  required PropertyValue<double> intensity,
  required PropertyValue<Color>? color,
  required PropertyValue<double> opacity,
}) => {
  'heatmap-radius': radius.toJson(),
  'heatmap-weight': weight.toJson(),
  'heatmap-intensity': intensity.toJson(),
  if (color != null) 'heatmap-color': color.toJson(),
  'heatmap-opacity': opacity.toJson(),
};

/// Creates a map of layout properties for a [HillshadeStyleLayer].
Map<String, Object?> createHillshadeLayout({required bool visible}) => {
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [HillshadeStyleLayer].
Map<String, Object?> createHillshadePaint({
  required PropertyValue<NumberArray> illuminationDirection,
  required PropertyValue<NumberArray> illuminationAltitude,
  required PropertyValue<IlluminationAnchor> illuminationAnchor,
  required PropertyValue<double> exaggeration,
  required PropertyValue<Color> shadowColor,
  required PropertyValue<Color> highlightColor,
  required PropertyValue<Color> accentColor,
  required PropertyValue<HillshadeMethod> method,
}) => {
  'hillshade-illumination-direction': illuminationDirection.toJson(),
  'hillshade-illumination-altitude': illuminationAltitude.toJson(),
  'hillshade-illumination-anchor': illuminationAnchor.toJson(),
  'hillshade-exaggeration': exaggeration.toJson(),
  'hillshade-shadow-color': shadowColor.toJson(),
  'hillshade-highlight-color': highlightColor.toJson(),
  'hillshade-accent-color': accentColor.toJson(),
  'hillshade-method': method.toJson(),
};

/// Creates a map of layout properties for a [LineStyleLayer].
Map<String, Object?> createLineLayout({
  required bool visible,
  required PropertyValue<LineCap> cap,
  required PropertyValue<LineJoin> join,
  required PropertyValue<double> miterLimit,
  required PropertyValue<double> roundLimit,
  required PropertyValue<double>? sortKey,
}) => {
  'line-cap': cap.toJson(),
  'line-join': join.toJson(),
  'line-miter-limit': miterLimit.toJson(),
  'line-round-limit': roundLimit.toJson(),
  if (sortKey case final sortKey?) 'line-sort-key': sortKey.toJson(),
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [LineStyleLayer].
Map<String, Object?> createLinePaint({
  required PropertyValue<double> opacity,
  required PropertyValue<Color> color,
  required PropertyValue<Offset> translate,
  required PropertyValue<ReferenceSpace> translateAnchor,
  required PropertyValue<double> width,
  required PropertyValue<double> gapWidth,
  required PropertyValue<double> offset,
  required PropertyValue<double> blur,
  required PropertyValue<List<double>>? dashArray,
  required PropertyValue<String>? pattern,
  required PropertyValue<Color>? gradient,
}) => {
  'line-opacity': opacity.toJson(),
  'line-color': color.toJson(),
  'line-translate': translate.toJson(),
  'line-translate-anchor': translateAnchor.toJson(),
  'line-width': width.toJson(),
  'line-gap-width': gapWidth.toJson(),
  'line-offset': offset.toJson(),
  'line-blur': blur.toJson(),
  if (dashArray case final dashArray?) 'line-dasharray': dashArray.toJson(),
  if (pattern case final pattern?) 'line-pattern': pattern.toJson(),
  if (gradient case final gradient?) 'line-gradient': gradient.toJson(),
};

/// Creates a map of layout properties for a [RasterStyleLayer].
Map<String, Object?> createRasterLayout({required bool visible}) => {
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [RasterStyleLayer].
Map<String, Object?> createRasterPaint({
  required PropertyValue<double> opacity,
  required PropertyValue<double> hueRotate,
  required PropertyValue<double> brightnessMin,
  required PropertyValue<double> brightnessMax,
  required PropertyValue<double> saturation,
  required PropertyValue<double> contrast,
  required PropertyValue<RasterResampling> resampling,
  required PropertyValue<double> fadeDuration,
}) => {
  'raster-opacity': opacity.toJson(),
  'raster-hue-rotate': hueRotate.toJson(),
  'raster-brightness-min': brightnessMin.toJson(),
  'raster-brightness-max': brightnessMax.toJson(),
  'raster-saturation': saturation.toJson(),
  'raster-contrast': contrast.toJson(),
  'raster-resampling': resampling.toJson(),
  'raster-fade-duration': fadeDuration.toJson(),
};

/// Creates a map of layout properties for a [SymbolStyleLayer].
Map<String, Object?> createSymbolLayout({
  required bool visible,
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
}) => {
  'symbol-placement': placement.toJson(),
  'symbol-spacing': spacing.toJson(),
  'symbol-avoid-edges': avoidEdges.toJson(),
  if (sortKey case final sortKey?) 'symbol-sort-key': sortKey.toJson(),
  'symbol-z-order': zOrder.toJson(),
  'icon-allow-overlap': iconAllowOverlap.toJson(),
  'icon-overlap': iconOverlap.toJson(),
  'icon-ignore-placement': iconIgnorePlacement.toJson(),
  'icon-optional': iconOptional.toJson(),
  'icon-rotation-alignment': iconRotationAlignment.toJson(),
  'icon-size': iconSize.toJson(),
  'icon-text-fit': iconTextFit.toJson(),
  'icon-text-fit-padding': iconTextFitPadding.toJson(),
  if (iconImage case final iconImage?) 'icon-image': iconImage.toJson(),
  'icon-rotate': iconRotate.toJson(),
  'icon-padding': iconPadding.toJson(),
  'icon-keep-upright': iconKeepUpright.toJson(),
  'icon-offset': iconOffset.toJson(),
  'icon-anchor': iconAnchor.toJson(),
  'icon-pitch-alignment': iconPitchAlignment.toJson(),
  'text-pitch-alignment': textPitchAlignment.toJson(),
  'text-rotation-alignment': textRotationAlignment.toJson(),
  'text-field': textField.toJson(),
  'text-font': textFont.toJson(),
  'text-size': textSize.toJson(),
  'text-max-width': textMaxWidth.toJson(),
  'text-line-height': textLineHeight.toJson(),
  'text-letter-spacing': textLetterSpacing.toJson(),
  'text-justify': textJustify.toJson(),
  'text-radial-offset': textRadialOffset.toJson(),
  if (textVariableAnchor case final textVariableAnchor?)
    'text-variable-anchor': textVariableAnchor.toJson(),
  if (textVariableAnchorOffset case final textVariableAnchorOffset?)
    'text-variable-anchor-offset': textVariableAnchorOffset.toJson(),
  'text-anchor': textAnchor.toJson(),
  'text-max-angle': textMaxAngle.toJson(),
  if (textWritingMode case final textWritingMode?)
    'text-writing-mode': textWritingMode.toJson(),
  'text-rotate': textRotate.toJson(),
  'text-padding': textPadding.toJson(),
  'text-keep-upright': textKeepUpright.toJson(),
  'text-transform': textTransform.toJson(),
  'text-offset': textOffset.toJson(),
  'text-allow-overlap': textAllowOverlap.toJson(),
  if (textOverlap case final textOverlap?) 'text-overlap': textOverlap.toJson(),
  'text-ignore-placement': textIgnorePlacement.toJson(),
  'text-optional': textOptional.toJson(),
  'visibility': visible ? 'visible' : 'none',
};

/// Creates a map of paint properties for a [SymbolStyleLayer].
Map<String, Object?> createSymbolPaint({
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
}) => {
  'icon-opacity': iconOpacity.toJson(),
  'icon-color': iconColor.toJson(),
  'icon-halo-color': iconHaloColor.toJson(),
  'icon-halo-width': iconHaloWidth.toJson(),
  'icon-halo-blur': iconHaloBlur.toJson(),
  'icon-translate': iconTranslate.toJson(),
  'icon-translate-anchor': iconTranslateAnchor.toJson(),
  'text-opacity': textOpacity.toJson(),
  'text-color': textColor.toJson(),
  'text-halo-color': textHaloColor.toJson(),
  'text-halo-width': textHaloWidth.toJson(),
  'text-halo-blur': textHaloBlur.toJson(),
  'text-translate': textTranslate.toJson(),
  'text-translate-anchor': textTranslateAnchor.toJson(),
};
