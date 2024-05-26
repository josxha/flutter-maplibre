
import 'maplibre_platform_interface.dart';

class Maplibre {
  Future<String?> getPlatformVersion() {
    return MaplibrePlatform.instance.getPlatformVersion();
  }
}
