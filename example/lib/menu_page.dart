import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_example/animation_page.dart';
import 'package:maplibre_example/controller_page.dart';
import 'package:maplibre_example/events_page.dart';
import 'package:maplibre_example/features_query_page.dart';
import 'package:maplibre_example/gestures_page.dart';
import 'package:maplibre_example/layers_circle_page.dart';
import 'package:maplibre_example/layers_marker_page.dart';
import 'package:maplibre_example/layers_mixed_page.dart';
import 'package:maplibre_example/layers_polygon_page.dart';
import 'package:maplibre_example/layers_polyline_page.dart';
import 'package:maplibre_example/layers_widget_marker_page.dart';
import 'package:maplibre_example/offline_page.dart';
import 'package:maplibre_example/parameters_page.dart';
import 'package:maplibre_example/permissions_page.dart';
import 'package:maplibre_example/pmtiles_page.dart';
import 'package:maplibre_example/style_layers_circle_page.dart';
import 'package:maplibre_example/style_layers_fill_extrusion_page.dart';
import 'package:maplibre_example/style_layers_fill_page.dart';
import 'package:maplibre_example/style_layers_heatmap_page.dart';
import 'package:maplibre_example/style_layers_hillshade_page.dart';
import 'package:maplibre_example/style_layers_line_page.dart';
import 'package:maplibre_example/style_layers_raster_page.dart';
import 'package:maplibre_example/style_layers_symbol_page.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:maplibre_example/translucent_map_page.dart';
import 'package:maplibre_example/two_maps_page.dart';
import 'package:maplibre_example/user_location_page.dart';
import 'package:maplibre_example/widget_layer_interactive_page.dart';
import 'package:maplibre_example/widget_layer_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const location = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapLibre Demo')),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SectionTitle('General')),
            SliverGrid.extent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 1.5,
              children: [
                const ItemCard(
                  label: 'Map Styles',
                  iconData: Icons.color_lens,
                  location: StyledMapPage.location,
                ),
                const ItemCard(
                  label: 'Translucent Map',
                  iconData: Icons.map_outlined,
                  location: TranslucentMapPage.location,
                ),
                const ItemCard(
                  label: 'PMTiles Source',
                  iconData: Icons.file_open,
                  location: PmTilesPage.location,
                ),
                const ItemCard(
                  label: 'Parameters',
                  iconData: Icons.build,
                  location: ParametersPage.location,
                ),
                const ItemCard(
                  label: 'Gestures',
                  iconData: Icons.back_hand,
                  location: GesturesPage.location,
                ),
                const ItemCard(
                  label: 'Events',
                  iconData: Icons.notifications,
                  location: EventsPage.location,
                ),
                const ItemCard(
                  label: 'Controller',
                  iconData: Icons.api,
                  location: ControllerPage.location,
                ),
                const ItemCard(
                  label: 'Query Features',
                  iconData: Icons.question_answer,
                  location: FeaturesQueryPage.location,
                ),
                const ItemCard(
                  label: 'Two Maps',
                  iconData: Icons.looks_two,
                  location: TwoMapsPage.location,
                ),
                const ItemCard(
                  label: 'Animation',
                  iconData: Icons.animation,
                  location: AnimationPage.location,
                ),
                if (!kIsWeb)
                  const ItemCard(
                    label: 'User Location',
                    iconData: Icons.gps_fixed,
                    location: UserLocationPage.location,
                  ),
                if (!kIsWeb)
                  const ItemCard(
                    label: 'Offline',
                    iconData: Icons.wifi_off,
                    location: OfflinePage.location,
                  ),
                if (!kIsWeb && !Platform.isIOS)
                  const ItemCard(
                    label: 'Permissions',
                    iconData: Icons.key,
                    location: PermissionsPage.location,
                  ),
              ],
            ),
            const SliverToBoxAdapter(child: SectionTitle('Layers')),
            SliverGrid.extent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 1.5,
              children: const [
                ItemCard(
                  label: 'Mixed Layers',
                  iconData: Icons.control_point_duplicate_outlined,
                  location: LayersMixedPage.location,
                ),
                ItemCard(
                  label: 'Widgets',
                  iconData: Icons.location_on,
                  location: WidgetLayerPage.location,
                ),
                ItemCard(
                  label: 'Interactive Widgets',
                  iconData: Icons.location_on,
                  location: WidgetLayerInteractivePage.location,
                ),
                ItemCard(
                  label: 'Circles',
                  iconData: Icons.circle,
                  location: LayersCirclePage.location,
                ),
                ItemCard(
                  label: 'Markers',
                  iconData: Icons.location_on,
                  location: LayersMarkerPage.location,
                ),
                ItemCard(
                  label: 'Widget Markers',
                  iconData: Icons.widgets,
                  location: LayersWidgetMarkerPage.location,
                ),
                ItemCard(
                  label: 'Polygons',
                  iconData: Icons.format_shapes,
                  location: LayersPolygonPage.location,
                ),
                ItemCard(
                  label: 'Polylines',
                  iconData: Icons.polyline,
                  location: LayersPolylinePage.location,
                ),
              ],
            ),
            const SliverToBoxAdapter(child: SectionTitle('Style Layers')),
            SliverGrid.extent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 1.5,
              children: const [
                ItemCard(
                  label: 'Circle',
                  iconData: Icons.circle,
                  location: StyleLayersCirclePage.location,
                ),
                ItemCard(
                  label: 'Fill',
                  iconData: Icons.format_shapes,
                  location: StyleLayersFillPage.location,
                ),
                ItemCard(
                  label: 'Fill Extrusion',
                  iconData: Icons.house,
                  location: StyleLayersFillExtrusionPage.location,
                ),
                ItemCard(
                  label: 'Heatmap',
                  iconData: Icons.thermostat,
                  location: StyleLayersHeatmapPage.location,
                ),
                ItemCard(
                  label: 'Hillshade',
                  iconData: Icons.landscape,
                  location: StyleLayersHillshadePage.location,
                ),
                ItemCard(
                  label: 'Line',
                  iconData: Icons.polyline,
                  location: StyleLayersLinePage.location,
                ),
                ItemCard(
                  label: 'Raster',
                  iconData: Icons.grid_on,
                  location: StyleLayersRasterPage.location,
                ),
                ItemCard(
                  label: 'Symbol',
                  iconData: Icons.emoji_emotions,
                  location: StyleLayersSymbolPage.location,
                ),
              ],
            ),
          ],
        ),
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
          children: [
            Icon(iconData),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(label, style: const TextStyle(fontSize: 18)));
  }
}
