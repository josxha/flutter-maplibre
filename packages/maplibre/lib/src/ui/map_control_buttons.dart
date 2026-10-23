import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

/// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
///
/// This widget is purposefully kept simple. If you need to change the design
/// or behavior of the zoom buttons a lot, prefer to copy this class into your
/// app and adjust it according to your needs.
///
/// {@category UI}
@immutable
class MapControlButtons extends StatelessWidget {
  /// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const MapControlButtons({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
    this.alignment = Alignment.bottomRight,
    this.tracking,
    this.onTrackingPressed,
  });

  /// The padding.
  final EdgeInsets padding;

  /// The alignment of the buttons.
  final Alignment alignment;

  /// The tracking of the [UserLocationLayer], which the location button
  /// shows.
  final UserLocationTracking? tracking;

  /// Called when the location button is pressed, usually to start tracking
  /// the user location with a [UserLocationLayer]. The button shows only
  /// when this is set.
  final VoidCallback? onTrackingPressed;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();

    return SafeArea(
      child: Container(
        alignment: alignment,
        padding: padding,
        child: Column(
          spacing: 8,
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
            FloatingActionButton(
              heroTag: 'MapLibreZoomOutButton',
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom - 1,
                nativeDuration: const Duration(milliseconds: 200),
              ),
              child: const Icon(Icons.remove),
            ),
            if (onTrackingPressed case final VoidCallback onPressed)
              FloatingActionButton(
                heroTag: 'MapLibreTrackLocationButton',
                onPressed: onPressed,
                child: Icon(switch (tracking) {
                  UserLocationTracking.position => Icons.gps_fixed,
                  UserLocationTracking.positionAndHeading => Icons.explore,
                  UserLocationTracking.none || null => Icons.gps_not_fixed,
                }),
              ),
          ],
        ),
      ),
    );
  }
}
