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

  Future<Future<Marker>> addMarker(Marker marker) async =>
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
    return _maplibrePlatform.toScreenLocation(lngLat);
  }

  Future<Position> toLngLat(Offset screenLocation) async {
    return _maplibrePlatform.toLngLat(screenLocation);
  }
}
