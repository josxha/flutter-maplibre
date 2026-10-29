import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:maplibre_native/src/map_renderer.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Shows a MapLibre map rendered by MapLibre Native into a Flutter texture.
class MapLibreNativeView extends StatefulWidget {
  /// Creates a map view that loads [styleUrl].
  const MapLibreNativeView({required this.styleUrl, super.key});

  /// The style the map loads.
  final String styleUrl;

  @override
  State<MapLibreNativeView> createState() => _MapLibreNativeViewState();
}

class _MapLibreNativeViewState extends State<MapLibreNativeView> {
  MapRenderer? _renderer;
  Future<MapRenderer>? _creating;
  var _disposed = false;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final extent = LogicalExtent(
          width: constraints.maxWidth.floor().clamp(1, 16384),
          height: constraints.maxHeight.floor().clamp(1, 16384),
          scaleFactor: pixelRatio,
        );
        _ensureRenderer(extent);
        final renderer = _renderer;
        if (renderer == null) return const SizedBox.expand();
        return Texture(textureId: renderer.textureId);
      },
    );
  }

  void _ensureRenderer(LogicalExtent extent) {
    final renderer = _renderer;
    if (renderer != null) {
      renderer.resize(extent);
      return;
    }
    if (_creating != null) return;
    final styleUrl = widget.styleUrl;
    _creating =
        MapRenderer.create(
          extent: extent,
          setUp: (map) => map.setStyleUrl(styleUrl),
        )..then(
          (renderer) {
            if (_disposed) {
              unawaited(renderer.dispose());
              return;
            }
            setState(() => _renderer = renderer..start());
          },
          onError: (Object error, StackTrace stackTrace) {
            FlutterError.reportError(
              FlutterErrorDetails(
                exception: error,
                stack: stackTrace,
                library: 'maplibre_native',
              ),
            );
          },
        );
  }

  @override
  void dispose() {
    _disposed = true;
    unawaited(_renderer?.dispose());
    super.dispose();
  }
}
