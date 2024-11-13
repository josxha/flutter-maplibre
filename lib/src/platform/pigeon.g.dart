// Autogenerated from Pigeon (v22.6.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

List<Object?> wrapResponse(
    {Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

/// Influences the y direction of the tile coordinates.
enum TileScheme {
  /// Slippy map tilenames scheme.
  xyz,

  /// OSGeo spec scheme.
  tms,
}

/// The encoding used by this source. Mapbox Terrain RGB is used by default.
enum RasterDemEncoding {
  /// Terrarium format PNG tiles.
  terrarium,

  /// Mapbox Terrain RGB tiles.
  mapbox,

  /// Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
  /// parameters.
  custom,
}

/// The reason the camera is changing.
enum CameraChangeReason {
  /// Developer animation.
  developerAnimation,

  /// API animation.
  apiAnimation,

  /// API gesture
  apiGesture,
}

/// The map options define initial values for the MapLibre map.
class MapOptions {
  MapOptions({
    required this.style,
    required this.zoom,
    required this.pitch,
    required this.bearing,
    this.center,
    this.maxBounds,
    required this.minZoom,
    required this.maxZoom,
    required this.minPitch,
    required this.maxPitch,
    required this.gestures,
    required this.androidTextureMode,
  });

  /// The URL of the used map style.
  String style;

  /// The initial zoom level of the map.
  double zoom;

  /// The initial pitch / tilt of the map.
  double pitch;

  /// The initial bearing of the map.
  double bearing;

  /// The initial center coordinates of the map.
  LngLat? center;

  /// The maximum bounding box of the map camera.
  LngLatBounds? maxBounds;

  /// The minimum zoom level of the map.
  double minZoom;

  /// The maximum zoom level of the map.
  double maxZoom;

  /// The minimum pitch / tilt of the map.
  double minPitch;

  /// The maximum pitch / tilt of the map.
  double maxPitch;

  /// The map gestures.
  MapGestures gestures;

  /// Toggle the texture mode on android.
  bool androidTextureMode;

  Object encode() {
    return <Object?>[
      style,
      zoom,
      pitch,
      bearing,
      center,
      maxBounds,
      minZoom,
      maxZoom,
      minPitch,
      maxPitch,
      gestures,
      androidTextureMode,
    ];
  }

  static MapOptions decode(Object result) {
    result as List<Object?>;
    return MapOptions(
      style: result[0]! as String,
      zoom: result[1]! as double,
      pitch: result[2]! as double,
      bearing: result[3]! as double,
      center: result[4] as LngLat?,
      maxBounds: result[5] as LngLatBounds?,
      minZoom: result[6]! as double,
      maxZoom: result[7]! as double,
      minPitch: result[8]! as double,
      maxPitch: result[9]! as double,
      gestures: result[10]! as MapGestures,
      androidTextureMode: result[11]! as bool,
    );
  }
}

/// Map gestures
class MapGestures {
  MapGestures({
    required this.rotate,
    required this.pan,
    required this.zoom,
    required this.tilt,
  });

  /// Rotate the map bearing.
  bool rotate;

  /// Move the center of the map around.
  bool pan;

  /// Zoom the map in and out.
  bool zoom;

  /// Tilt (pitch) the map camera.
  bool tilt;

  Object encode() {
    return <Object?>[
      rotate,
      pan,
      zoom,
      tilt,
    ];
  }

  static MapGestures decode(Object result) {
    result as List<Object?>;
    return MapGestures(
      rotate: result[0]! as bool,
      pan: result[1]! as bool,
      zoom: result[2]! as bool,
      tilt: result[3]! as bool,
    );
  }
}

/// A longitude/latitude coordinate object.
class LngLat {
  LngLat({
    required this.lng,
    required this.lat,
  });

  /// The longitude
  double lng;

  /// The latitude
  double lat;

  Object encode() {
    return <Object?>[
      lng,
      lat,
    ];
  }

  static LngLat decode(Object result) {
    result as List<Object?>;
    return LngLat(
      lng: result[0]! as double,
      lat: result[1]! as double,
    );
  }
}

/// A pixel location / location on the device screen.
class Offset {
  Offset({
    required this.x,
    required this.y,
  });

  /// The x coordinate
  double x;

  /// The y coordinate
  double y;

  Object encode() {
    return <Object?>[
      x,
      y,
    ];
  }

  static Offset decode(Object result) {
    result as List<Object?>;
    return Offset(
      x: result[0]! as double,
      y: result[1]! as double,
    );
  }
}

/// Camera Padding
class Padding {
  Padding({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  int top;

  int bottom;

  int left;

  int right;

  Object encode() {
    return <Object?>[
      top,
      bottom,
      left,
      right,
    ];
  }

  static Padding decode(Object result) {
    result as List<Object?>;
    return Padding(
      top: result[0]! as int,
      bottom: result[1]! as int,
      left: result[2]! as int,
      right: result[3]! as int,
    );
  }
}

/// The current position of the map camera.
class MapCamera {
  MapCamera({
    required this.center,
    required this.zoom,
    required this.pitch,
    required this.bearing,
  });

  LngLat center;

  double zoom;

  double pitch;

  double bearing;

  Object encode() {
    return <Object?>[
      center,
      zoom,
      pitch,
      bearing,
    ];
  }

  static MapCamera decode(Object result) {
    result as List<Object?>;
    return MapCamera(
      center: result[0]! as LngLat,
      zoom: result[1]! as double,
      pitch: result[2]! as double,
      bearing: result[3]! as double,
    );
  }
}

/// LatLng bound object
class LngLatBounds {
  LngLatBounds({
    required this.longitudeWest,
    required this.longitudeEast,
    required this.latitudeSouth,
    required this.latitudeNorth,
  });

  double longitudeWest;

  double longitudeEast;

  double latitudeSouth;

  double latitudeNorth;

  Object encode() {
    return <Object?>[
      longitudeWest,
      longitudeEast,
      latitudeSouth,
      latitudeNorth,
    ];
  }

  static LngLatBounds decode(Object result) {
    result as List<Object?>;
    return LngLatBounds(
      longitudeWest: result[0]! as double,
      longitudeEast: result[1]! as double,
      latitudeSouth: result[2]! as double,
      latitudeNorth: result[3]! as double,
    );
  }
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is TileScheme) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is RasterDemEncoding) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    } else if (value is CameraChangeReason) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    } else if (value is MapOptions) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is MapGestures) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is LngLat) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is Offset) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is Padding) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is MapCamera) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is LngLatBounds) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : TileScheme.values[value];
      case 130:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : RasterDemEncoding.values[value];
      case 131:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : CameraChangeReason.values[value];
      case 132:
        return MapOptions.decode(readValue(buffer)!);
      case 133:
        return MapGestures.decode(readValue(buffer)!);
      case 134:
        return LngLat.decode(readValue(buffer)!);
      case 135:
        return Offset.decode(readValue(buffer)!);
      case 136:
        return Padding.decode(readValue(buffer)!);
      case 137:
        return MapCamera.decode(readValue(buffer)!);
      case 138:
        return LngLatBounds.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class MapLibreHostApi {
  /// Constructor for [MapLibreHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MapLibreHostApi(
      {BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  /// Add a fill layer to the map style.
  Future<void> addFillLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addFillLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a circle layer to the map style.
  Future<void> addCircleLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addCircleLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a background layer to the map style.
  Future<void> addBackgroundLayer({
    required String id,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addBackgroundLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
        .send(<Object?>[id, layout, paint, belowLayerId]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a fill extrusion layer to the map style.
  Future<void> addFillExtrusionLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addFillExtrusionLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a heatmap layer to the map style.
  Future<void> addHeatmapLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addHeatmapLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a hillshade layer to the map style.
  Future<void> addHillshadeLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addHillshadeLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a line layer to the map style.
  Future<void> addLineLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addLineLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a raster layer to the map style.
  Future<void> addRasterLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addRasterLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Add a symbol layer to the map style.
  Future<void> addSymbolLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addSymbolLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[id, sourceId, layout, paint, belowLayerId])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Loads an image to the map. An image needs to be loaded before it can
  /// get used.
  Future<Uint8List> loadImage(String url) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.loadImage$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[url]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as Uint8List?)!;
    }
  }

  /// Add an image to the map.
  Future<void> addImage(String id, Uint8List bytes) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.MapLibreHostApi.addImage$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[id, bytes]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }
}

