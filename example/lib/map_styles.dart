abstract class MapStyles {
  static const protomapsLight =
      'https://api.protomaps.com/styles/v2/light.json?key=$_protomapsKey';
  static const protomapsDark =
      'https://api.protomaps.com/styles/v2/dark.json?key=$_protomapsKey';
  static const maptilerStreets =
      'https://api.maptiler.com/maps/streets-v2/style.json?key=$_maptilerKey';
  static const protomapsLightPmTiles = 'assets/styles/protomaps-light.json';
  static const translucentAsset = 'assets/styles/translucent_style.json';
  static const countries = '''
{
  "version": 8,
  "name": "MapLibre",
  "center": [17.65431710431244, 32.954120326746775],
  "zoom": 0.8619833357855968,
  "bearing": 0,
  "pitch": 0,
  "sources": {
    "maplibre": {
      "url": "https://demotiles.maplibre.org/tiles/tiles.json",
      "type": "vector"
    }
  },
  "glyphs": "https://demotiles.maplibre.org/font/{fontstack}/{range}.pbf",
  "layers": [
    {
      "id": "background",
      "type": "background",
      "maxzoom": 24,
      "filter": ["all"],
      "paint": {"background-color": "#D8F2FF"}
    },
    {
      "id": "countries-fill",
      "type": "fill",
      "source": "maplibre",
      "source-layer": "countries",
      "maxzoom": 24,
      "filter": ["all"],
      "paint": {"fill-color": "#FFFFFF"}
    },
    {
      "id": "countries-boundary",
      "type": "line",
      "source": "maplibre",
      "source-layer": "countries",
      "maxzoom": 24,
      "layout": {
        "line-cap": "round",
        "line-join": "round",
        "visibility": "visible"
      },
      "paint": {
        "line-color": "#198EC8",
        "line-width": {"stops": [[1, 1], [6, 2], [14, 6], [22, 12]]},
        "line-opacity": {"stops": [[3, 0.5], [6, 1]]}
      }
    }
  ],
  "id": "43f36e14-e3f5-43c1-84c0-50a9c80dc5c7"
}
  ''';

  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  static const _maptilerKey = 'OPCgnZ51sHETbEQ4wnkd';

  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  static const _protomapsKey = 'a6f9aebb3965458c';
}
