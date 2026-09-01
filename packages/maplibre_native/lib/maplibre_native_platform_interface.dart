import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'maplibre_native_method_channel.dart';

abstract class MaplibreNativePlatform extends PlatformInterface {
  /// Constructs a MaplibreNativePlatform.
  MaplibreNativePlatform() : super(token: _token);

  static final Object _token = Object();

  static MaplibreNativePlatform _instance = MethodChannelMaplibreNative();

  /// The default instance of [MaplibreNativePlatform] to use.
  ///
  /// Defaults to [MethodChannelMaplibreNative].
  static MaplibreNativePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MaplibreNativePlatform] when
  /// they register themselves.
  static set instance(MaplibreNativePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
