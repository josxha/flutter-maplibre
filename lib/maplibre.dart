
import 'package:maplibre/src/maplibre_platform_interface.dart';

export 'src/maplibre_map.dart';

class Maplibre {
  Future<String?> getPlatformVersion() {
    return MapLibrePlatform.instance.getPlatformVersion();
  }
}
