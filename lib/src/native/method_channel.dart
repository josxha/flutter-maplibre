import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [MapLibrePlatform] that uses method channels.
class MethodChannelMaplibre extends MapLibrePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('maplibre');

  @override
  Widget buildWidget({
    required Map<String, dynamic> creationParams,
    required PlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'maplibre',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'maplibre',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
      );
    }
    throw UnsupportedError('Unsupported Platform');
  }

  @override
  Future<void> initPlatform(int id) async {
    // TODO implement initPlatform
  }
}
