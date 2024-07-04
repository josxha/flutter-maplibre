import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:maplibre/src/maplibre_platform_interface.dart';

/// An implementation of [MapLibrePlatform] that uses method channels.
class MethodChannelMaplibre extends MapLibrePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('maplibre');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Widget buildWidget() {
    throw UnimplementedError();
  }
}
