part of 'style_layer.dart';

/// Web implementation of [LineStyleLayer].
class LineStyleLayerWeb extends StyleLayerWeb implements LineStyleLayer {
  /// Default constructor for a [LineStyleLayerWeb] instance.
  LineStyleLayerWeb({
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
    required PropertyValue<LineCap> cap,
    required PropertyValue<LineJoin> join,
    required PropertyValue<double> miterLimit,
    required PropertyValue<double> roundLimit,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<double> width,
    required PropertyValue<double> gapWidth,
    required PropertyValue<double> offset,
    required PropertyValue<double> blur,
    required PropertyValue<List<double>>? dashArray,
    required PropertyValue<String>? pattern,
    required PropertyValue<Color>? gradient,
  }) : super.fromNativeLayer(
          jsLayer: js.LayerSpecification(
            id: id,
            type: 'line',
            maxzoom: maxZoom,
            minzoom: minZoom,
            source: sourceId,
            layout: createLineLayout(
              visible: visible,
              cap: cap,
              join: join,
              miterLimit: miterLimit,
              roundLimit: roundLimit,
              sortKey: sortKey,
            ).jsify(),
            paint: createLinePaint(
              opacity: opacity,
              color: color,
              translate: translate,
              translateAnchor: translateAnchor,
              width: width,
              gapWidth: gapWidth,
              offset: offset,
              blur: blur,
              dashArray: dashArray,
              pattern: pattern,
              gradient: gradient,
            ).jsify(),
          ),
        ) {
    if (sourceLayerId case final id?) jsLayer.sourceLayer = id;
    if (filter case final filter?) jsLayer.filter = filter.json.jsify()!;
  }

  @override
  PropertyValue<LineCap> get cap =>
      requireMap
          .getLayoutProperty(id, 'line-cap')
          .toEnumPropertyValue(LineCap.values) ??
      LineStyleLayer.defaultCap;

  @override
  set cap(PropertyValue<LineCap> property) => requireMap.setLayoutProperty(
        id,
        'line-cap',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<LineJoin> get join =>
      requireMap
          .getLayoutProperty(id, 'line-join')
          .toEnumPropertyValue(LineJoin.values) ??
      LineStyleLayer.defaultJoin;

  @override
  set join(PropertyValue<LineJoin> property) => requireMap.setLayoutProperty(
        id,
        'line-join',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get miterLimit =>
      requireMap
              .getLayoutProperty(id, 'line-miter-limit')
              .toPropertyValue<double>() ??
      LineStyleLayer.defaultMiterLimit;

  @override
  set miterLimit(PropertyValue<double> property) => requireMap.setLayoutProperty(
        id,
        'line-miter-limit',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get roundLimit =>
      requireMap
              .getLayoutProperty(id, 'line-round-limit')
              .toPropertyValue<double>() ??
      LineStyleLayer.defaultRoundLimit;

  @override
  set roundLimit(PropertyValue<double> property) => requireMap.setLayoutProperty(
        id,
        'line-round-limit',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double>? get sortKey =>
      requireMap.getLayoutProperty(id, 'line-sort-key').toPropertyValue<double>();

  @override
  set sortKey(PropertyValue<double>? value) => requireMap.setLayoutProperty(
        id,
        'line-sort-key',
        value?.toJson().jsify(),
      );

  @override
  PropertyValue<double> get opacity =>
      requireMap.getPaintProperty(id, 'line-opacity').toPropertyValue<double>() ??
      LineStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'line-opacity',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<Color> get color =>
      requireMap.getPaintProperty(id, 'line-color').toColorPropertyValue() ??
      LineStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => requireMap.setPaintProperty(
        id,
        'line-color',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get width =>
      requireMap.getPaintProperty(id, 'line-width').toPropertyValue<double>() ??
      LineStyleLayer.defaultWidth;

  @override
  set width(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'line-width',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get gapWidth =>
      requireMap.getPaintProperty(id, 'line-gap-width').toPropertyValue<double>() ??
      LineStyleLayer.defaultGapWidth;

  @override
  set gapWidth(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'line-gap-width',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get offset =>
      requireMap.getPaintProperty(id, 'line-offset').toPropertyValue<double>() ??
      LineStyleLayer.defaultOffset;

  @override
  set offset(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'line-offset',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get blur =>
      requireMap.getPaintProperty(id, 'line-blur').toPropertyValue<double>() ??
      LineStyleLayer.defaultBlur;

  @override
  set blur(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'line-blur',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<List<double>>? get dashArray => requireMap
      .getPaintProperty(id, 'line-dasharray')
      .toPropertyValue<List<double>>();

  @override
  set dashArray(PropertyValue<List<double>>? property) => requireMap
      .setPaintProperty(id, 'line-dasharray', property?.toJson().jsify());

  @override
  PropertyValue<String>? get pattern =>
      requireMap.getPaintProperty(id, 'line-pattern').toPropertyValue<String>();

  @override
  set pattern(PropertyValue<String>? property) => requireMap
      .setPaintProperty(id, 'line-pattern', property?.toJson().jsify());

  @override
  PropertyValue<Color>? get gradient =>
      requireMap.getPaintProperty(id, 'line-gradient').toColorPropertyValue();

  @override
  set gradient(PropertyValue<Color>? property) => requireMap
      .setPaintProperty(id, 'line-gradient', property?.toJson().jsify());

  @override
  PropertyValue<Offset> get translate =>
      requireMap.getPaintProperty(id, 'line-translate').toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => requireMap.setPaintProperty(
        id,
        'line-translate',
        value.toJson().jsify(),
      );

  @override
  PropertyValue<ReferenceSpace> get translateAnchor => requireMap
          .getPaintProperty(id, 'line-translate-anchor')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => requireMap
      .setPaintProperty(id, 'line-translate-anchor', value.toJson().jsify());

  @override
  Expression? get filter =>
      Expression.fromJson(jsLayer.filter.dartify()! as List<Object?>);

  @override
  set filter(Expression? value) => jsLayer.filter = value!.json.jsify()!;

  @override
  String? get sourceLayerId => jsLayer.sourceLayer;

  @override
  set sourceLayerId(String? value) => jsLayer.sourceLayer = value;

  @override
  String get sourceId => jsLayer.source!;
}
