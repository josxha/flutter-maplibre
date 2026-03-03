part of 'style_layer.dart';

/// WebView implementation of [FillStyleLayer].
class FillStyleLayerWebView extends StyleLayerWebView
    implements FillStyleLayer {
  /// Creates a fill style layer.
  FillStyleLayerWebView({
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
    required this.antialias,
    required this.color,
    required this.opacity,
    required this.outlineColor,
    required this.pattern,
  });

  @override
  Map<String, Object?> get layout =>
      createFillLayout(visible: visible, sortKey: sortKey);

  @override
  Map<String, Object?> get paint => createFillPaint(
    antialias: antialias,
    color: color,
    opacity: opacity,
    outlineColor: outlineColor,
    translate: translate,
    translateAnchor: translateAnchor,
    pattern: pattern,
  );

  @override
  final String id;

  @override
  final String sourceId;

  @override
  bool visible;

  @override
  double minZoom;

  @override
  double maxZoom;

  @override
  Expression? filter;

  @override
  String? sourceLayerId;

  @override
  PropertyValue<double>? sortKey;

  @override
  PropertyValue<Offset> translate;

  @override
  PropertyValue<ReferenceSpace> translateAnchor;

  @override
  PropertyValue<bool> antialias;

  @override
  PropertyValue<Color> color;

  @override
  PropertyValue<double> opacity;

  @override
  PropertyValue<Color> outlineColor;

  @override
  PropertyValue<String>? pattern;
}
