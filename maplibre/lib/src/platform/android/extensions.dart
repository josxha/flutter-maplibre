import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

/// Extension methods for the [Geographic] class. Not exported publicly.
extension GeographicExt on Geographic {
  /// Convert a [Geographic] to an internal [pigeon.LngLat].
  pigeon.LngLat toLngLat() => pigeon.LngLat(lng: lon, lat: lat);

  /// Convert a [Geographic] to an [jni.LatLng].
  jni.LatLng toLatLng() => jni.LatLng.new$1(lat, lon);
}

/// Extension methods for the [pigeon.LngLat] class. Not exported publicly.
extension LngLatExt on pigeon.LngLat {
  /// Convert an internal [pigeon.LngLat] to a [Geographic].
  Geographic toGeographic() => Geographic(lon: lng, lat: lat);
}

/// Extension methods for the [pigeon.Offset] class. Not exported publicly.
extension PigeonOffsetExt on pigeon.Offset {
  /// Convert an internal [pigeon.Offset] to a [Offset].
  Offset toOffset() => Offset(x, y);
}

/// Extension methods for the [jni.LatLng] class. Not exported publicly.
extension JniLatLngExt on jni.LatLng {
  /// Convert an internal [jni.LatLng] to a [Geographic].
  Geographic toGeographic({bool releaseOriginal = false}) {
    final point = Geographic(lon: getLongitude(), lat: getLatitude());
    if (releaseOriginal) release();
    return point;
  }
}

/// Extension methods for the [jni.PointF] class. Not exported publicly.
extension PointExt on jni.PointF {
  /// Convert an [jni.PointF] to a [Offset].
  Offset toOffset({bool releaseOriginal = false}) {
    final offset = Offset(x, y);
    if (releaseOriginal) release();
    return offset;
  }
}

/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
  /// Convert an [Offset] to an internal [pigeon.Offset].
  pigeon.Offset toOffset() => pigeon.Offset(x: dx, y: dy);

  /// Convert an [Offset] to an [jni.PointF].
  jni.PointF toJPointF({required Arena arena}) =>
      jni.PointF.new$3(dx, dy)..releasedBy(arena);
}

/// Extension methods for the [LngLatBounds] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
  /// Convert an [LngLatBounds] to an internal [pigeon.LngLatBounds].
  pigeon.LngLatBounds toLngLatBounds() => pigeon.LngLatBounds(
    longitudeEast: longitudeEast,
    longitudeWest: longitudeWest,
    latitudeNorth: latitudeNorth,
    latitudeSouth: latitudeSouth,
  );

  /// Convert an [LngLatBounds] to an internal [jni.LatLngBounds].
  jni.LatLngBounds toJLatLngBounds({required Arena arena}) =>
      jni.LatLngBounds.from(
        latitudeNorth,
        longitudeEast,
        latitudeSouth,
        longitudeWest,
      )..releasedBy(arena);
}

/// Extension methods for the [jni.LatLngBounds] class. Not exported publicly.
extension LatLngBounds on jni.LatLngBounds {
  /// Convert an internal [jni.LatLngBounds] to an [LngLatBounds].
  LngLatBounds toLngLatBounds({bool releaseOriginal = false}) {
    final bounds = LngLatBounds(
      longitudeWest: longitudeWest,
      longitudeEast: longitudeEast,
      latitudeSouth: latitudeSouth,
      latitudeNorth: latitudeNorth,
    );
    if (releaseOriginal) release();
    return bounds;
  }
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert an [EdgeInsets] to an internal [pigeon.Padding].
  pigeon.Padding toPadding() => pigeon.Padding(
    top: top.toInt(),
    bottom: bottom.toInt(),
    left: left.toInt(),
    right: right.toInt(),
  );
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension OfflineRegionExt on jni.OfflineRegion {
  /// Convert an [EdgeInsets] to an internal [pigeon.Padding].
  OfflineRegion toOfflineRegion() => using((arena) {
    final jDefinition = getDefinition()..releasedBy(arena);
    final jMetadata = getMetadata()..releasedBy(arena);
    final metadataBytes = jMetadata.toList();
    final metadataJson = utf8.decode(metadataBytes);
    final metadata = jsonDecode(metadataJson) as Map<String, Object?>;

    return OfflineRegion(
      id: getId(),
      bounds: jDefinition.getBounds()!.toLngLatBounds(releaseOriginal: true),
      minZoom: jDefinition.getMinZoom(),
      maxZoom: jDefinition.getMaxZoom(),
      pixelRatio: jDefinition.getPixelRatio(),
      styleUrl: jDefinition.getStyleURL()!.toDartString(releaseOriginal: true),
      metadata: metadata,
    );
  });
}

/// Extension methods on [Object].
extension ObjectExt on Object {
  /// Convert a [Object] to a [JObject].
  JObject toJObject(Arena arena) {
    return switch (this) {
      final List<Object?> value => JArray.of(
        JObject.nullableType,
        value
            .map((e) => e?.toJObject(arena)?..releasedBy(arena))
            .toList(growable: false),
      ),
      final String value => value.toJString(),
      final double value => value.toJDouble(),
      // a dart int equals a java long
      final int value => value.toJLong(),
      final bool value => value.toJBoolean(),
      _ => throw Exception('Unsupported property type: $runtimeType, $this'),
    };
  }
}
