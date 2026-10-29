import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class PausedRenderingPage extends StatefulWidget {
  const PausedRenderingPage({super.key});

  static const location = '/paused-rendering';

  @override
  State<PausedRenderingPage> createState() => _PausedRenderingPageState();
}

/// Two maps in the tabs of an [IndexedStack]. The hidden map pauses on its
/// own and keeps its camera and tiles, and the shown one can be paused with
/// [MapLibreMap.paused].
class _PausedRenderingPageState extends State<PausedRenderingPage> {
  static const List<({String label, Geographic center})> _maps = [
    (label: 'Lake Constance', center: Geographic(lon: 9.17, lat: 47.68)),
    (label: 'New Zealand', center: Geographic(lon: 172.4714, lat: -42.4862)),
  ];

  var _index = 0;

  /// Whether each map stopped rendering, as its events report.
  final List<bool> _paused = List.filled(_maps.length, false);

  /// Whether each map is paused with [MapLibreMap.paused].
  final List<bool> _pausedByFlag = List.filled(_maps.length, false);

  @override
  Widget build(BuildContext context) {
    final showsMap = _index < _maps.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paused Rendering'),
        actions: [
          if (showsMap)
            Row(
              children: [
                const Text('Pause'),
                Switch(
                  value: _pausedByFlag[_index],
                  onChanged: (value) =>
                      setState(() => _pausedByFlag[_index] = value),
                ),
              ],
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              children: [
                for (final (i, map) in _maps.indexed)
                  Chip(
                    avatar: Icon(
                      _paused[i] ? Icons.pause_circle : Icons.play_circle,
                      color: _paused[i] ? Colors.orange : Colors.green,
                    ),
                    label: Text(
                      '${map.label}: ${_paused[i] ? 'paused' : 'rendering'}',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          for (final (i, map) in _maps.indexed)
            _RotatingMap(
              center: map.center,
              paused: _pausedByFlag[i],
              rendering: !_paused[i],
              onRenderingChanged: (paused) =>
                  setState(() => _paused[i] = paused),
            ),
          const _InfoTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          for (final map in _maps)
            NavigationDestination(
              icon: const Icon(Icons.map),
              label: map.label,
            ),
          const NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
        ],
      ),
    );
  }
}

/// A map whose camera turns all the time, so that it renders every frame
/// while it is not paused.
class _RotatingMap extends StatefulWidget {
  const _RotatingMap({
    required this.center,
    required this.paused,
    required this.rendering,
    required this.onRenderingChanged,
  });

  final Geographic center;
  final bool paused;
  final bool rendering;
  final ValueChanged<bool> onRenderingChanged;

  @override
  State<_RotatingMap> createState() => _RotatingMapState();
}

class _RotatingMapState extends State<_RotatingMap> {
  MapController? _controller;
  Timer? _timer;
  var _bearing = 0.0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onMapCreated(MapController controller) {
    _controller = controller;
    // The camera keeps turning while the map is paused. It shows the latest
    // bearing once it renders again.
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      _bearing = (_bearing + 1) % 360;
      unawaited(_controller?.moveCamera(bearing: _bearing));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapLibreMap(
          options: MapOptions(
            initCamera: InitialCamera.position(center: widget.center, zoom: 5),
          ),
          paused: widget.paused,
          onMapCreated: _onMapCreated,
          onEvent: (event) {
            if (event is MapEventRenderingChanged) {
              widget.onRenderingChanged(event.paused);
            }
          },
        ),
        if (!widget.rendering)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Rendering paused',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _InfoTab extends StatelessWidget {
  const _InfoTab();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Both maps stay mounted in an IndexedStack. The one that is not shown '
        'pauses on its own: it stops rendering but keeps its style, camera '
        'and tiles, and shows the latest camera once you return.\n\n'
        'The Pause switch pauses the shown map with MapLibreMap.paused, for '
        'cases Flutter does not report, such as kept-alive TabBarView pages.'
        '\n\nOn the web, maps render only when they change and never pause.',
      ),
    );
  }
}
