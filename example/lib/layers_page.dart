// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersPage extends StatefulWidget {
  const LayersPage({super.key});

  static const location = '/layers';

  @override
  State<LayersPage> createState() => _LayersPageState();
}

const _layerId = 'showcaseLayer';
const _sourceEarthquakesId = 'earthquakes';
const _sourceOpenStreetMapId = 'openStreetMap';
const _sourceHillshadeId = 'hillshade';

class _LayersPageState extends State<LayersPage> {
  bool _someLayerActive = false;
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Layers')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    if (_someLayerActive) {
                      await _controller.removeLayer(_layerId);
                    }
                    _someLayerActive = true;
                    await _controller.addLayer(_heatmapLayer);
                    await _controller.flyTo(
                      center: Position(-120, 50),
                      zoom: 2,
                    );
                  },
                  child: const Text('Heatmap'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    if (_someLayerActive) {
                      await _controller.removeLayer(_layerId);
                    }
                    _someLayerActive = true;
                    await _controller.addLayer(_circleLayer);
                    await _controller.flyTo(
                      center: Position(-152.9959, 59.8150),
                      zoom: 9,
                    );
                  },
                  child: const Text('Circle'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    if (_someLayerActive) {
                      await _controller.removeLayer(_layerId);
                    }
                    _someLayerActive = true;
                    await _controller.addLayer(_rasterLayer);
                    await _controller.flyTo(
                      center: Position(-102, 39),
                      zoom: 4,
                    );
                  },
                  child: const Text('Raster'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    if (_someLayerActive) {
                      await _controller.removeLayer(_layerId);
                    }
                    _someLayerActive = true;
                    await _controller.addLayer(_hillshadeLayer);
                    await _controller.jumpTo(
                      center: Position(11.39085, 47.27574),
                      zoom: 10,
                    );
                  },
                  child: const Text('Hillshade'),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                center: Position(-120, 50),
                onClick: (point) => debugPrint('${point.lng}, ${point.lat}'),
              ),
              onMapCreated: (controller) => _controller = controller,
              onStyleLoaded: _onStyleLoaded,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    const earthquakes = GeoJsonSource(
      id: _sourceEarthquakesId,
      data:
          'https://maplibre.org/maplibre-gl-js/docs/assets/earthquakes.geojson',
    );
    await _controller.addSource(earthquakes);
    const openStreetMap = RasterSource(
      id: _sourceOpenStreetMapId,
      tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
      maxZoom: 20,
      tileSize: 256,
      attribution:
          '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    );
    await _controller.addSource(openStreetMap);
    const hillshade = RasterDemSource(
      id: _sourceHillshadeId,
      url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
      tileSize: 256,
    );
    await _controller.addSource(hillshade);
  }
}

// TODO fill layer
// TODO fill extrusion layer
// TODO line layer
// TODO hillshade layer

const _heatmapLayer = HeatmapLayer(
  id: _layerId,
  sourceId: _sourceEarthquakesId,
  paint: {
    // Increase the heatmap weight based on frequency and property magnitude
    'heatmap-weight': [
      'interpolate',
      ['linear'],
      ['get', 'mag'],
      0,
      0,
      6,
      1
    ],
    // Increase the heatmap color weight weight by zoom level
    // heatmap-intensity is a multiplier on top of heatmap-weight
    'heatmap-intensity': [
      'interpolate',
      ['linear'],
      ['zoom'],
      0,
      1,
      9,
      3
    ],
    // Color ramp for heatmap.  Domain is 0 (low) to 1 (high).
    // Begin color ramp at 0-stop with a 0-transparency color
    // to create a blur-like effect.
    'heatmap-color': [
      'interpolate',
      ['linear'],
      ['heatmap-density'],
      0,
      'rgba(33,102,172,0)',
      0.2,
      'rgb(103,169,207)',
      0.4,
      'rgb(209,229,240)',
      0.6,
      'rgb(253,219,199)',
      0.8,
      'rgb(239,138,98)',
      1,
      'rgb(178,24,43)'
    ],
    // Adjust the heatmap radius by zoom level
    'heatmap-radius': [
      'interpolate',
      ['linear'],
      ['zoom'],
      0,
      2,
      9,
      20
    ],
    // Transition from heatmap to circle layer by zoom level
    'heatmap-opacity': [
      'interpolate',
      ['linear'],
      ['zoom'],
      7,
      1,
      9,
      0
    ]
  },
);

const _circleLayer = CircleLayer(
  id: _layerId,
  sourceId: _sourceEarthquakesId,
  paint: {
    // Size circle radius by earthquake magnitude and zoom level
    'circle-radius': [
      'interpolate',
      ['linear'],
      ['zoom'],
      7,
      [
        'interpolate',
        ['linear'],
        ['get', 'mag'],
        1,
        1,
        6,
        4
      ],
      16,
      [
        'interpolate',
        ['linear'],
        ['get', 'mag'],
        1,
        5,
        6,
        50
      ]
    ],
    // Color circle by earthquake magnitude
    'circle-color': [
      'interpolate',
      ['linear'],
      ['get', 'mag'],
      1,
      'rgba(33,102,172,0)',
      2,
      'rgb(103,169,207)',
      3,
      'rgb(209,229,240)',
      4,
      'rgb(253,219,199)',
      5,
      'rgb(239,138,98)',
      6,
      'rgb(178,24,43)'
    ],
    'circle-stroke-color': 'white',
    'circle-stroke-width': 1,
    // Transition from heatmap to circle layer by zoom level
    'circle-opacity': [
      'interpolate',
      ['linear'],
      ['zoom'],
      7,
      0,
      8,
      1
    ]
  },
);

const _rasterLayer = RasterLayer(
  id: _layerId,
  sourceId: _sourceOpenStreetMapId,
);

const _hillshadeLayer = HillshadeLayer(
  id: _layerId,
  sourceId: _sourceHillshadeId,
  paint: {'hillshade-shadow-color': '#473B24'},
);
