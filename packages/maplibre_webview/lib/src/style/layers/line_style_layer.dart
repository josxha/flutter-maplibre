part of 'style_layer.dart';

class LineStyleLayerWebView extends StyleLayerWebView
    implements LineStyleLayer {
  LineStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.visible,
    required this.minZoom,
    required this.maxZoom,
    required this.sourceLayerId,
    required this.filter,
    required this.sortKey,
    required this.translate,
    required this.translateAnchor,
    required this.cap,
    required this.join,
    required this.miterLimit,
    required this.roundLimit,
    required this.opacity,
    required this.color,
    required this.width,
    required this.gapWidth,
    required this.offset,
    required this.blur,
    required this.dashArray,
    required this.pattern,
    required this.gradient,
  });

  @override
  Map<String, Object?> get layout => createLineLayout(
    visible: visible,
    cap: cap,
    join: join,
    miterLimit: miterLimit,
    roundLimit: roundLimit,
    sortKey: sortKey,
  );

  @override
  Map<String, Object?> get paint => createLinePaint(
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
  );

  @override
  String? sourceLayerId;

  @override
  Expression? filter;

  @override
  PropertyValue<double>? sortKey;

  @override
  PropertyValue<Offset> translate;

  @override
  PropertyValue<ReferenceSpace> translateAnchor;

  @override
  PropertyValue<LineCap> cap;

  @override
  PropertyValue<LineJoin> join;

  @override
  PropertyValue<double> miterLimit;

  @override
  PropertyValue<double> roundLimit;

  @override
  PropertyValue<double> opacity;

  @override
  PropertyValue<Color> color;

  @override
  PropertyValue<double> width;

  @override
  PropertyValue<double> gapWidth;

  @override
  PropertyValue<double> offset;

  @override
  PropertyValue<double> blur;

  @override
  PropertyValue<List<double>>? dashArray;

  @override
  PropertyValue<String>? pattern;

  @override
  PropertyValue<Color>? gradient;

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
