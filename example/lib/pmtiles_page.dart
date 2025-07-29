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
              initCenter: Position(9.17, 47.68),
              initZoom: 2,
              initStyle: snapshot.data!,
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
