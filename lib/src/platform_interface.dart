import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MapLibrePlatform extends PlatformInterface {
  /// Constructs a MapLibrePlatform.
  MapLibrePlatform() : super(token: _token);

  static final Object _token = Object();

  static MapLibrePlatform _instance = MapLibreNative();

  /// The default instance of [MapLibrePlatform] to use.
  ///
  /// Defaults to [MapLibreNative].
  static MapLibrePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapLibrePlatform] when
  /// they register themselves.
  static set instance(MapLibrePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Widget buildWidget({
    required MapOptions options,
    required PlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  });

  Future<void> initPlatform(int id);

  @mustCallSuper
  void dispose() {
    // TODO clear all callbacks to avoid cyclic refs
  }
}
