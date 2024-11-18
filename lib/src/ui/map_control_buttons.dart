import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
///
/// This widget is purposefully kept simple. If you need to change the design
/// or behavior of the zoom buttons a lot, prefer to copy this class into your
/// app and adjust it according to your needs.
@immutable
class MapControlButtons extends StatefulWidget {
  /// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const MapControlButtons({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
    this.alignment = Alignment.bottomRight,
    this.showTrackLocation = false,
    this.requestPermissionsExplanation =
        'We need your location to show it on the map.',
  });

  /// The padding.
  final EdgeInsets padding;

  /// The alignment of the buttons.
  final Alignment alignment;

  /// Whether to show the track location button.
  ///
  /// This button is currently not available on web.
  final bool showTrackLocation;

  /// The explanation to show when requesting location permissions.
  final String requestPermissionsExplanation;

  @override
  State<MapControlButtons> createState() => _MapControlButtonsState();
}

class _MapControlButtonsState extends State<MapControlButtons> {
  late final PermissionManager? permissionManager;
  bool loading = false;
  bool isGpsFixed = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && widget.showTrackLocation) {
      permissionManager = PermissionManager();

      // if (permissionManager!.locationPermissionsGranted) {
      //   setState(() => isGpsFixed = true);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();

    return Container(
      alignment: widget.alignment,
      padding: widget.padding,
      child: PointerInterceptor(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'MapLibreZoomInButton',
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom + 1,
                nativeDuration: const Duration(milliseconds: 200),
              ),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'MapLibreZoomOutButton',
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom - 1,
                nativeDuration: const Duration(milliseconds: 200),
              ),
              child: const Icon(Icons.remove),
            ),
            if (!kIsWeb && widget.showTrackLocation) ...[
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'MapLibreTrackLocationButton',
                onPressed: () async {
                  setState(() => loading = true);

                  try {
                    if (!permissionManager!.locationPermissionsGranted) {
                      await permissionManager!.requestLocationPermissions(
                        explanation: widget.requestPermissionsExplanation,
                      );
                    }
                    await _enableLocationTracking(controller);
                  } finally {
                    setState(() => loading = false);
                  }
                },
                child: loading
                    ? const SizedBox.square(
                        dimension: kDefaultFontSize,
                        child: CircularProgressIndicator(),
                      )
                    : Icon(
                        isGpsFixed ? Icons.gps_fixed : Icons.gps_not_fixed,
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _enableLocationTracking(MapController controller) async {
    if (!permissionManager!.locationPermissionsGranted) return;

    await controller.enableLocation();
    await controller.trackLocation();
    setState(() {
      loading = false;
      isGpsFixed = true;
    });
  }
}
