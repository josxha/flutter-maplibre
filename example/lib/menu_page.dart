import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_example/callbacks_page.dart';
import 'package:maplibre_example/controller_page.dart';
import 'package:maplibre_example/geojson_page.dart';
import 'package:maplibre_example/layers_page.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:maplibre_example/two_maps_page.dart';
import 'package:maplibre_example/web_controls_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const location = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapLibre Demo')),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5,
        children: const [
          ItemCard(
            label: 'Styled Map',
            iconData: Icons.map,
            location: StyledMapPage.location,
          ),
          ItemCard(
            label: 'GeoJSON',
            iconData: Icons.location_on,
            location: GeoJsonPage.location,
          ),
          ItemCard(
            label: 'Layers',
            iconData: Icons.layers,
            location: LayersPage.location,
          ),
          ItemCard(
            label: 'Callbacks',
            iconData: Icons.back_hand,
            location: CallbacksPage.location,
          ),
          if (kIsWeb)
            ItemCard(
              label: 'Web Controls',
              iconData: Icons.toggle_off,
              location: WebControlsPage.location,
            ),
          ItemCard(
            label: 'Controller',
            iconData: Icons.api,
            location: ControllerPage.location,
          ),
          ItemCard(
            label: 'Two Maps',
            iconData: Icons.looks_two,
            location: TwoMapsPage.location,
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.label,
    required this.iconData,
    required this.location,
    super.key,
  });

  final String label;
  final IconData iconData;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Navigator.of(context).pushNamed(location),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(iconData), Text(label)],
        ),
      ),
    );
  }
}
