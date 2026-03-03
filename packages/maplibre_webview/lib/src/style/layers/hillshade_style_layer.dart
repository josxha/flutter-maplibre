part of 'style_layer.dart';

/// WebView implementation of [HillshadeStyleLayer].
class HillshadeStyleLayerWebView extends StyleLayerWebView
    implements HillshadeStyleLayer {
  /// Creates a hillshade style layer.
  HillshadeStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.visible,
    required this.minZoom,
    required this.maxZoom,
    required this.illuminationDirection,
    required this.illuminationAltitude,
    required this.illuminationAnchor,
    required this.exaggeration,
    required this.shadowColor,
    required this.highlightColor,
    required this.accentColor,
    required this.method,
  });

  @override
  Map<String, Object?> get layout => createHillshadeLayout(visible: visible);

  @override
  Map<String, Object?> get paint => createHillshadePaint(
    illuminationDirection: illuminationDirection,
    illuminationAltitude: illuminationAltitude,
    illuminationAnchor: illuminationAnchor,
    exaggeration: exaggeration,
    shadowColor: shadowColor,
    highlightColor: highlightColor,
    accentColor: accentColor,
    method: method,
  );

  @override
  bool visible;

  @override
  double minZoom;

  @override
  double maxZoom;

  @override
  PropertyValue<NumberArray> illuminationDirection;

  @override
  PropertyValue<NumberArray> illuminationAltitude;

  @override
  PropertyValue<IlluminationAnchor> illuminationAnchor;

  @override
  PropertyValue<double> exaggeration;

  @override
  PropertyValue<Color> shadowColor;

  @override
  PropertyValue<Color> highlightColor;

  @override
  PropertyValue<Color> accentColor;

  @override
  PropertyValue<HillshadeMethod> method;

  @override
  final String id;

  @override
  final String sourceId;
}
