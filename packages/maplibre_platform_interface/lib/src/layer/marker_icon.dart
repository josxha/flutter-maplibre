import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The image of the markers of a layer, which the map adds to the style for
/// it, see [Layer.icon].
///
/// The map adds each image once, for every layer that shows it, removes it
/// once no layer shows it, and adds it again when another style loads.
/// Layers share an image when their icons are equal.
///
/// {@category Layers}
@immutable
sealed class MarkerIcon {
  const MarkerIcon._();

  /// The icon [icon], such as one of the `Icons` of Material, drawn [size]
  /// logical pixels large in [color].
  const factory MarkerIcon.iconData(IconData icon, {Color color, double size}) =
      MarkerIconData;

  /// The image of the Flutter asset [path], with [pixelRatio] image pixels
  /// per logical pixel, see [StyleController.addImage].
  const factory MarkerIcon.asset(String path, {double pixelRatio}) =
      MarkerIconAsset;

  /// The encoded image [bytes], such as a PNG, with [pixelRatio] image pixels
  /// per logical pixel, see [StyleController.addImage].
  ///
  /// Icons of equal bytes are equal. Pass the same list again on rebuilds,
  /// which saves comparing them.
  const factory MarkerIcon.bytes(Uint8List bytes, {double pixelRatio}) =
      MarkerIconBytes;

  /// The image of the Flutter [ImageProvider] [provider], such as an
  /// [AssetImage] or a [NetworkImage], at the scale of the image it loads.
  const factory MarkerIcon.provider(ImageProvider provider) =
      MarkerIconProvider;

  /// The image [imageId] that the style already has, from its sprite or from
  /// [StyleController.addImage]. The map doesn't add or remove it.
  const factory MarkerIcon.named(String imageId) = MarkerIconNamed;

  /// The image of the style that [imageId] picks for each feature, such as
  /// `Expression.get('icon').asString()` for the image named in a property of the
  /// feature. The map doesn't add or remove images for it.
  const factory MarkerIcon.expression(Expression<String> imageId) =
      MarkerIconExpression;
}

/// See [MarkerIcon.iconData].
///
/// {@category Layers}
final class MarkerIconData extends MarkerIcon {
  /// See [MarkerIcon.iconData].
  const MarkerIconData(
    this.icon, {
    this.color = const Color(0xFF000000),
    this.size = 48,
  }) : super._();

  /// The icon to draw.
  final IconData icon;

  /// The color of the icon. Defaults to black.
  final Color color;

  /// The width and height of the image in logical pixels, which it has at
  /// an icon size of 1. Defaults to 48.
  final double size;

  @override
  bool operator ==(Object other) =>
      other is MarkerIconData &&
      icon == other.icon &&
      color == other.color &&
      size == other.size;

  @override
  int get hashCode => Object.hash(icon, color, size);
}

/// See [MarkerIcon.asset].
///
/// {@category Layers}
final class MarkerIconAsset extends MarkerIcon {
  /// See [MarkerIcon.asset].
  const MarkerIconAsset(this.path, {this.pixelRatio = 1}) : super._();

  /// The path of the asset.
  final String path;

  /// The image pixels per logical pixel. Defaults to 1.
  final double pixelRatio;

  @override
  bool operator ==(Object other) =>
      other is MarkerIconAsset &&
      path == other.path &&
      pixelRatio == other.pixelRatio;

  @override
  int get hashCode => Object.hash(path, pixelRatio);
}

/// See [MarkerIcon.bytes].
///
/// {@category Layers}
final class MarkerIconBytes extends MarkerIcon {
  /// See [MarkerIcon.bytes].
  const MarkerIconBytes(this.bytes, {this.pixelRatio = 1}) : super._();

  /// The encoded image.
  final Uint8List bytes;

  /// The image pixels per logical pixel. Defaults to 1.
  final double pixelRatio;

  @override
  bool operator ==(Object other) =>
      other is MarkerIconBytes &&
      pixelRatio == other.pixelRatio &&
      (identical(bytes, other.bytes) || listEquals(bytes, other.bytes));

  // Hashing every byte would cost as much as comparing them, so the hash only
  // takes the length and the first and last bytes.
  @override
  int get hashCode => Object.hash(
    pixelRatio,
    bytes.length,
    Object.hashAll(bytes.take(16)),
    Object.hashAll(bytes.skip(bytes.length > 16 ? bytes.length - 16 : 0)),
  );
}

/// See [MarkerIcon.provider].
///
/// {@category Layers}
final class MarkerIconProvider extends MarkerIcon {
  /// See [MarkerIcon.provider].
  const MarkerIconProvider(this.provider) : super._();

  /// The provider of the image.
  final ImageProvider provider;

  @override
  bool operator ==(Object other) =>
      other is MarkerIconProvider && provider == other.provider;

  @override
  int get hashCode => provider.hashCode;
}

/// See [MarkerIcon.named].
///
/// {@category Layers}
final class MarkerIconNamed extends MarkerIcon {
  /// See [MarkerIcon.named].
  const MarkerIconNamed(this.imageId) : super._();

  /// The id of the image in the style.
  final String imageId;

  @override
  bool operator ==(Object other) =>
      other is MarkerIconNamed && imageId == other.imageId;

  @override
  int get hashCode => imageId.hashCode;
}

/// See [MarkerIcon.expression].
///
/// {@category Layers}
final class MarkerIconExpression extends MarkerIcon {
  /// See [MarkerIcon.expression].
  const MarkerIconExpression(this.imageId) : super._();

  /// The expression that picks the id of the image of the style.
  final Expression<String> imageId;

  @override
  bool operator ==(Object other) =>
      other is MarkerIconExpression && imageId == other.imageId;

  @override
  int get hashCode => imageId.hashCode;
}
