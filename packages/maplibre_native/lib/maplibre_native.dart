
import 'maplibre_native_platform_interface.dart';

class MaplibreNative {
  Future<String?> getPlatformVersion() {
    return MaplibreNativePlatform.instance.getPlatformVersion();
  }
}
