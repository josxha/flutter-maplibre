import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

@immutable
class PmTilesPage extends StatefulWidget {
  const PmTilesPage({super.key});

  static const location = '/pmtiles';

  @override
  State<PmTilesPage> createState() => _PmTilesPageState();
}

class _PmTilesPageState extends State<PmTilesPage> {
  final Future<String> _futureStyle = rootBundle.loadString(
    MapStyles.protomapsLightPmTiles,
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
              initCenter: Position(11.254343, 43.767213),
              maxBounds: const LngLatBounds(
                longitudeWest: 11.221144,
                longitudeEast: 11.287543,
                latitudeSouth: 43.745121,
                latitudeNorth: 43.789306,
              ),
              initZoom: 10,
              initStyle: MapStyles.protomapsLightPmTiles,
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
        );
      },
    );
  }
}
