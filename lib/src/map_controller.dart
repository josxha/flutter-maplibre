import 'package:flutter/cupertino.dart';
import 'package:geotypes/geotypes.dart';
import 'package:maplibre/src/platform_interface.dart';

class MapController extends ChangeNotifier {
  MapController({
    required MapLibrePlatform maplibrePlatform,
    required this.onStyleLoadedCallback,
  }) : _maplibrePlatform = maplibrePlatform;

  final MapLibrePlatform _maplibrePlatform;
  final void Function()? onStyleLoadedCallback;

  @override
  void dispose() {
    super.dispose();
    _maplibrePlatform.dispose();
  }

  Future<void> addMarker({
    required Position point,
    Color? color,
    bool draggable = false,
  }) async => _maplibrePlatform.addMarker(
    point: point,
    color: color,
    draggable: draggable,
  );
}
