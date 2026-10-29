import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

@immutable
class PmTilesPage extends StatefulWidget {
  const PmTilesPage({super.key});

  static const location = '/pmtiles';

  @override
  State<PmTilesPage> createState() => _PmTilesPageState();
}

class _PmTilesPageState extends State<PmTilesPage> {
  final Future<String> _futureStyle = rootBundle.loadString(
    MapStyles.protomapsLightPmTiles.uri,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _futureStyle,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('PMTiles')),
          body: MapLibreMap(
            options: MapOptions(
              maxBounds: const GeoBox(
                west: 11.221144,
                east: 11.287543,
                south: 43.745121,
                north: 43.789306,
              ),
              style: MapStyles.protomapsLightPmTiles.style,
              initCamera: const InitialCamera.position(
                center: Geographic(lon: 11.254343, lat: 43.767213),
                zoom: 10,
              ),
            ),
            children: const [MapScalebar(), SourceAttribution(), MapCompass()],
            onStyleLoaded: (style) {
              style.setProjection(MapProjection.globe);
            },
          ),
        );
      },
    );
  }
}
