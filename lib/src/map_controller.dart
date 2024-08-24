import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform_interface.dart';

class MapController extends ChangeNotifier {
  MapController({
    required MapLibrePlatform maplibrePlatform,
    required this.onStyleLoadedCallback,
  }) : _maplibrePlatform = maplibrePlatform {
    onStyleLoadedCallback?.call();
  }

  final MapLibrePlatform _maplibrePlatform;
  final VoidCallback? onStyleLoadedCallback;

  @override
  void dispose() {
    super.dispose();
    _maplibrePlatform.dispose();
  }

  Future<Marker> addMarker(Marker marker) async =>
      _maplibrePlatform.addMarker(marker);

  Future<void> addGeoJson({
    required String id,
    required Map<String, Object?> geoJson,
  }) async {
    await _maplibrePlatform.addGeoJsonSource(id: id, geoJson: geoJson);
    await _maplibrePlatform.addLayer(
      id: '$id-fill',
      type: 'fill',
      source: id,
    );
    await _maplibrePlatform.addLayer(
      id: '$id-line',
      type: 'line',
      source: id,
    );
    await _maplibrePlatform.addLayer(
      id: '$id-symbol',
      type: 'symbol',
      source: id,
    );
  }

  Future<Offset> toScreenLocation(Position lngLat) async {
    // TODO throws an exception "Field '_controller' has not been initialized."
    return _maplibrePlatform.toScreenLocation(lngLat);
  }

  Future<Position> toLngLat(Offset screenLocation) async {
    return _maplibrePlatform.toLngLat(screenLocation);
  }

  Future<void> jumpTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async =>
      _maplibrePlatform.jumpTo(
        center: center,
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      );

  Future<void> flyTo({
    required Position center,
    required double zoom,
    required double bearing,
    required double pitch,
  }) async =>
      _maplibrePlatform.flyTo(
        center: center,
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      );
}
