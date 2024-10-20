import 'package:flutter/material.dart';
import 'package:maplibre_example/animation_page.dart';
import 'package:maplibre_example/annotations_circle_page.dart';
import 'package:maplibre_example/annotations_marker_page.dart';
import 'package:maplibre_example/annotations_mixed_page.dart';
import 'package:maplibre_example/annotations_polygon_page.dart';
import 'package:maplibre_example/annotations_polyline_page.dart';
import 'package:maplibre_example/controller_page.dart';
import 'package:maplibre_example/events_page.dart';
import 'package:maplibre_example/gestures_page.dart';
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
import 'package:maplibre_example/parameters_page.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:maplibre_example/two_maps_page.dart';
import 'package:maplibre_example/user_interface_page.dart';
import 'package:maplibre_example/user_location_page.dart';
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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        MenuPage.location: (context) => const MenuPage(),
        KioskPage.location: (context) => const KioskPage(),
        AnimationPage.location: (context) => const AnimationPage(),
        GesturesPage.location: (context) => const GesturesPage(),
        EventsPage.location: (context) => const EventsPage(),
        StyledMapPage.location: (context) => const StyledMapPage(),
        UserLocationPage.location: (context) => const UserLocationPage(),
        UserInterfacePage.location: (context) => const UserInterfacePage(),
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
        AnnotationsMixedPage.location: (context) =>
            const AnnotationsMixedPage(),
        AnnotationsCirclePage.location: (context) =>
            const AnnotationsCirclePage(),
        AnnotationsMarkerPage.location: (context) =>
            const AnnotationsMarkerPage(),
        AnnotationsPolylinePage.location: (context) =>
            const AnnotationsPolylinePage(),
        AnnotationsPolygonPage.location: (context) =>
            const AnnotationsPolygonPage(),
        ParametersPage.location: (context) => const ParametersPage(),
        ControllerPage.location: (context) => const ControllerPage(),
        TwoMapsPage.location: (context) => const TwoMapsPage(),
      },
    );
  }
}
