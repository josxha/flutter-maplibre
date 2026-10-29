import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  static const location = '/animation';

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

const _sourceId = 'AnimatedPath';
const _layerId = 'geojson-line';

/// Draws a hiking path as a growing line.
///
/// The path is added once. The animation only moves the end of the line's
/// gradient along `line-progress`, a paint property, so the map neither
/// parses nor tiles the data again. An [AnimationController] updates it once
/// per frame.
class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..addListener(_onAnimate);
  LineStyleLayerController? _line;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation')),
      body: MapLibreMap(
        options: const MapOptions(
          initCamera: InitialCamera.position(
            zoom: 14,
            center: Geographic(lon: -122.01971, lat: 45.632472),
          ),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    _animation.stop();
    _line = null;
    final response = await get(
      Uri.parse('https://maplibre.org/maplibre-gl-js/docs/assets/hike.geojson'),
    );
    await style.addSource(
      // line-progress needs the line metrics of the source.
      GeoJsonSource(id: _sourceId, data: response.body, lineMetrics: true),
    );
    await style.addLayer(
      LineStyleLayer(
        id: _layerId,
        sourceId: _sourceId,
        paint: {'line-width': 3, 'line-gradient': _gradient(0)},
      ),
    );
    final line = await style.getLineLayer(_layerId);
    if (!mounted || line == null) return;
    _line = line;
    _animation.forward(from: 0);
  }

  void _onAnimate() => _line?.lineGradient = _gradient(_animation.value);

  /// Colors the line up to [progress], from 0 at its start to 1 at its end,
  /// and hides the rest.
  static List<Object> _gradient(double progress) => [
    'step',
    ['line-progress'],
    '#F00',
    progress,
    'rgba(0, 0, 0, 0)',
  ];

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}
