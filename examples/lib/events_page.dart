import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  static const location = '/events';

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  /// The latest events, one line each. Repeated events of one kind replace
  /// their line.
  final _lines = <({String kind, String text})>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Stack(
        children: [
          MapLibreMap(
            options: const MapOptions(
              initCamera: CameraUpdate.position(
                center: Geographic(lon: 9.17, lat: 47.68),
              ),
            ),
            onMapCreated: (_) => _log('created', 'map created'),
            onStyleLoaded: (_) => _log('style', 'style loaded'),
            onClick: (event) => _log('click', 'clicked: ${_input(event)}'),
            onDoubleClick: (event) =>
                _log('click', 'double clicked: ${_input(event)}'),
            onSecondaryClick: (event) =>
                _log('click', 'secondary clicked: ${_input(event)}'),
            onLongClick: (event) =>
                _log('click', 'long clicked: ${_input(event)}'),
            onCameraMoveStart: (event) =>
                _log('move start', 'camera move start: ${event.reason.name}'),
            onCameraMove: (event) =>
                _log('move', 'camera move: ${_camera(event.camera)}'),
            onCameraMoveEnd: (event) => _log(
              'move end',
              'camera move end (${event.reason.name}): '
                  '${_camera(event.camera)}',
            ),
            onIdle: (_) => _log('idle', 'idle'),
            onLoadingStarted: (_) => _log('loading', 'loading started'),
            onLoadingFinished: (_) => _log('loading', 'loading finished'),
            onSourceChanged: (event) =>
                _log('source', 'source changed: ${event.sourceId}'),
            onStyleImageMissing: (event) =>
                _log('image', 'image missing: ${event.id}'),
            onError: (event) =>
                _log('error', 'error (${event.kind.name}): ${event.message}'),
            onRenderingChanged: (event) => _log(
              'rendering',
              event.paused ? 'rendering paused' : 'rendering resumed',
            ),
            onResize: (event) => _log('resize', 'resized: ${event.size}'),
          ),
          SafeArea(
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomLeft,
                child: Text(
                  _lines.map((line) => line.text).join('\n'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _log(String kind, String text) {
    debugPrint('[MapLibreMap] $text');
    setState(() {
      if (_lines.lastOrNull?.kind == kind) {
        _lines[_lines.length - 1] = (kind: kind, text: text);
      } else {
        _lines.add((kind: kind, text: text));
        if (_lines.length > 10) _lines.removeAt(0);
      }
    });
  }

  String _input(MapEventUserInput event) =>
      '${_formatGeographic(event.point)}, '
      'screen: ${_formatOffset(event.screenPoint)}';

  String _camera(CameraPosition camera) =>
      'center ${_formatGeographic(camera.center)}, '
      'zoom ${camera.zoom.toStringAsFixed(2)}, '
      'pitch ${camera.pitch.toStringAsFixed(2)}, '
      'bearing ${camera.bearing.toStringAsFixed(2)}';

  String _formatGeographic(Geographic point) =>
      '${point.lon.toStringAsFixed(3)}, ${point.lat.toStringAsFixed(3)}';

  String _formatOffset(Offset offset) =>
      '${offset.dx.toStringAsFixed(1)}, ${offset.dy.toStringAsFixed(1)}';
}
