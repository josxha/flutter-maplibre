import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

/// Regression page for the iOS crash
/// `-[UIDeviceRGBColor count]: unrecognized selector sent to instance`
/// that used to be triggered by setting `hillshade-shadow-color` /
/// `hillshade-highlight-color` (style-spec type `colorArray`) from a hex
/// string, and by the two `numberArray` properties of the layer.
///
/// Every variant below must add its layer without aborting the process.
///
/// See the commit message that introduced this page for the full analysis.
///
/// Run with:
///   flutter run -d `ios-simulator` \
///     --dart-define=HILLSHADE_PAINT=shadow \
///     -t lib/main_hillshade_color_crash.dart
///
/// `HILLSHADE_PAINT` selects the paint applied once the style is loaded, one
/// of the keys of [_paints]. With `none`, the on-screen buttons apply each
/// variant by hand in a single build.
@immutable
class StyleLayersHillshadeColorCrashPage extends StatefulWidget {
  const StyleLayersHillshadeColorCrashPage({super.key});

  static const location = '/style-layers/hillshade-color-crash';

  /// Which paint property is applied automatically once the style is loaded.
  static const autoVariant = String.fromEnvironment(
    'HILLSHADE_PAINT',
    defaultValue: 'shadow',
  );

  @override
  State<StyleLayersHillshadeColorCrashPage> createState() =>
      _StyleLayersHillshadeColorCrashPageState();
}

const _layerId = 'hillshadeCrashLayer';
const _sourceId = 'hillshadeCrashSource';

/// Paint maps, one per variant. All values are written exactly as they appear
/// in a MapLibre style JSON.
const _paints = <String, Map<String, Object>>{
  'none': <String, Object>{},
  // `hillshade-accent-color` is a scalar `color` in the style spec: control.
  'accent': <String, Object>{'hillshade-accent-color': '#5A5A5A'},
  // `hillshade-shadow-color` is a `colorArray` in the style spec: used to
  // crash.
  'shadow': <String, Object>{'hillshade-shadow-color': '#727C83'},
  // `hillshade-highlight-color` is a `colorArray` too: used to crash.
  'highlight': <String, Object>{'hillshade-highlight-color': '#FFFFE4'},
  'all': <String, Object>{
    'hillshade-accent-color': '#5A5A5A',
    'hillshade-shadow-color': '#727C83',
    'hillshade-highlight-color': '#FFFFE4',
  },
  // The crash is not specific to colours: these two are `numberArray` and go
  // through the very same `std::vector<T>` transformer.
  // `numberArray`, spec default is the scalar 335.
  'direction': <String, Object>{'hillshade-illumination-direction': 335},
  // same property, wrapped in a list.
  'direction-list': <String, Object>{
    'hillshade-illumination-direction': <Object>[335],
  },
  // `numberArray`, spec default is the scalar 45.
  'altitude': <String, Object>{'hillshade-illumination-altitude': 45},
  // colorArray fed a one-element list: does not crash, candidate workaround.
  'shadow-list': <String, Object>{
    'hillshade-shadow-color': <Object>['#727C83'],
  },
};

class _StyleLayersHillshadeColorCrashPageState
    extends State<StyleLayersHillshadeColorCrashPage> {
  StyleController? _style;
  String _status = 'waiting for the style to load…';
  bool _layerAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hillshade colorArray crash')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(_status, textAlign: TextAlign.center),
          ),
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final variant in _paints.keys)
                ElevatedButton(
                  onPressed: _style == null ? null : () => _apply(variant),
                  child: Text(variant),
                ),
            ],
          ),
          Expanded(
            child: MapLibreMap(
              options: const MapOptions(
                initCenter: Geographic(lon: 11.39085, lat: 47.27574),
                initZoom: 10,
              ),
              onStyleLoaded: _onStyleLoaded,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    _style = style;
    const source = RasterDemSource(
      id: _sourceId,
      url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
      tileSize: 256,
    );
    await style.addSource(source);
    if (!mounted) return;
    setState(() => _status = 'style loaded, source added');
    await _apply(StyleLayersHillshadeColorCrashPage.autoVariant);
  }

  Future<void> _apply(String variant) async {
    final style = _style;
    final paint = _paints[variant];
    if (style == null || paint == null) return;
    if (_layerAdded) {
      await style.removeLayer(_layerId);
      _layerAdded = false;
    }
    if (mounted) {
      setState(() => _status = 'adding hillshade layer with paint: $paint');
    }
    // Before the fix, on iOS this call aborted the process for `shadow`,
    // `highlight`, `all`, `direction` and `altitude`.
    await style.addLayer(
      HillshadeStyleLayer(id: _layerId, sourceId: _sourceId, paint: paint),
    );
    _layerAdded = true;
    if (mounted) {
      setState(() => _status = 'layer added without crashing (paint: $paint)');
    }
  }
}
