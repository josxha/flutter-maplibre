import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/ui/map_button.dart';

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
    this.backgroundColor = MapButton.defaultBackgroundColor,
    this.iconColor = MapButton.defaultIconColor,
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

  /// The background color of the buttons. Defaults to white.
  final Color backgroundColor;

  /// The color of the icons. Defaults to dark grey.
  final Color iconColor;

  static const _zoomAnimation = CameraAnimation.ease(
    duration: Duration(milliseconds: 200),
  );

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
            MapButton(
              backgroundColor: backgroundColor,
              iconColor: iconColor,
              icon: MapButtonIcon.zoomIn,
              label: 'Zoom in',
              onPressed: () => controller.animateCamera(
                CameraUpdate.position(zoom: controller.getCamera().zoom + 1),
                animation: _zoomAnimation,
              ),
            ),
            MapButton(
              backgroundColor: backgroundColor,
              iconColor: iconColor,
              icon: MapButtonIcon.zoomOut,
              label: 'Zoom out',
              onPressed: () => controller.animateCamera(
                CameraUpdate.position(zoom: controller.getCamera().zoom - 1),
                animation: _zoomAnimation,
              ),
            ),
            if (onTrackingPressed case final VoidCallback onPressed)
              MapButton(
                backgroundColor: backgroundColor,
                iconColor: iconColor,
                icon: switch (tracking) {
                  UserLocationTracking.position => MapButtonIcon.location,
                  UserLocationTracking.positionAndHeading =>
                    MapButtonIcon.locationAndHeading,
                  UserLocationTracking.none ||
                  null => MapButtonIcon.locationOff,
                },
                label: 'Track location',
                onPressed: onPressed,
              ),
          ],
        ),
      ),
    );
  }
}
