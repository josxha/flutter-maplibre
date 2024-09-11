import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/native/pigeon.g.dart',
    dartOptions: DartOptions(),
    dartPackageName: 'maplibre',
    // linux
    gobjectHeaderOut: 'linux/pigeon.g.h',
    gobjectSourceOut: 'linux/pigeon.g.cc',
    gobjectOptions: GObjectOptions(),
    // windows
    cppOptions: CppOptions(namespace: 'pigeon_maplibre'),
    cppHeaderOut: 'windows/runner/pigeon.g.h',
    cppSourceOut: 'windows/runner/pigeon.g.cpp',
    // android
    kotlinOut: 'android/src/main/kotlin/com/github/josxha/maplibre/Pigeon.g.kt',
    kotlinOptions: KotlinOptions(),
    // ios
    swiftOut: 'ios/Classes/Pigeon.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract interface class MapLibreHostApi {
  @async
  void jumpTo({
    required LngLat center,
    double? zoom,
    double? bearing,
    double? pitch,
  });

  @async
  void flyTo({
    required LngLat center,
    double? zoom,
    double? bearing,
    double? pitch,
  });

  @async
  ScreenLocation toScreenLocation(double lng, double lat);

  @async
  LngLat toLngLat(double x, double y);

  @async
  void addFillLayer({required String id, required String sourceId});

  @async
  void addCircleLayer({required String id, required String sourceId});

  @async
  void addGeoJsonSource({
    required String id,
    required String data,
  });
}

@FlutterApi()
abstract interface class MapLibreFlutterApi {
  MapOptions getOptions();

  void onStyleLoaded();

  void onClick(LngLat point);

  void onSecondaryClick(LngLat point);

  void onDoubleClick(LngLat point);

  void onLongClick(LngLat point);
}

class MapOptions {
  const MapOptions({
    required this.style,
    required this.zoom,
    required this.center,
    required this.tilt,
    required this.bearing,
    required this.listensOnClick,
    required this.listensOnLongClick,
  });

  final String style;
  final double zoom;
  final double tilt;
  final double bearing;
  final LngLat? center;
  final bool listensOnClick;
  final bool listensOnLongClick;
}

class LngLat {
  const LngLat({required this.lng, required this.lat});

  final double lng;
  final double lat;
}

class ScreenLocation {
  const ScreenLocation({required this.x, required this.y});

  final double x;
  final double y;
}
