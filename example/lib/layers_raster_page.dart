import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersRasterPage extends StatefulWidget {
  const LayersRasterPage({super.key});

  static const location = '/layers/raster';

  @override
  State<LayersRasterPage> createState() => _LayersRasterPageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'openStreetMap';

class _LayersRasterPageState extends State<LayersRasterPage> {
  late final MapController _controller;

  // If you are looking for just a way how to display OpenStreetMap on the
  // map then this is NOT the right approach. You can create a Style JSON that
  // contains only a raster source for the OpenStreetMap tile server and one
  // raster layer to display the raster source on the map.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raster Layer')),
      body: MapLibreMap(
        options: MapOptions(center: Position(9, 48), zoom: 7),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    const openStreetMap = RasterSource(
      id: _sourceId,
      tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
      maxZoom: 20,
      tileSize: 256,
      attribution:
          '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    );
    await _controller.addSource(openStreetMap);
    await _controller.addLayer(_rasterLayer);
  }
}

const _rasterLayer = RasterLayer(
  id: _layerId,
  sourceId: _sourceId,
);
