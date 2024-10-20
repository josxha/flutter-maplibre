import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/native/widget_state_jni.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [PlatformInterface] that uses method channels.
final class PlatformImpl extends PlatformInterface {
  @override
  // currently only Android is supported
  MapLibreMapState createWidgetState() => MapLibreMapStateJni();
}
