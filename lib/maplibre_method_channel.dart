import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'maplibre_platform_interface.dart';

/// An implementation of [MaplibrePlatform] that uses method channels.
class MethodChannelMaplibre extends MaplibrePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('maplibre');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
