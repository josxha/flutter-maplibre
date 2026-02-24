part of 'style_layer.dart';

/// Web implementation of [FillStyleLayer].
class FillStyleLayerWeb extends StyleLayerWeb implements FillStyleLayer {
  /// Default constructor for a [FillStyleLayerWeb] instance.
  FillStyleLayerWeb({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<bool> antialias,
    required PropertyValue<Color> color,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> outlineColor,
    required PropertyValue<String>? pattern,
  }) : super.fromNativeLayer(
          jsLayer: js.LayerSpecification(
            id: id,
            type: 'fill',
            maxzoom: maxZoom,
            minzoom: minZoom,
            source: sourceId,
            layout:
                createFillLayout(visible: visible, sortKey: sortKey).jsify(),
            paint: createFillPaint(
              antialias: antialias,
              color: color,
              opacity: opacity,
              outlineColor: outlineColor,
              pattern: pattern,
              translate: translate,
              translateAnchor: translateAnchor,
            ).jsify(),
          ),
        ) {
    if (sourceLayerId case final id?) jsLayer.sourceLayer = id;
    if (filter case final filter?) jsLayer.filter = filter.json.jsify()!;
  }

  @override
  PropertyValue<bool> get antialias =>
      requireMap.getPaintProperty(id, 'fill-antialias').toPropertyValue<bool>() ??
      FillStyleLayer.defaultAntialias;

  @override
  set antialias(PropertyValue<bool> property) => requireMap.setPaintProperty(
        id,
        'fill-antialias',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<Color> get color =>
      requireMap.getPaintProperty(id, 'fill-color').toColorPropertyValue() ??
      FillStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => requireMap.setPaintProperty(
        id,
        'fill-color',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get opacity =>
      requireMap.getPaintProperty(id, 'fill-opacity').toPropertyValue<double>() ??
      FillStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'fill-opacity',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<Color> get outlineColor =>
      requireMap
              .getPaintProperty(id, 'fill-outline-color')
              .toColorPropertyValue() ??
      FillStyleLayer.defaultOutlineColor;

  @override
  set outlineColor(PropertyValue<Color> property) => requireMap.setPaintProperty(
        id,
        'fill-outline-color',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<String>? get pattern => requireMap
      .getPaintProperty(id, 'fill-pattern')
      .toPropertyValue<String>();

  @override
  set pattern(PropertyValue<String>? property) => requireMap.setPaintProperty(
        id,
        'fill-pattern',
        property?.toJson().jsify(),
      );

  @override
  Expression? get filter =>
      Expression.fromJson(jsLayer.filter.dartify()! as List<Object?>);

  @override
  set filter(Expression? value) => jsLayer.filter = value!.json.jsify()!;

  @override
  PropertyValue<double>? get sortKey =>
      requireMap.getLayoutProperty(id, 'fill-sort-key').toPropertyValue<double>();

  @override
  set sortKey(PropertyValue<double>? value) => requireMap.setLayoutProperty(
        id,
        'fill-sort-key',
        value?.toJson().jsify(),
      );

  @override
  String? get sourceLayerId => jsLayer.sourceLayer;

  @override
  set sourceLayerId(String? value) => jsLayer.sourceLayer = value;

  @override
  PropertyValue<Offset> get translate =>
      requireMap.getPaintProperty(id, 'fill-translate').toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => requireMap.setPaintProperty(
        id,
        'fill-translate',
        value.toJson().jsify(),
      );

  @override
  PropertyValue<ReferenceSpace> get translateAnchor => requireMap
          .getPaintProperty(id, 'fill-translate-anchor')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => requireMap
      .setPaintProperty(id, 'fill-translate-anchor', value.toJson().jsify());

  @override
  String get sourceId => jsLayer.source!;
}
