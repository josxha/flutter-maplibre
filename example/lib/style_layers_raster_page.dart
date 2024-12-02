import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersRasterPage extends StatefulWidget {
  const StyleLayersRasterPage({super.key});

  static const location = '/style-layers/raster';

  @override
  State<StyleLayersRasterPage> createState() => _StyleLayersRasterPageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'openStreetMap';

class _StyleLayersRasterPageState extends State<StyleLayersRasterPage> {

  // If you are looking for just a way how to display OpenStreetMap on the
  // map then this is NOT the right approach. You can create a Style JSON that
  // contains only a raster source for the OpenStreetMap tile server and one
  // raster layer to display the raster source on the map.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raster Style Layer')),
      body: MapLibreMap(
        options: MapOptions(initCenter: Position(9, 48), initZoom: 7),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    const openStreetMap = RasterSource(
      id: _sourceId,
      tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
      maxZoom: 20,
      tileSize: 256,
      attribution:
          '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    );
    await style.addSource(openStreetMap);
    await style.addLayer(_rasterStyleLayer);
  }
}

const _rasterStyleLayer = RasterStyleLayer(
  id: _layerId,
  sourceId: _sourceId,
);
