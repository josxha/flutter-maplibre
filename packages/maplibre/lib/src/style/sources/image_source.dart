part of 'source.dart';

/// An image source. The url value contains the image location. The coordinates
/// array contains [Position]s for the image corners listed in
/// clockwise order: top left, top right, bottom right, bottom left.
///
/// https://maplibre.org/maplibre-style-spec/sources/#image
///
/// {@category Style}
/// {@subCategory Style Sources}
final class ImageSource extends Source {
  /// The default constructor for a [ImageSource] object.
  const ImageSource({
    required super.id,
    required this.url,
    required this.coordinates,
  });

  /// URL that points to an image.
  final String url;

  /// Corners of image specified in longitude, latitude pairs.
  final LngLatQuad coordinates;
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

  /// The position of the bottom left corner.
  final Geographic bottomLeft;

  /// The position of the bottom right corner.
  final Geographic bottomRight;

  /// The position of the top left corner.
  final Geographic topLeft;

  /// The position of the top right corner.
  final Geographic topRight;
}
