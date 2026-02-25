part of '../interop.dart';

/// The specifications of map sources.
@anonymous
@JS()
extension type SourceSpecification._(JSObject _) implements JSObject {
  /// The default constructor for a [SourceSpecification].
  external SourceSpecification({required String type});

  /// Create a new GeoJSON source.
  external factory SourceSpecification.geoJson({
    required String type,
    required JSAny data,
    num? maxzoom,
    String? attribution,
    num? buffer,
  });

  /// Create a new raster DEM source.
  external factory SourceSpecification.rasterDem({
    required String type,
    required int tileSize,
    required String? attribution,
    String? url,
    JSAny? tiles,
  });

  /// Create a new raster source.
  external factory SourceSpecification.raster({
    required String type,
    required int tileSize,
    required String? attribution,
    JSAny? tiles,
    String? url,
  });

  /// Create a new vector source.
  external factory SourceSpecification.vector({
    required String type,
    required String? url,
  });

  /// Create a new image source.
  external factory SourceSpecification.image({
    required String type,
    required String url,
    required JSAny coordinates,
  });

  /// Create a new video source.
  external factory SourceSpecification.video({
    required String type,
    required JSAny urls,
    required JSAny coordinates,
  });

  /// Used to update the data of a GeoJSON source.
  external void setData(JSAny data);
}
