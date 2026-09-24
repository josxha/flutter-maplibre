import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersLinePage extends StatefulWidget {
  const StyleLayersLinePage({super.key});

  static const location = '/style-layers/line';

  @override
  State<StyleLayersLinePage> createState() => _StyleLayersLinePageState();
}

class _StyleLayersLinePageState extends State<StyleLayersLinePage> {
  MapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line Style Layer')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 2,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    _controller?.moveCamera(
                      center: const Geographic(lon: 9.17, lat: 47.68),
                      zoom: 7,
                    );
                  },
                  child: const Text('Line'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _controller?.moveCamera(
                      center: const Geographic(lon: 19.6, lat: 49.5),
                      zoom: 7,
                    );
                  },
                  child: const Text('MultiLine'),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: const MapOptions(
                initZoom: 7,
                initCenter: Geographic(lon: 9.17, lat: 47.68),
              ),
              onStyleLoaded: _onStyleLoaded,
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    final geojsonLine1 = await rootBundle.loadString(
      'assets/geojson/path.json',
    );
    final geojsonLine2 = await rootBundle.loadString(
      'assets/geojson/multiline-path.json',
    );
    await style.addSource(GeoJsonSource(id: 'Path1', data: geojsonLine1));
    await style.addSource(
      GeoJsonSource(id: 'Path2', data: geojsonLine2, tolerance: 0),
    );

    await style.addLayer(
      LineStyleLayer(
        id: 'geojson-line',
        sourceId: 'Path',
        color: const PropertyValue.value(Colors.red),
        width: const PropertyValue.value(3),
      ),
    );
    await style.addLayer(
      LineStyleLayer(
        id: 'geojson-line-2',
        sourceId: 'Path2',
        color: const PropertyValue.value(Colors.red),
        width: const PropertyValue.value(3),
      ),
    );
  }
}
