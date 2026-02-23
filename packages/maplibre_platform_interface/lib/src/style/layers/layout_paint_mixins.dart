part of 'style_layer.dart';

mixin LayoutPaintMixin on StyleLayer {
  /// A set of key-value pairs specifying the layout properties of the layer.
  Map<String, Object?> get layout;

  /// A set of key-value pairs specifying the paint properties of the layer.
  Map<String, Object?> get paint;
}

mixin BackgroundStyleLayerMixin on BackgroundStyleLayer
    implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'background-color': color.toJson(),
    if (pattern case final pattern?) 'background-pattern': pattern.toJson(),
    'background-opacity': opacity.toJson(),
  };
}

mixin CircleStyleLayerMixin on CircleStyleLayer implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    if (sortKey case final sortKey?) 'fill-sort-key': sortKey.toJson(),
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
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
}

mixin ColorReliefStyleLayerMixin on ColorReliefStyleLayer
    implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'color-relief-color': color?.toJson(),
    'color-relief-opacity': opacity.toJson(),
  };
}

mixin FillExtrusionStyleLayerMixin on FillExtrusionStyleLayer
    implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'fill-extrusion-opacity': opacity.toJson(),
    'fill-extrusion-color': color.toJson(),
    'fill-extrusion-translate': translate.toJson(),
    'fill-extrusion-translate-anchor': translateAnchor.toJson(),
    'fill-extrusion-pattern': pattern?.toJson(),
    'fill-extrusion-height': height.toJson(),
    'fill-extrusion-base': base.toJson(),
    'fill-extrusion-vertical-gradient': verticalGradient.toJson(),
  };
}

mixin FillStyleLayerMixin on FillStyleLayer implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    if (sortKey case final sortKey?) 'fill-sort-key': sortKey.toJson(),
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'fill-antialias': antialias.toJson(),
    'fill-color': color.toJson(),
    'fill-opacity': opacity.toJson(),
    'fill-outline-color': outlineColor.toJson(),
    'fill-translate': translate.toJson(),
    'fill-translate-anchor': translateAnchor.toJson(),
    if (pattern case final pattern?) 'fill-pattern': pattern.toJson(),
  };
}

mixin HeatmapStyleLayerMixin on HeatmapStyleLayer implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'heatmap-radius': radius.toJson(),
    'heatmap-weight': weight.toJson(),
    'heatmap-intensity': intensity.toJson(),
    if (color != null) 'heatmap-color': color!.toJson(),
    'heatmap-opacity': opacity.toJson(),
  };
}

mixin HillshadeStyleLayerMixin on HillshadeStyleLayer
    implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'hillshade-illumination-direction': illuminationDirection.toJson(),
    'hillshade-illumination-altitude': illuminationAltitude.toJson(),
    'hillshade-illumination-anchor': illuminationAnchor.toJson(),
    'hillshade-exaggeration': exaggeration.toJson(),
    'hillshade-shadow-color': shadowColor.toJson(),
    'hillshade-highlight-color': highlightColor.toJson(),
    'hillshade-accent-color': accentColor.toJson(),
    'hillshade-method': method.toJson(),
  };
}

mixin LineStyleLayerMixin on LineStyleLayer implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'line-cap': cap.toJson(),
    'line-join': join.toJson(),
    'line-miter-limit': miterLimit.toJson(),
    'line-round-limit': roundLimit.toJson(),
    if (sortKey case final sortKey?) 'line-sort-key': sortKey.toJson(),
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
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
}

mixin RasterStyleLayerMixin on RasterStyleLayer implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
    'raster-opacity': opacity.toJson(),
    'raster-hue-rotate': hueRotate.toJson(),
    'raster-brightness-min': brightnessMin.toJson(),
    'raster-brightness-max': brightnessMax.toJson(),
    'raster-saturation': saturation.toJson(),
    'raster-contrast': contrast.toJson(),
    'raster-resampling': resampling.toJson(),
    'raster-fade-duration': fadeDuration.toJson(),
  };
}

mixin SymbolStyleLayerMixin on SymbolStyleLayer implements LayoutPaintMixin {
  @override
  Map<String, Object?> get layout => {
    'symbol-placement': placement.toJson(),
    'symbol-spacing': spacing.toJson(),
    'symbol-avoid-edges': avoidEdges.toJson(),
    if (sortKey case final sortKey?) 'symbol-sort-key': sortKey.toJson(),
    'symbol-z-order': zOrder.toJson(),
    'icon-allow-overlap': iconAllowOverlap.toJson(),
    if (iconOverlap case final iconOverlap?)
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
    'text-writing-mode': textWritingMode?.toJson(),
    'text-rotate': textRotate.toJson(),
    'text-padding': textPadding.toJson(),
    'text-keep-upright': textKeepUpright.toJson(),
    'text-transform': textTransform.toJson(),
    'text-offset': textOffset.toJson(),
    'text-allow-overlap': textAllowOverlap.toJson(),
    if (textOverlap case final textOverlap?)
      'text-overlap': textOverlap.toJson(),
    'text-ignore-placement': textIgnorePlacement.toJson(),
    'text-optional': textOptional.toJson(),
    'visibility': visible ? 'visible' : 'none',
  };

  @override
  Map<String, Object?> get paint => {
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
}
