import 'package:flutter/foundation.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/offline/offline_manager.dart';
import 'package:maplibre/src/permission_manager.dart';
import 'package:maplibre/src/platform/android/map_state.dart';
import 'package:maplibre/src/platform/android/offline_manager.dart';
import 'package:maplibre/src/platform/android/permission_manager.dart';
import 'package:maplibre/src/platform/ios/map_state.dart';
import 'package:maplibre/src/platform/ios/offline_manager.dart';
import 'package:maplibre/src/platform/ios/permission_manager.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [PlatformInterface] that uses method channels and ffi.
final class PlatformImpl extends PlatformInterface {
  @override
  MapLibreMapState createWidgetState() => switch (defaultTargetPlatform) {
    TargetPlatform.android => MapLibreMapStateAndroid(),
    TargetPlatform.iOS => MapLibreMapStateIos(),
    _ => throw UnimplementedError('Unsupported platform'),
  };

  @override
  Future<OfflineManager> createOfflineManager() async =>
      switch (defaultTargetPlatform) {
        TargetPlatform.android => OfflineManagerAndroid.createInstance(),
        TargetPlatform.iOS => OfflineManagerIos.createInstance(),
        _ => throw UnimplementedError('Unsupported platform'),
      };

  @override
  PermissionManager createPermissionManager() =>
      switch (defaultTargetPlatform) {
        TargetPlatform.android => PermissionManagerAndroid(),
        TargetPlatform.iOS => const PermissionManagerIos(),
        _ => throw UnimplementedError('Unsupported platform'),
      };
}
