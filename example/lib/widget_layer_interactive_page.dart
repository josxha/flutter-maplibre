import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class WidgetLayerInteractivePage extends StatefulWidget {
  const WidgetLayerInteractivePage({super.key});
  static const location = '/widget-layer-interactive';

  @override
  State<WidgetLayerInteractivePage> createState() => _WidgetLayerPageState();
}

class _WidgetLayerPageState extends State<WidgetLayerInteractivePage> {
  late final MapController _controller;
  final _mapKey = GlobalKey();

  final _markerPositions = [
    Position(-10, 0),
    Position(-5, 0),
    Position(0, 0),
    Position(5, 0),
  ];

  Position? _originalPosition;
  MapGestures _mapGestures = const MapGestures.all();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Widget Layer')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Long tap map: Create marker.\nTap marker: Show dialog.\nLong tap marker: Show popup menu.\nTap+drag marker: Move marker.',
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: MapLibreMap(
              acceptLicense: true,
              key: _mapKey,
              options: MapOptions(
                initZoom: 3,
                initCenter: Position(0, 0),
                gestures: _mapGestures,
              ),
              onMapCreated: (controller) => _controller = controller,
              onEvent: (event) async {
                if (event is MapEventLongClick) {
                  final position = event.point;
                  _markerPositions.add(position);

                  setState(() {});
                }
              },
              children: [
                WidgetLayer(
                  allowInteraction: true,
                  markers: List.generate(
                    _markerPositions.length,
                    (index) => Marker(
                      size: const Size.square(50),
                      point: _markerPositions[index],
                      child: GestureDetector(
                        onTap: () => _onTap(index),
                        onLongPressStart:
                            (details) => _onLongPress(index, details),
                        onPanStart: (details) => _onPanStart(details, index),
                        onPanUpdate:
                            (details) async => _onPanUpdate(details, index),
                        onPanEnd: (details) async => _onPanEnd(details, index),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // display the UI widgets above the widget markers.
                const MapScalebar(),
                const SourceAttribution(),
                const MapControlButtons(),
                const MapCompass(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _toLngLat(Offset eventOffset) async {
    // Only Android returns screen pixel, other platforms return logical pixels.
    final pixelRatio =
        (!kIsWeb && Platform.isAndroid)
            ? MediaQuery.devicePixelRatioOf(context)
            : 1.0;

    final mapRenderBox =
        _mapKey.currentContext?.findRenderObject() as RenderBox?;

    assert(mapRenderBox != null, 'RenderBox of Map should never be null');

    final mapOffset = mapRenderBox!.localToGlobal(Offset.zero);

    final offset = Offset(
      eventOffset.dx - mapOffset.dx,
      eventOffset.dy - mapOffset.dy,
    );

    return _controller.toLngLat(offset.scale(pixelRatio, pixelRatio));
  }

  void _onLongPress(int index, LongPressStartDetails details) {
    final offset = details.globalPosition;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: [
        const PopupMenuItem<void>(child: Text('Edit')),
        PopupMenuItem<void>(
          onTap: () async {
            final isConfirmed = await _showConfirmationDialogDelete(index);

            if (isConfirmed) {
              _markerPositions.removeAt(index);

              setState(() {});
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Future<void> _onPanEnd(DragEndDetails details, int index) async {
    final isAccepted = await _showConfirmationDialogMove();

    if (!isAccepted) {
      _markerPositions[index] = _originalPosition!;
    } else {
      final newPosition = await _toLngLat(details.globalPosition);
      _markerPositions[index] = newPosition;
    }

    _originalPosition = null;

    setState(() {
      _mapGestures = const MapGestures.all();
    });
  }

  void _onPanStart(DragStartDetails details, int index) {
    // Keep original position in case of discarded move
    _originalPosition = _markerPositions[index].clone();

    setState(() {
      // Disable camera panning while a marker gets moved.
      _mapGestures = const MapGestures.all(pan: false);
    });
  }

  Future<void> _onPanUpdate(DragUpdateDetails details, int index) async {
    final newPosition = await _toLngLat(details.globalPosition);
    _markerPositions[index] = newPosition;

    setState(() {});
  }

  void _onTap(int index) {
    _showMarkerDetails(index);
  }

  Future<bool> _showConfirmationDialogDelete(int index) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Delete marker [$index]?'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
    );

    return isConfirmed ?? false;
  }

  Future<bool> _showConfirmationDialogMove() async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Accept new position?'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Discard'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Accept'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
    );

    return isConfirmed ?? false;
  }

  Future<void> _showMarkerDetails(int index) async {
    await showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Details marker with index: $index'),
            content: Text('Show here the details of Marker with index $index'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );

    return;
  }
}
