import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A [StyleBackend] that records its calls as strings.
class RecordingStyleBackend implements StyleBackend {
  final calls = <String>[];

  /// The specification of the last tile source update.
  Map<String, Object?>? lastSpecification;

  /// Makes the next call that returns a future fail.
  bool failNext = false;

  Future<void> _done() async {
    if (!failNext) return;
    failNext = false;
    throw StateError('The map rejected it.');
  }

  @override
  Future<void> addLayer(Map<String, Object?> json, {String? belowLayerId}) {
    calls.add('addLayer ${json['id']} below $belowLayerId');
    return _done();
  }

  @override
  Future<void> removeLayer(String id) {
    calls.add('removeLayer $id');
    return _done();
  }

  @override
  void moveLayer(String id, {String? belowLayerId}) =>
      calls.add('moveLayer $id below $belowLayerId');

  @override
  void setLayerProperty(
    String layerId,
    String name,
    Object? value, {
    required bool layout,
  }) => calls.add('${layout ? 'setLayout' : 'setPaint'} $layerId $name $value');

  @override
  void setFilter(String layerId, Object? filter) =>
      calls.add('setFilter $layerId $filter');

  @override
  void setZoomRange(String layerId, double minZoom, double maxZoom) =>
      calls.add('setZoomRange $layerId $minZoom $maxZoom');

  @override
  Future<void> addSource(Source source) {
    calls.add('addSource ${source.id}');
    return _done();
  }

  @override
  Future<void> removeSource(String id) {
    calls.add('removeSource $id');
    return _done();
  }

  @override
  Future<void> setGeoJsonData(String id, String data) {
    calls.add('setGeoJsonData $id $data');
    return _done();
  }

  @override
  Future<void> setGeoJsonUrl(String id, String url) {
    calls.add('setGeoJsonUrl $id $url');
    return _done();
  }

  @override
  Future<void> setImageCoordinates(String id, LngLatQuad coordinates) {
    calls.add('setImageCoordinates $id');
    return _done();
  }

  @override
  Future<void> setTiles(
    String id,
    List<String> tiles,
    Map<String, Object?> specification,
  ) {
    calls.add('setTiles $id $tiles');
    lastSpecification = specification;
    return _done();
  }

  @override
  Future<void> setTileJsonUrl(
    String id,
    String url,
    Map<String, Object?> specification,
  ) {
    calls.add('setTileJsonUrl $id $url');
    lastSpecification = specification;
    return _done();
  }
}
