import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

@immutable
class StyledMapPage extends StatefulWidget {
  const StyledMapPage({super.key});

  static const location = '/styled-map';

  @override
  State<StyledMapPage> createState() => _StyledMapPageState();
}

class _StyledMapPageState extends State<StyledMapPage> {
  static const Map<String, String> _styles = {
    'MapTiler Streets': MapStyles.maptilerStreets,
    'Protomaps Light': MapStyles.protomapsLight,
    'Protomaps Dark': MapStyles.protomapsDark,
    'Countries': MapStyles.countries,
  };
  String _styleUrl = _styles.values.first;
  late MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Styled Map'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
            child: SizedBox(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: _styles.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ChoiceChip(
                          label: Text(e.key),
                          selected: _styleUrl == e.value,
                          onSelected: (value) {
                            // update the segmented button
                            setState(() => _styleUrl = e.value);
                            // apply the new style on the map
                            _controller.setStyle(_styleUrl);
                          },
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
        ),
      ),
      body: MapLibreMap(
        options: MapOptions(
          initCenter: const Geographic(lon: 9.17, lat: 47.68),
          initZoom: 2,
          initStyle: _styleUrl,
        ),
        children: const [
          MapScalebar(),
          SourceAttribution(),
          MapControlButtons(showTrackLocation: true),
          MapCompass(),
        ],
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: (style) {
          style.setProjection(MapProjection.globe);
        },
      ),
    );
  }
}
