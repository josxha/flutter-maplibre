part of 'style_layer.dart';

/// WebView implementation of [HeatmapStyleLayer].
class HeatmapStyleLayerWebView extends StyleLayerWebView
    implements HeatmapStyleLayer {
  /// Creates a heatmap style layer.
  HeatmapStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.sourceLayerId,
    required this.filter,
    required this.visible,
    required this.minZoom,
    required this.maxZoom,
    required this.radius,
    required this.weight,
    required this.intensity,
    required this.color,
    required this.opacity,
  });

  @override
  Map<String, Object?> get layout => createHeatmapLayout(visible: visible);

  @override
  Map<String, Object?> get paint => createHeatmapPaint(
    radius: radius,
    weight: weight,
    intensity: intensity,
    color: color,
    opacity: opacity,
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
  PropertyValue<double> radius;

  @override
  PropertyValue<double> weight;

  @override
  PropertyValue<double> intensity;

  @override
  PropertyValue<Color>? color;

  @override
  PropertyValue<double> opacity;
}
