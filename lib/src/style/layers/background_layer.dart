part of 'layer.dart';

/// https://maplibre.org/maplibre-style-spec/layers/#background
final class BackgroundLayer extends Layer {
  /// Create a new [BackgroundLayer].
  const BackgroundLayer({
    required super.id,
    this.visible = true,
    this.color = const Color(0x00000000),
    this.opacity = 1,
    super.layout,
    super.paint,
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
