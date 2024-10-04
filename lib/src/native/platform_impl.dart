import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/widget_state_jni.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [PlatformInterface] that uses method channels.
final class PlatformImpl extends PlatformInterface {
  @override
  // currently only Android is supported
  State<MapLibreMap> createWidgetState() => MapLibreMapStateJni();
}
