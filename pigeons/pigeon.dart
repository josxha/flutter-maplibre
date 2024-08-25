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
abstract interface class MapLibrePigeon {
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
