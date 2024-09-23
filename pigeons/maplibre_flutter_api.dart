part of 'pigeon.dart';

@FlutterApi()
abstract interface class MapLibreFlutterApi {
  /// Get the map options from dart.
  MapOptions getOptions();

  /// Callback for when the style has been loaded.
  void onStyleLoaded();

  /// Callback when the user clicks on the map.
  void onClick(LngLat point);

  /// Callback when the map idles.
  void onIdle();

  /// Callback when the map camera idles.
  void onCameraIdle();

  /// Callback when the user performs a secondary click on the map
  /// (e.g. by default a click with the right mouse button).
  void onSecondaryClick(LngLat point);

  /// Callback when the user performs a double click on the map.
  void onDoubleClick(LngLat point);

  /// Callback when the user performs a long lasting click on the map.
  void onLongClick(LngLat point);

  /// Callback when the map camera changes.
  void onCameraMoved(MapCamera camera);
}
