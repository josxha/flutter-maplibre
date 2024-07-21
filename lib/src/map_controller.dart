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
}
