import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MaplibreIos {
  @visibleForTesting
  final methodChannel = const MethodChannel('maplibre_ios');

  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
