import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

abstract interface class MapController {
  Future<Marker> addMarker(Marker marker);

  Future<void> addGeoJson({
    required String id,
    required Map<String, Object?> geoJson,
  });

  Future<Offset> toScreenLocation(Position lngLat);

  Future<Position> toLngLat(Offset screenLocation);

  Future<void> jumpTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  });

  Future<void> flyTo({
    required Position center,
    required double zoom,
    required double bearing,
    required double pitch,
  });
}

abstract class MapControllerInternal implements MapController {
  const MapControllerInternal(this.mapWidget);

  final MapLibreMap mapWidget;

  MapOptions get options => mapWidget.options;

  Widget buildWidget();

  void dispose();
}
