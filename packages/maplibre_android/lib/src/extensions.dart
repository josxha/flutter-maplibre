import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:jni/jni.dart';
import 'package:maplibre_android/src/jni.g.dart' as jni;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Extension methods for the [Geographic] class. Not exported publicly.
extension GeographicExt on Geographic {
  /// Convert a [Geographic] to an [jni.LatLng].
  jni.LatLng toLatLng() => jni.LatLng.new$1(lat, lon);
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
  /// Convert an [Offset] to an [jni.PointF].
  jni.PointF toJPointF({required Arena arena}) =>
      jni.PointF.new$3(dx, dy)..releasedBy(arena);
}

/// Extension methods for the [LngLatBounds] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
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
extension OfflineRegionExt on jni.OfflineRegion {
  /// Convert an internal [jni.OfflineRegion] to an [OfflineRegion].
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
  JObject toJObject() {
    switch (this) {
      case final Map<String, Object?> value:
        final jMap = jni.HashMap(
          K: JObject.nullableType,
          V: JObject.nullableType,
        );
        for (final entry in value.entries) {
          final jKey = entry.key.toJObject();
          final jValue = entry.value?.toJObject();
          jMap.put(jKey, jValue);
          jKey.release();
          jValue?.release();
        }
        return jMap;
      case final List<Object?> value:
        final jArray = JArray(JObject.nullableType, value.length);
        for (var i = 0; i < value.length; i++) {
          final jElement = value[i]?.toJObject();
          jArray[i] = jElement;
          jElement?.release();
        }
        return jArray;
      case final String value:
        return value.toJString();
      case final double value:
        return value.toJDouble();
      case final int value:
        return value.toJInteger();
      case final bool value:
        return value.toJBoolean();
      default:
        throw Exception('Unsupported property type: $runtimeType, $this');
    }
  }
}
