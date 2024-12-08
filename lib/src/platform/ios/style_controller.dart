part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerIos implements StyleController {
  const StyleControllerIos._();

  @override
  Future<void> addImage(String id, Uint8List bytes) {
    // TODO: implement addImage
    throw UnimplementedError();
  }

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) {
    // TODO: implement addLayer
    throw UnimplementedError();
  }

  @override
  Future<void> addSource(Source source) {
    // TODO: implement addSource
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<List<String>> getAttributions() {
    // TODO: implement getAttributions
    throw UnimplementedError();
  }

  @override
  Future<void> removeImage(String id) {
    // TODO: implement removeImage
    throw UnimplementedError();
  }

  @override
  Future<void> removeLayer(String id) {
    // TODO: implement removeLayer
    throw UnimplementedError();
  }

  @override
  Future<void> removeSource(String id) {
    // TODO: implement removeSource
    throw UnimplementedError();
  }

  @override
  Future<void> updateGeoJsonSource({required String id, required String data}) {
    // TODO: implement updateGeoJsonSource
    throw UnimplementedError();
  }
}
