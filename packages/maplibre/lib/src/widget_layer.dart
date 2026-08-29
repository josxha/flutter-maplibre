import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/translucent_pointer.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Use the [WidgetLayer] to display [Widget]s on the [MapLibreMap]
/// by using it in [MapLibreMap.children].
///
/// {@category Layers}
class WidgetLayer extends StatelessWidget {
  /// Create a new [WidgetLayer] widget.
  const WidgetLayer({
    required this.markers,
    this.allowInteraction = false,
    this.cluster = false,
    this.clusterRadius = 80,
    this.clusterMinPoints = 2,
    this.clusterSize = const Size.square(40),
    this.clusterBuilder,
    this.onClusterTap,
    super.key,
  });

  /// The list of [Marker]s.
  final List<Marker> markers;

  /// Allow gestures on [Marker]s on iOS and Android. The flag is not a
  /// requirement on web but it mimics the same behaviour from other platforms
  /// when set.
  final bool allowInteraction;

  /// If true, [Marker]s that are close to each other on screen are grouped
  /// together into clusters. Unlike the native clustering of [MarkerLayer],
  /// widget marker clustering is computed in Dart based on the on-screen
  /// distance between markers and is recomputed whenever the camera moves, so
  /// clusters split apart as you zoom in.
  ///
  /// Defaults to false.
  final bool cluster;

  /// The maximum distance in logical screen pixels between two [Marker]s for
  /// them to be grouped into the same cluster.
  ///
  /// Only applies when [cluster] is true. Defaults to 80.
  final double clusterRadius;

  /// The minimum number of [Marker]s necessary to form a cluster. Groups
  /// smaller than this are rendered as individual markers.
  ///
  /// Only applies when [cluster] is true. Defaults to 2.
  final int clusterMinPoints;

  /// The [Size] of the widget rendered for a cluster. This is used to position
  /// the cluster widget on the map.
  ///
  /// Only applies when [cluster] is true. Defaults to a 40x40 square.
  final Size clusterSize;

  /// Builds the widget that represents a cluster of [Marker]s. If not provided,
  /// a default circular badge showing the number of markers is used.
  ///
  /// Only applies when [cluster] is true.
  final Widget Function(BuildContext context, MarkerCluster cluster)?
  clusterBuilder;

  /// Called when a cluster is tapped. If not provided, tapping a cluster
  /// animates the camera to the cluster and zooms in by two levels, which
  /// usually splits the cluster apart.
  ///
  /// Only applies when [cluster] is true.
  final void Function(MarkerCluster cluster)? onClusterTap;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    final camera = MapCamera.maybeOf(context);
    if (controller == null || camera == null) return const SizedBox.shrink();

    final points = markers.map((m) => m.point).toList(growable: false);
    final offsets = controller.toScreenLocations(points);

    if (!cluster) {
      final stack = _buildMarkers(camera, offsets);
      // Android and iOS need a TranslucentPointer so that the widgets don't
      // prevent panning on the map.
      return allowInteraction ? stack : TranslucentPointer(child: stack);
    }

