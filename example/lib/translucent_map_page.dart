import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

@immutable
class TranslucentMapPage extends StatefulWidget {
  const TranslucentMapPage({super.key});

  static const location = '/translucent-map';

  @override
  State<TranslucentMapPage> createState() => _TranslucentMapPageState();
}

class _TranslucentMapPageState extends State<TranslucentMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translucent Map')),
      body: Stack(
        children: [
          const ColoredBox(
            color: Colors.white,
            child: Center(
              child: Text(
                'Widget behind the map',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          MapLibreMap(
            options: MapOptions(
              androidMode: AndroidPlatformViewMode.hc,
              androidTranslucentTextureSurface: true,
              androidForegroundLoadColor: Colors.blue,
              initCenter: const Geographic(lon: 9.17, lat: 47.68),
              initStyle: MapStyles.translucent.uri,
              initZoom: 2,
            ),
            children: const [
              MapScalebar(),
              SourceAttribution(),
              MapControlButtons(showTrackLocation: true),
              MapCompass(),
            ],
            onStyleLoaded: (style) {
              style.setProjection(MapProjection.globe);
            },
          ),
        ],
      ),
    );
  }
}
