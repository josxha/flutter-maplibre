import 'package:flutter/foundation.dart';

/// The style of a map: a MapLibre style document from a URL, a JSON string,
/// a Flutter asset or a file.
///
/// See [MapStyleUrl], [MapStyleJson], [MapStyleAsset] and [MapStyleFile].
///
/// {@category Basic}
@immutable
sealed class MapStyle {
  const MapStyle();

  /// A style document at [url], such as `https://…/style.json`.
  ///
  /// The native backend also loads `file://`, `asset://` and `mapbox://`
  /// URLs.
  const factory MapStyle.url(String url) = MapStyleUrl;

  /// A style document given as a JSON string.
  const factory MapStyle.json(String json) = MapStyleJson;

  /// A style document in the Flutter asset with the key [asset], such as
  /// `assets/style.json`.
  const factory MapStyle.asset(String asset) = MapStyleAsset;

  /// A style document in the file at [path]. Not supported on web.
  const factory MapStyle.file(String path) = MapStyleFile;

  /// The default MapLibre demo style.
  static const MapStyle demo = MapStyle.url(
    'https://demotiles.maplibre.org/style.json',
  );
}

/// A [MapStyle] loaded from a URL.
///
/// {@category Basic}
final class MapStyleUrl extends MapStyle {
  /// Creates a [MapStyle] from [url].
  const MapStyleUrl(this.url);

  /// The URL of the style document.
  final String url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MapStyleUrl && url == other.url;

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => 'MapStyle.url($url)';
}

/// A [MapStyle] given as a JSON string.
///
/// {@category Basic}
final class MapStyleJson extends MapStyle {
  /// Creates a [MapStyle] from the style document [json].
  const MapStyleJson(this.json);

  /// The style document as JSON.
  final String json;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MapStyleJson && json == other.json;

  @override
  int get hashCode => json.hashCode;

  @override
  String toString() => 'MapStyle.json(${json.length} characters)';
}

/// A [MapStyle] loaded from a Flutter asset.
///
/// {@category Basic}
final class MapStyleAsset extends MapStyle {
  /// Creates a [MapStyle] from the Flutter asset [asset].
  const MapStyleAsset(this.asset);

  /// The key of the asset, as listed in `pubspec.yaml`.
  final String asset;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MapStyleAsset && asset == other.asset;

  @override
  int get hashCode => asset.hashCode;

  @override
  String toString() => 'MapStyle.asset($asset)';
}

/// A [MapStyle] loaded from a file. Not supported on web.
///
/// {@category Basic}
final class MapStyleFile extends MapStyle {
  /// Creates a [MapStyle] from the file at [path].
  const MapStyleFile(this.path);

  /// The path of the file.
  final String path;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MapStyleFile && path == other.path;

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() => 'MapStyle.file($path)';
}
