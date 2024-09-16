part of 'source.dart';

/// A video source. The urls value is an array. For each URL in the array, a
/// video element source will be created. To support the video across
/// browsers, supply URLs in multiple formats.
///
/// The coordinates array contains [longitude, latitude] pairs for the video
/// corners listed in clockwise order: top left, top right, bottom right, bottom
/// left.
///
/// When rendered as a raster layer, the layer's raster-fade-duration property
/// will cause the video to fade in. This happens when playback is started,
/// paused and resumed, or when the video's coordinates are updated. To avoid
/// this behavior, set the layer's raster-fade-duration property to 0.
///
/// Only supported on web.
///
/// https://maplibre.org/maplibre-style-spec/sources/#video
final class VideoSource extends Source {
  /// The default constructor for a [VideoSource] object.
  const VideoSource({
    required this.id,
    required this.urls,
    required this.coordinates,
  });

  /// The id of the [VideoSource].
  final String id;

  /// URLs to video content in order of preferred format.
  final List<String> urls;

  /// Corners of video specified in longitude, latitude pairs.
  final List<Position> coordinates;
}
