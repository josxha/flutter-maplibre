part of 'source.dart';

/// An image source. The url value contains the image location. The coordinates
/// array contains [longitude, latitude] pairs for the image corners listed in
/// clockwise order: top left, top right, bottom right, bottom left.
///
/// https://maplibre.org/maplibre-style-spec/sources/#image
final class ImageSource extends Source {
  /// The default constructor for a [ImageSource] object.
  const ImageSource({
    required this.id,
    required this.url,
    required this.coordinates,
  });

  /// The id of the [ImageSource].
  final String id;

  /// URL that points to an image.
  final String url;

  /// Corners of image specified in longitude, latitude pairs.
  final List<Position> coordinates;
}
