import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/widget_state_jni.dart';
import 'package:maplibre/src/native/widget_state_pigeon.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [PlatformInterface] that uses method channels.
final class PlatformNative extends PlatformInterface {
  @override
  State<MapLibreMap> createWidgetState() =>
      Platform.isAndroid ? MapLibreMapStateJni() : MapLibreMapStatePigeon();
}
