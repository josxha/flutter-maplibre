abstract class MapStyles {
  static const protomapsLight =
      'https://api.protomaps.com/styles/v2/light.json?key=$_protomapsKey';
  static const protomapsDark =
      'https://api.protomaps.com/styles/v2/dark.json?key=$_protomapsKey';
  static const maptilerStreets =
      'https://api.maptiler.com/maps/streets-v2/style.json?key=$_maptilerKey';
  static const protomapsLightPmTiles = 'assets/styles/protomaps-light.json';
  static const translucentAsset = 'assets/styles/translucent_style.json';

  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  static const _maptilerKey = 'OPCgnZ51sHETbEQ4wnkd';

  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  static const _protomapsKey = 'a6f9aebb3965458c';
}
