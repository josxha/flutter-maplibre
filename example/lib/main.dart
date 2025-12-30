import 'package:flutter/material.dart';
import 'package:maplibre_example/animation_page.dart';
import 'package:maplibre_example/controller_page.dart';
import 'package:maplibre_example/events_page.dart';
import 'package:maplibre_example/features_query_page.dart';
import 'package:maplibre_example/gestures_page.dart';
import 'package:maplibre_example/kiosk_page.dart';
import 'package:maplibre_example/layers_circle_page.dart';
import 'package:maplibre_example/layers_marker_page.dart';
import 'package:maplibre_example/layers_mixed_page.dart';
import 'package:maplibre_example/layers_polygon_page.dart';
import 'package:maplibre_example/layers_polyline_page.dart';
import 'package:maplibre_example/layers_widget_marker_page.dart';
import 'package:maplibre_example/menu_page.dart';
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
import 'package:maplibre_example/style_layers_vector_page.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:maplibre_example/translucent_map_page.dart';
import 'package:maplibre_example/two_maps_page.dart';
import 'package:maplibre_example/user_location_page.dart';
import 'package:maplibre_example/widget_layer_interactive_page.dart';
import 'package:maplibre_example/widget_layer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapLibre Demo',
      initialRoute: MenuPage.location,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        MenuPage.location: (context) => const MenuPage(),
        TranslucentMapPage.location: (context) => const TranslucentMapPage(),
        PmTilesPage.location: (context) => const PmTilesPage(),
        KioskPage.location: (context) => const KioskPage(),
        AnimationPage.location: (context) => const AnimationPage(),
        GesturesPage.location: (context) => const GesturesPage(),
        EventsPage.location: (context) => const EventsPage(),
        StyledMapPage.location: (context) => const StyledMapPage(),
        UserLocationPage.location: (context) => const UserLocationPage(),
        WidgetLayerPage.location: (context) => const WidgetLayerPage(),
        WidgetLayerInteractivePage.location: (context) =>
            const WidgetLayerInteractivePage(),
        OfflinePage.location: (context) => const OfflinePage(),
        PermissionsPage.location: (context) => const PermissionsPage(),
        StyleLayersSymbolPage.location: (context) =>
            const StyleLayersSymbolPage(),
        StyleLayersCirclePage.location: (context) =>
            const StyleLayersCirclePage(),
        StyleLayersHeatmapPage.location: (context) =>
            const StyleLayersHeatmapPage(),
        StyleLayersHillshadePage.location: (context) =>
            const StyleLayersHillshadePage(),
        StyleLayersFillPage.location: (context) => const StyleLayersFillPage(),
        StyleLayersFillExtrusionPage.location: (context) =>
            const StyleLayersFillExtrusionPage(),
        StyleLayersRasterPage.location: (context) =>
            const StyleLayersRasterPage(),
        StyleLayersVectorPage.location: (context) =>
            const StyleLayersVectorPage(),
        StyleLayersLinePage.location: (context) => const StyleLayersLinePage(),
        LayersMixedPage.location: (context) => const LayersMixedPage(),
        LayersCirclePage.location: (context) => const LayersCirclePage(),
        LayersMarkerPage.location: (context) => const LayersMarkerPage(),
        LayersWidgetMarkerPage.location: (context) =>
            const LayersWidgetMarkerPage(),
        LayersPolylinePage.location: (context) => const LayersPolylinePage(),
        LayersPolygonPage.location: (context) => const LayersPolygonPage(),
        ParametersPage.location: (context) => const ParametersPage(),
        FeaturesQueryPage.location: (context) => const FeaturesQueryPage(),
        ControllerPage.location: (context) => const ControllerPage(),
        TwoMapsPage.location: (context) => const TwoMapsPage(),
      },
    );
  }
}
