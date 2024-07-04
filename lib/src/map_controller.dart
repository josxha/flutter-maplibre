import 'package:flutter/cupertino.dart';
import 'package:maplibre/src/platform_interface.dart';

class MapLibreMapController extends ChangeNotifier {
  MapLibreMapController({
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
}
