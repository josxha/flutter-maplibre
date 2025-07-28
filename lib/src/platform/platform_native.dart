import 'package:flutter/foundation.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/offline/offline_manager.dart';
import 'package:maplibre/src/permission_manager.dart';
import 'package:maplibre/src/platform/android/map_state.dart';
import 'package:maplibre/src/platform/android/offline_manager.dart';
import 'package:maplibre/src/platform/android/permission_manager.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [PlatformInterface] that uses method channels and ffi.
final class PlatformImpl extends PlatformInterface {
  @override
  MapLibreMapState createWidgetState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return MapLibreMapStateAndroid();
    }
    throw UnimplementedError('Unsupported platform');
  }

  @override
  Future<OfflineManager> createOfflineManager() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return OfflineManagerAndroid.createInstance();
    }
    throw UnimplementedError('Unsupported platform');
  }

  @override
  PermissionManager createPermissionManager() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return PermissionManagerAndroid();
    }
    throw UnimplementedError('Unsupported platform');
  }
}
