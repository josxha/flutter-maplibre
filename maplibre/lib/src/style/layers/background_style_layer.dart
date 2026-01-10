part of 'style_layer.dart';

/// A simple background layer.
///
/// https://maplibre.org/maplibre-style-spec/layers/#background
///
/// {@category Style}
/// {@subCategory Style Layers}
final class BackgroundStyleLayer extends StyleLayer {
  /// Create a new [BackgroundStyleLayer].
  const BackgroundStyleLayer({
    required super.id,
    this.visible = true,
    this.color = const Color(0x00000000),
    this.opacity = 1,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.metadata,
  });

  /// Whether this layer is displayed.
  ///
  /// Defaults to visible.
  final bool visible;

  /// The color with which the background will be drawn.
  ///
  /// Defaults to #000000 (black).
  final Color color;

  /// The opacity at which the background will be drawn.
  ///
  /// Defaults to 1.
  final double opacity;
}
