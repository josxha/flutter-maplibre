part of 'source.dart';

/// An image source that drapes an image over the four [coordinates] of a
/// quadrilateral. The image comes from a URL ([ImageSource.url]), encoded
/// image bytes ([ImageSource.bytes]) or a Flutter [ImageProvider]
/// ([ImageSource.provider]).
///
/// https://maplibre.org/maplibre-style-spec/sources/#image
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class ImageSource extends Source {
  const ImageSource._({required super.id, required this.coordinates});

  /// An image that the map loads from [url].
  ///
  /// The native backend also loads `file://` and `asset://` URLs, and loads
  /// remote images through the MapLibre cache.
  const factory ImageSource.url({
    required String id,
    required String url,
    required LngLatQuad coordinates,
  }) = ImageSourceUrl;

  /// An image from encoded image [bytes], such as a PNG or JPEG file.
  const factory ImageSource.bytes({
    required String id,
    required Uint8List bytes,
    required LngLatQuad coordinates,
  }) = ImageSourceBytes;

  /// An image from a Flutter [ImageProvider], such as an [AssetImage],
  /// [FileImage], [NetworkImage] or [MemoryImage].
  ///
  /// The provider is resolved for the device pixel ratio, so an [AssetImage]
  /// picks the matching resolution variant.
  const factory ImageSource.provider({
    required String id,
    required ImageProvider image,
    required LngLatQuad coordinates,
  }) = ImageSourceProvider;

  /// Corners of image specified in longitude, latitude pairs.
  final LngLatQuad coordinates;

  @override
  Map<String, Object?>? toJson() => switch (this) {
    ImageSourceUrl(:final url) => {
      'type': 'image',
      'url': url,
      'coordinates': coordinates.toJson(),
    },
    _ => null,
  };
}

/// An [ImageSource] that loads its image from a URL.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class ImageSourceUrl extends ImageSource {
  /// Creates an [ImageSource] that loads its image from [url].
  const ImageSourceUrl({
    required super.id,
    required this.url,
    required super.coordinates,
  }) : super._();

  /// URL that points to an image.
  final String url;
}

/// An [ImageSource] from encoded image bytes.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class ImageSourceBytes extends ImageSource {
  /// Creates an [ImageSource] from the encoded image [bytes].
  const ImageSourceBytes({
    required super.id,
    required this.bytes,
    required super.coordinates,
  }) : super._();

  /// The encoded image, such as the content of a PNG or JPEG file.
  final Uint8List bytes;
}

/// An [ImageSource] from a Flutter [ImageProvider].
///
/// {@category Style}
/// {@subCategory Style Sources}
final class ImageSourceProvider extends ImageSource {
  /// Creates an [ImageSource] from the image of [image].
  const ImageSourceProvider({
    required super.id,
    required this.image,
    required super.coordinates,
  }) : super._();

  /// The provider of the image.
  final ImageProvider image;
}

/// A class that defines 4 corners.
class LngLatQuad {
  /// Create a new [LngLatQuad] instance.
  const LngLatQuad({
    required this.bottomLeft,
    required this.bottomRight,
    required this.topLeft,
    required this.topRight,
  });

  factory LngLatQuad._fromJson(Object? json) {
    final points = [
      for (final point in (json as List<Object?>?) ?? const <Object?>[])
        switch (point) {
          [final num lon, final num lat] => Geographic(
            lon: lon.toDouble(),
            lat: lat.toDouble(),
          ),
          _ => const Geographic(lon: 0, lat: 0),
        },
    ];
    Geographic corner(int index) => index < points.length
        ? points[index]
        : const Geographic(lon: 0, lat: 0);
    return LngLatQuad(
      topLeft: corner(0),
      topRight: corner(1),
      bottomRight: corner(2),
      bottomLeft: corner(3),
    );
  }

  /// The position of the bottom left corner.
  final Geographic bottomLeft;

  /// The position of the bottom right corner.
  final Geographic bottomRight;

  /// The position of the top left corner.
  final Geographic topLeft;

  /// The position of the top right corner.
  final Geographic topRight;

  /// The corners as the `coordinates` of a style source: longitude and
  /// latitude pairs, clockwise from the top left.
  List<List<double>> toJson() => [
    [topLeft.lon, topLeft.lat],
    [topRight.lon, topRight.lat],
    [bottomRight.lon, bottomRight.lat],
    [bottomLeft.lon, bottomLeft.lat],
  ];
}
