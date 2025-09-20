abstract class MapStyles {
  static const protomapsLight =
      'https://api.protomaps.com/styles/v2/light.json?key=$_protomapsKey';
  static const protomapsDark =
      'https://api.protomaps.com/styles/v2/dark.json?key=$_protomapsKey';
  static const maptilerStreets =
      'https://api.maptiler.com/maps/streets-v2/style.json?key=$_maptilerKey';
  static const protomapsLightPmTiles = 'assets/styles/protomaps-light.json';
  static const translucentAsset = 'assets/styles/translucent_style.json';
  static const customJsonStyle =
      '''
{
"version": 8,
"name": "Basic",
"metadata": {
  "mapbox:autocomposite": false,
  "mapbox:type": "template",
  "maputnik:renderer": "mbgljs",
  "openmaptiles:version": "3.x",
  "openmaptiles:mapbox:owner": "openmaptiles",
  "openmaptiles:mapbox:source:url": "mapbox://openmaptiles.4qljc88t"
},
"sources": {
  "openmaptiles": {
    "type": "vector",
    "url": "https://api.maptiler.com/tiles/v3-openmaptiles/tiles.json?key=$_maptilerKey",
    "attribution": "Custom JSON"
  }
},
"sprite": "https://openmaptiles.github.io/maptiler-basic-gl-style/sprite",
"glyphs": "https://api.maptiler.com/fonts/{fontstack}/{range}.pbf?key=$_maptilerKey",
"layers": [
  {
    "id": "background",
    "type": "background",
    "paint": {"background-color": "hsl(47, 26%, 88%)"}
  },
  {
    "id": "water_red",
    "type": "fill",
    "source": "openmaptiles",
    "source-layer": "water",
    "filter": [
      "all",
      ["==", "\$type", "Polygon"],
      ["!=", "intermittent", 1],
      ["!=", "brunnel", "tunnel"]
    ],
    "layout": {"visibility": "visible"},
    "paint": {"fill-color": "rgba(215, 14, 17, 1)"}
  },
  {
    "id": "admin_pink",
    "type": "line",
    "source": "openmaptiles",
    "source-layer": "boundary",
    "filter": ["all"],
    "layout": {"visibility": "visible"},
    "paint": {
      "line-color": "rgba(255, 0, 229, 0.5)",
      "line-dasharray": [2, 1]
    }
  }
],
"id": "basic"
}
  ''';

  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  static const _maptilerKey = 'OPCgnZ51sHETbEQ4wnkd';

  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  static const _protomapsKey = 'a6f9aebb3965458c';
}
