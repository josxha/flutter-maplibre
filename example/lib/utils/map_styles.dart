enum MapStyles {
  openMapTilesLiberty(
    name: 'OpenMapTiles Liberty',
    uri: 'https://tiles.openfreemap.org/styles/liberty',
  ),
  openMapTilesBright(
    name: 'OpenMapTiles Bright',
    uri: 'https://tiles.openfreemap.org/styles/bright',
  ),
  openMapTilesPositron(
    name: 'OpenMapTiles Positron',
    uri: 'https://tiles.openfreemap.org/styles/positron',
  ),
  openMapTilesStreets(
    name: 'OpenMapTiles Streets',
    uri:
        'https://api.maptiler.com/maps/streets-v2/style.json?key=$_maptilerKey',
  ),
  stadiaMapsAlidadeSmooth(
    name: 'Alidade Smooth',
    uri:
        'https://tiles.stadiamaps.com/styles/alidade_smooth.json?api_key=$_stadiamapsKey',
  ),
  stadiaMapsAlidadeSmoothDark(
    name: 'Alidade Smooth Dark',
    uri:
        'https://tiles.stadiamaps.com/styles/alidade_smooth_dark.json?api_key=$_stadiamapsKey',
  ),
  versaTilesColorful(
    name: 'VersaTiles Colorful',
    uri: 'https://tiles.versatiles.org/assets/styles/colorful/style.json',
  ),
  versaTilesGraybeard(
    name: 'VersaTiles Graybeard',
    uri: 'https://tiles.versatiles.org/assets/styles/graybeard/style.json',
  ),
  versaTilesEclipse(
    name: 'VersaTiles Eclipse',
    uri: 'https://tiles.versatiles.org/assets/styles/eclipse/style.json',
  ),
  versaTilesNeutrino(
    name: 'VersaTiles Neutrino',
    uri: 'https://tiles.versatiles.org/assets/styles/neutrino/style.json',
  ),
  protomapsLight(
    name: 'Protomaps Light',
    uri: 'https://api.protomaps.com/styles/v2/light.json?key=$_protomapsKey',
  ),
  protomapsLightPmTiles(
    name: 'Protomaps Light (PMTiles)',
    uri: 'assets/styles/protomaps-light.json',
  ),
  protomapsDark(
    name: 'Protomaps Dark',
    uri: 'https://api.protomaps.com/styles/v2/dark.json?key=$_protomapsKey',
  ),
  protomapsWhite(
    name: 'Protomaps White',
    uri: 'https://api.protomaps.com/styles/v2/white.json?key=$_protomapsKey',
  ),
  // mapboxStreets(
  //   name: 'Mapbox Streets (legacy)',
  //   uri: 'mapbox://styles/mapbox/streets-v12?access_token=$_mapboxKey',
  // ),
  // mapboxOutdoor(
  //   name: 'Mapbox Outdoors (legacy)',
  //   uri: 'mapbox://styles/mapbox/outdoors-v12?access_token=$_mapboxKey',
  // ),
  // mapboxLight(
  //   name: 'Mapbox Light (legacy)',
  //   uri: 'mapbox://styles/mapbox/light-v11?access_token=$_mapboxKey',
  // ),
  // mapboxDark(
  //   name: 'Mapbox Dark (legacy)',
  //   uri: 'mapbox://styles/mapbox/dark-v11?access_token=$_mapboxKey',
  // ),
  // mapboxSatellite(
  //   name: 'Mapbox Satellite (legacy)',
  //   uri: 'mapbox://styles/mapbox/satellite-v9?access_token=$_mapboxKey',
  // ),
  // mapboxSatelliteStreets(
  //   name: 'Mapbox Satellite Streets (legacy)',
  //   uri:
  //       'mapbox://styles/mapbox/satellite-streets-v12?access_token=$_mapboxKey',
  // ),
  maplibreWorld(
    name: 'MapLibre World',
    uri: 'https://demotiles.maplibre.org/style.json',
  ),
  maplibreDebug(
    name: 'MapLibre Debug',
    uri: 'https://demotiles.maplibre.org/debug-tiles/style.json',
  ),
  translucent(name: 'Translucent', uri: 'assets/styles/translucent_style.json'),
  countries(
    name: 'Countries',
    uri: '''
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
  ''',
  );

  const MapStyles({required this.name, required this.uri});

  final String name;
  final String uri;
}

/// **Use your own key for your project!**
/// This key will be rotated occasionally.
///
/// https://cloud.maptiler.com/account/keys/
const _maptilerKey = 'OPCgnZ51sHETbEQ4wnkd';

/// **Use your own key for your project!**
/// This key will be rotated occasionally.
///
/// https://protomaps.com/account
const _protomapsKey = 'a6f9aebb3965458c';

/// **Use your own key for your project!**
/// This key will be rotated occasionally.
///
/// https://client.stadiamaps.com/dashboard
const _stadiamapsKey = '0d5e614b-aaf7-4bfd-9bf3-1f7c3062248e';