abstract class MapLibreFlutterApi {
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  /// Get the map options from dart.
  MapOptions getOptions();

  /// Callback for when the style has been loaded.
  void onStyleLoaded();

  /// Callback for when the map is ready and can be used.
  void onMapReady();

  /// Callback when the user clicks on the map.
  void onClick(LngLat point);

  /// Callback when the map idles.
  void onIdle();

  /// Callback when the map camera idles.
  void onCameraIdle();

  /// Callback when the user performs a secondary click on the map
  /// (e.g. by default a click with the right mouse button).
  void onSecondaryClick(LngLat point);

  /// Callback when the user performs a double click on the map.
  void onDoubleClick(LngLat point);

  /// Callback when the user performs a long lasting click on the map.
  void onLongClick(LngLat point);

  /// Callback when the map camera changes.
  void onMoveCamera(MapCamera camera);

  /// Callback when the map camera starts changing.
  void onStartMoveCamera(CameraChangeReason reason);

  static void setUp(
    MapLibreFlutterApi? api, {
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
  }) {
    messageChannelSuffix =
        messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.getOptions$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            final MapOptions output = api.getOptions();
            return wrapResponse(result: output);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStyleLoaded$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onStyleLoaded();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onMapReady$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onMapReady();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onClick$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onClick was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LngLat? arg_point = (args[0] as LngLat?);
          assert(arg_point != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onClick was null, expected non-null LngLat.');
          try {
            api.onClick(arg_point!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onIdle$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onIdle();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onCameraIdle$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onCameraIdle();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onSecondaryClick$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onSecondaryClick was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LngLat? arg_point = (args[0] as LngLat?);
          assert(arg_point != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onSecondaryClick was null, expected non-null LngLat.');
          try {
            api.onSecondaryClick(arg_point!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onDoubleClick$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onDoubleClick was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LngLat? arg_point = (args[0] as LngLat?);
          assert(arg_point != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onDoubleClick was null, expected non-null LngLat.');
          try {
            api.onDoubleClick(arg_point!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onLongClick$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onLongClick was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LngLat? arg_point = (args[0] as LngLat?);
          assert(arg_point != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onLongClick was null, expected non-null LngLat.');
          try {
            api.onLongClick(arg_point!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onMoveCamera$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onMoveCamera was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final MapCamera? arg_camera = (args[0] as MapCamera?);
          assert(arg_camera != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onMoveCamera was null, expected non-null MapCamera.');
          try {
            api.onMoveCamera(arg_camera!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStartMoveCamera$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStartMoveCamera was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CameraChangeReason? arg_reason =
              (args[0] as CameraChangeReason?);
          assert(arg_reason != null,
              'Argument for dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStartMoveCamera was null, expected non-null CameraChangeReason.');
          try {
            api.onStartMoveCamera(arg_reason!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}

class PermissionManagerHostApi {
  /// Constructor for [PermissionManagerHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PermissionManagerHostApi(
      {BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  /// Request location permissions.
  Future<bool> requestLocationPermissions({required String explanation}) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.maplibre.PermissionManagerHostApi.requestLocationPermissions$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[explanation]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }
}