    final (:markerWidgets, :clusterWidgets) = _buildClustered(
      context,
      controller,
      camera,
      offsets,
    );
    final markersStack = Stack(children: markerWidgets);
    return Stack(
      children: [
        // Individual markers keep the same pass-through behaviour as before.
        if (allowInteraction)
          markersStack
        else
          TranslucentPointer(child: markersStack),
        // Cluster widgets stay outside of the TranslucentPointer so they can
        // receive taps (e.g. to zoom in).
        ...clusterWidgets,
      ],
    );
  }

  /// Wrap a widget with a [PointerInterceptor] on web when interaction is
  /// allowed, so that clicks are captured by the widget instead of the map.
  Widget _wrapInteraction(Widget child) =>
      (allowInteraction && kIsWeb) ? PointerInterceptor(child: child) : child;

  /// Position a single [Marker] at its screen [offset].
  Widget _positionMarker(MapCamera camera, Marker m, Offset offset) {
    final matrix = Matrix4.identity();
    if (m.flat) matrix.rotateX(camera.pitch * degree2Radian);
    if (m.rotate) matrix.rotateZ(-camera.bearing * degree2Radian);
    return Positioned(
      left: offset.dx - m.size.width / 2 * (m.alignment.x + 1),
      top: offset.dy - m.size.height / 2 * (m.alignment.y + 1),
      height: m.size.height,
      width: m.size.width,
      child: Transform(
        transform: matrix,
        alignment: m.alignment,
        child: _wrapInteraction(m.child),
      ),
    );
  }

  Widget _buildMarkers(MapCamera camera, List<Offset> offsets) => Stack(
    // TODO: filter markers that are completely outside of the visible screen.
    children: markers.indexed
        .map((e) => _positionMarker(camera, e.$2, offsets[e.$1]))
        .toList(growable: false),
  );

  ({List<Widget> markerWidgets, List<Widget> clusterWidgets}) _buildClustered(
    BuildContext context,
    MapController controller,
    MapCamera camera,
    List<Offset> offsets,
  ) {
    final markerWidgets = <Widget>[];
    final clusterWidgets = <Widget>[];
    final visited = List<bool>.filled(markers.length, false);
    for (var i = 0; i < markers.length; i++) {
      if (visited[i]) continue;
      visited[i] = true;
      // Greedily collect all not-yet-clustered markers within [clusterRadius]
      // screen pixels of the anchor marker.
      final groupIndices = <int>[i];
      for (var j = i + 1; j < markers.length; j++) {
        if (visited[j]) continue;
        if ((offsets[i] - offsets[j]).distance <= clusterRadius) {
          visited[j] = true;
          groupIndices.add(j);
        }
      }

      if (groupIndices.length < clusterMinPoints) {
        // Render the group members as individual markers.
        for (final index in groupIndices) {
          markerWidgets.add(
            _positionMarker(camera, markers[index], offsets[index]),
          );
        }
        continue;
      }

      // Render a single cluster widget at the centroid of the group.
      final groupMarkers = groupIndices
          .map((index) => markers[index])
          .toList(growable: false);
      var sumX = 0.0;
      var sumY = 0.0;
      var sumLon = 0.0;
      var sumLat = 0.0;
      for (final index in groupIndices) {
        sumX += offsets[index].dx;
        sumY += offsets[index].dy;
        sumLon += markers[index].point.lon;
        sumLat += markers[index].point.lat;
      }
      final count = groupIndices.length;
      final centroid = Offset(sumX / count, sumY / count);
      final markerCluster = MarkerCluster(
        markers: groupMarkers,
        point: Geographic(lon: sumLon / count, lat: sumLat / count),
      );
      final clusterWidget =
          clusterBuilder?.call(context, markerCluster) ??
          _defaultClusterBuilder(markerCluster);
      Widget tappable = GestureDetector(
        onTap: () => _handleClusterTap(controller, camera, markerCluster),
        child: clusterWidget,
      );
      // On web the map captures pointer events, so intercept them on the
      // cluster widget to make it tappable.
      if (kIsWeb) tappable = PointerInterceptor(child: tappable);
      clusterWidgets.add(
        Positioned(
          left: centroid.dx - clusterSize.width / 2,
          top: centroid.dy - clusterSize.height / 2,
          width: clusterSize.width,
          height: clusterSize.height,
          child: tappable,
        ),
      );
    }
    return (markerWidgets: markerWidgets, clusterWidgets: clusterWidgets);
  }

  void _handleClusterTap(
    MapController controller,
    MapCamera camera,
    MarkerCluster cluster,
  ) {
    if (onClusterTap case final onClusterTap?) {
      onClusterTap(cluster);
      return;
    }
    // Default behaviour: zoom into the cluster.
    unawaited(
      controller.animateCamera(center: cluster.point, zoom: camera.zoom + 2),
    );
  }

  Widget _defaultClusterBuilder(MarkerCluster cluster) => DecoratedBox(
    decoration: const BoxDecoration(
      color: Color(0xFF51BBD6),
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        '${cluster.markers.length}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

/// Information about a cluster of widget [Marker]s, passed to the
/// [WidgetLayer.clusterBuilder].
///
/// {@category Layers}
@immutable
class MarkerCluster {
  /// Create a new [MarkerCluster] instance.
  const MarkerCluster({required this.markers, required this.point});

  /// The [Marker]s contained in this cluster.
  final List<Marker> markers;

  /// The geographic center (centroid) of all [markers] in the cluster. Useful
  /// to e.g. animate the camera to the cluster when it is tapped.
  final Geographic point;
}

/// Model class for a widget marker, can be used in a [WidgetLayer].
///
/// {@category Layers}
@immutable
class Marker {
  /// Create a new [Marker] instance.
  const Marker({
    required this.point,
    required this.size,
    required this.child,
    this.alignment = Alignment.center,
    this.rotate = false,
    this.flat = false,
  });

  /// The [Geographic] of the [Marker].
  final Geographic point;

  /// The [Size] of the [Marker]. This needs to be set to the same dimensions
  /// as the [child] Widget.
  final Size size;

  /// Set to true if the marker should rotate with the map. The [Marker] stays
  /// upright when set to false.
  ///
  /// Defaults to false.
  final bool rotate;

  /// Set to true if the marker should be rendered flat on the map when the map
  /// camera is tilted. with the map.
  ///
  /// Defaults to false.
  final bool flat;

  /// Set the [Alignment] of the marker. Defaults to [Alignment.center].
  final Alignment alignment;

  /// The child widget. You can use any kind of [Widget] here. Use a [Builder]
  /// if you need to access the [MapLibreMap] context.
  final Widget child;
}
