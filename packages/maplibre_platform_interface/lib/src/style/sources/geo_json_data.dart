part of 'source.dart';

/// The data of a [GeoJsonSource]: geobase objects, or GeoJSON that is
/// already decoded or still text.
///
/// Building geobase objects costs time for large data. GeoJSON that comes
/// as text, such as from a file or a server, can go to the map as
/// [GeoJsonData.text] without being decoded in Dart first: on web the browser
/// parses it.
///
/// ```dart
/// GeoJsonSource.data(
///   id: 'points',
///   data: .featureCollection(FeatureCollection([...])),
/// );
/// GeoJsonSource.data(id: 'routes', data: .text(response.body));
/// ```
///
/// {@category Style}
/// {@subCategory Style Sources}
@immutable
sealed class GeoJsonData {
  const GeoJsonData();

  /// The features of [collection].
  const factory GeoJsonData.featureCollection(FeatureCollection collection) =
      GeoJsonDataFeatureCollection;

  /// The single [feature].
  const factory GeoJsonData.feature(Feature feature) = GeoJsonDataFeature;

  /// The single [geometry], without properties.
  const factory GeoJsonData.geometry(Geometry geometry) = GeoJsonDataGeometry;

  /// Decoded GeoJSON, such as a `FeatureCollection` map that [jsonDecode]
  /// returns.
  const factory GeoJsonData.json(Map<String, Object?> json) = GeoJsonDataJson;

  /// GeoJSON text, such as the content of a `.geojson` file.
  const factory GeoJsonData.text(String text) = GeoJsonDataText;

  /// The data as GeoJSON text.
  String toText();

  /// The data as decoded GeoJSON.
  Map<String, Object?> toJson() => jsonDecode(toText()) as Map<String, Object?>;
}

/// [GeoJsonData] of a geobase [FeatureCollection].
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonDataFeatureCollection extends GeoJsonData {
  /// Creates [GeoJsonData] of [collection].
  const GeoJsonDataFeatureCollection(this.collection);

  /// The features.
  final FeatureCollection collection;

  @override
  String toText() => collection.toText();

  @override
  bool operator ==(Object other) =>
      other is GeoJsonDataFeatureCollection && collection == other.collection;

  @override
  int get hashCode => collection.hashCode;
}

/// [GeoJsonData] of a geobase [Feature].
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonDataFeature extends GeoJsonData {
  /// Creates [GeoJsonData] of [feature].
  const GeoJsonDataFeature(this.feature);

  /// The feature.
  final Feature feature;

  @override
  String toText() => feature.toText();

  @override
  bool operator ==(Object other) =>
      other is GeoJsonDataFeature && feature == other.feature;

  @override
  int get hashCode => feature.hashCode;
}

/// [GeoJsonData] of a geobase [Geometry].
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonDataGeometry extends GeoJsonData {
  /// Creates [GeoJsonData] of [geometry].
  const GeoJsonDataGeometry(this.geometry);

  /// The geometry.
  final Geometry geometry;

  @override
  String toText() => geometry.toText();

  @override
  bool operator ==(Object other) =>
      other is GeoJsonDataGeometry && geometry == other.geometry;

  @override
  int get hashCode => geometry.hashCode;
}

/// [GeoJsonData] of decoded GeoJSON.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonDataJson extends GeoJsonData {
  /// Creates [GeoJsonData] of the decoded GeoJSON [json].
  const GeoJsonDataJson(this.json);

  /// The decoded GeoJSON.
  final Map<String, Object?> json;

  @override
  String toText() => jsonEncode(json);

  @override
  Map<String, Object?> toJson() => json;

  @override
  bool operator ==(Object other) =>
      other is GeoJsonDataJson && jsonEquals(json, other.json);

  @override
  int get hashCode => jsonHash(json);
}

/// [GeoJsonData] of GeoJSON text.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonDataText extends GeoJsonData {
  /// Creates [GeoJsonData] of the GeoJSON [text].
  const GeoJsonDataText(this.text);

  /// The GeoJSON text.
  final String text;

  @override
  String toText() => text;

  @override
  bool operator ==(Object other) =>
      other is GeoJsonDataText && text == other.text;

  @override
  int get hashCode => text.hashCode;
}
