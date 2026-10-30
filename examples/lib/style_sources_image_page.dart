import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleSourcesImagePage extends StatefulWidget {
  const StyleSourcesImagePage({super.key});

  static const location = '/style-sources/image';

  @override
  State<StyleSourcesImagePage> createState() => _StyleSourcesImagePageState();
}

class _StyleSourcesImagePageState extends State<StyleSourcesImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Source')),
      body: MapLibreMap(
        options: const MapOptions(
          initCamera: InitialCamera.position(
            zoom: 4,
            center: Geographic(lon: -76, lat: 41),
          ),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    // An image that the map loads from a URL.
    await style.sources.add(
      const ImageSource.url(
        id: 'radar',
        url: 'https://maplibre.org/maplibre-gl-js/docs/assets/radar.gif',
        coordinates: LngLatQuad(
          topLeft: Geographic(lon: -80.425, lat: 46.437),
          topRight: Geographic(lon: -71.516, lat: 46.437),
          bottomRight: Geographic(lon: -71.516, lat: 37.936),
          bottomLeft: Geographic(lon: -80.425, lat: 37.936),
        ),
      ),
    );
    await style.layers.add(
      RasterStyleLayer(
        id: 'radar',
        sourceId: 'radar',
        opacity: const .literal(0.8),
      ),
    );

    // An image from a Flutter ImageProvider, here an asset. FileImage,
    // NetworkImage and MemoryImage work the same way, and ImageSource.bytes
    // takes the encoded image directly.
    await style.sources.add(
      const ImageSource.provider(
        id: 'asset',
        image: AssetImage('assets/images/marker.png'),
        coordinates: LngLatQuad(
          topLeft: Geographic(lon: -90, lat: 44),
          topRight: Geographic(lon: -84, lat: 44),
          bottomRight: Geographic(lon: -84, lat: 38),
          bottomLeft: Geographic(lon: -90, lat: 38),
        ),
      ),
    );
    await style.layers.add(RasterStyleLayer(id: 'asset', sourceId: 'asset'));
  }
}
