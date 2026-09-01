import 'package:flutter/material.dart';
import 'package:maplibre_example/style_layers_hillshade_color_crash_page.dart';

/// Dedicated entrypoint for the hillshade `colorArray` crash reproduction.
/// See the commit message that introduced this page for the full analysis.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const _CrashApp());
}

class _CrashApp extends StatelessWidget {
  const _CrashApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hillshade colorArray crash',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const StyleLayersHillshadeColorCrashPage(),
    );
  }
}
