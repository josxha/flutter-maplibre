import 'package:flutter/material.dart';
import 'package:maplibre_example/annotations_page.dart';
import 'package:maplibre_example/callbacks_page.dart';
import 'package:maplibre_example/controller_page.dart';
import 'package:maplibre_example/kiosk_page.dart';
import 'package:maplibre_example/layers_circle_page.dart';
import 'package:maplibre_example/layers_fill_extrusion_page.dart';
import 'package:maplibre_example/layers_fill_page.dart';
import 'package:maplibre_example/layers_heatmap_page.dart';
import 'package:maplibre_example/layers_hillshade_page.dart';
import 'package:maplibre_example/layers_line_page.dart';
import 'package:maplibre_example/layers_raster_page.dart';
import 'package:maplibre_example/layers_symbol_page.dart';
import 'package:maplibre_example/menu_page.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:maplibre_example/two_maps_page.dart';
import 'package:maplibre_example/web_controls_page.dart';

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
      routes: {
        MenuPage.location: (context) => const MenuPage(),
        KioskPage.location: (context) => const KioskPage(),
        StyledMapPage.location: (context) => const StyledMapPage(),
        LayersSymbolPage.location: (context) => const LayersSymbolPage(),
        LayersCirclePage.location: (context) => const LayersCirclePage(),
        LayersHeatmapPage.location: (context) => const LayersHeatmapPage(),
        LayersHillshadePage.location: (context) => const LayersHillshadePage(),
        LayersFillPage.location: (context) => const LayersFillPage(),
        LayersFillExtrusionPage.location: (context) =>
            const LayersFillExtrusionPage(),
        LayersRasterPage.location: (context) => const LayersRasterPage(),
        LayersLinePage.location: (context) => const LayersLinePage(),
        WebControlsPage.location: (context) => const WebControlsPage(),
        AnnotationsPage.location: (context) => const AnnotationsPage(),
        CallbacksPage.location: (context) => const CallbacksPage(),
        ControllerPage.location: (context) => const ControllerPage(),
        TwoMapsPage.location: (context) => const TwoMapsPage(),
      },
    );
  }
}
