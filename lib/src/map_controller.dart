import 'package:flutter/cupertino.dart';
import 'package:maplibre/src/platform_interface.dart';

@immutable
class MapLibreMapController {
  const MapLibreMapController({required this.maplibrePlatform, required this.onStyleLoadedCallback});

  final MapLibrePlatform maplibrePlatform;
  final void Function()? onStyleLoadedCallback;
}
