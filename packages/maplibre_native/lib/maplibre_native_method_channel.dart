import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'maplibre_native_platform_interface.dart';

/// An implementation of [MaplibreNativePlatform] that uses method channels.
class MethodChannelMaplibreNative extends MaplibreNativePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('maplibre_native');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
