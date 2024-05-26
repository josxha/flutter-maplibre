import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'maplibre_method_channel.dart';

abstract class MaplibrePlatform extends PlatformInterface {
  /// Constructs a MaplibrePlatform.
  MaplibrePlatform() : super(token: _token);

  static final Object _token = Object();

  static MaplibrePlatform _instance = MethodChannelMaplibre();

  /// The default instance of [MaplibrePlatform] to use.
  ///
  /// Defaults to [MethodChannelMaplibre].
  static MaplibrePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MaplibrePlatform] when
  /// they register themselves.
  static set instance(MaplibrePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
