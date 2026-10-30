part of 'source.dart';

/// A video source, from URLs ([VideoSource.urls]), encoded video bytes
/// ([VideoSource.bytes]) or a Flutter asset ([VideoSource.asset]).
///
/// The [coordinates] are the four corners of the video.
///
/// When rendered as a raster layer, the layer's raster-fade-duration property
/// will cause the video to fade in. This happens when playback is started,
/// paused and resumed, or when the video's coordinates are updated. To avoid
/// this behavior, set the layer's raster-fade-duration property to 0.
///
/// Only supported on web. MapLibre Native has no video sources, so adding one
/// to a native map throws an [UnsupportedError].
///
/// https://maplibre.org/maplibre-style-spec/sources/#video
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class VideoSource extends Source {
  const VideoSource._({required super.id, required this.coordinates});

  /// A video from [urls]. For each URL, a video element source is created,
  /// so supply URLs in multiple formats to support the video across browsers.
  const factory VideoSource.urls({
    required String id,
    required List<String> urls,
    required LngLatQuad coordinates,
  }) = VideoSourceUrls;

  /// A video from encoded video [bytes], such as an MP4 or WebM file.
  const factory VideoSource.bytes({
    required String id,
    required Uint8List bytes,
    required LngLatQuad coordinates,
  }) = VideoSourceBytes;

  /// A video in the Flutter asset with the key [asset], such as
  /// `assets/video.mp4`.
  const factory VideoSource.asset({
    required String id,
    required String asset,
    required LngLatQuad coordinates,
  }) = VideoSourceAsset;

  /// The corners of the video.
  final LngLatQuad coordinates;

  @override
  Map<String, Object?>? toJson() => switch (this) {
    VideoSourceUrls(:final urls) => {
      'type': 'video',
      'urls': urls,
      'coordinates': coordinates.toJson(),
    },
    _ => null,
  };
}

/// A [VideoSource] from URLs.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class VideoSourceUrls extends VideoSource {
  /// Creates a [VideoSource] from [urls].
  const VideoSourceUrls({
    required super.id,
    required this.urls,
    required super.coordinates,
  }) : super._();

  /// URLs to video content in order of preferred format.
  final List<String> urls;
}

/// A [VideoSource] from encoded video bytes.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class VideoSourceBytes extends VideoSource {
  /// Creates a [VideoSource] from the encoded video [bytes].
  const VideoSourceBytes({
    required super.id,
    required this.bytes,
    required super.coordinates,
  }) : super._();

  /// The encoded video, such as the content of an MP4 or WebM file.
  final Uint8List bytes;
}

/// A [VideoSource] from a Flutter asset.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class VideoSourceAsset extends VideoSource {
  /// Creates a [VideoSource] from the Flutter asset [asset].
  const VideoSourceAsset({
    required super.id,
    required this.asset,
    required super.coordinates,
  }) : super._();

  /// The key of the asset, as listed in `pubspec.yaml`.
  final String asset;
}
