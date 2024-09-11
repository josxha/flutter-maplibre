// Autogenerated from Pigeon (v22.3.0), do not edit directly.
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

List<Object?> wrapResponse({Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

class MapOptions {
  MapOptions({
    required this.style,
    required this.zoom,
    required this.tilt,
    required this.bearing,
    this.center,
    required this.listensOnClick,
    required this.listensOnLongClick,
  });

  String style;

  double zoom;

  double tilt;

  double bearing;

  LngLat? center;

  bool listensOnClick;

  bool listensOnLongClick;

  Object encode() {
    return <Object?>[
      style,
      zoom,
      tilt,
      bearing,
      center,
      listensOnClick,
      listensOnLongClick,
    ];
  }

  static MapOptions decode(Object result) {
    result as List<Object?>;
    return MapOptions(
      style: result[0]! as String,
      zoom: result[1]! as double,
      tilt: result[2]! as double,
      bearing: result[3]! as double,
      center: result[4] as LngLat?,
      listensOnClick: result[5]! as bool,
      listensOnLongClick: result[6]! as bool,
    );
  }
}

class LngLat {
  LngLat({
    required this.lng,
    required this.lat,
  });

  double lng;

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

class ScreenLocation {
  ScreenLocation({
    required this.x,
    required this.y,
  });

  double x;

  double y;

  Object encode() {
    return <Object?>[
      x,
      y,
    ];
  }

  static ScreenLocation decode(Object result) {
    result as List<Object?>;
    return ScreenLocation(
      x: result[0]! as double,
      y: result[1]! as double,
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
    }    else if (value is MapOptions) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    }    else if (value is LngLat) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    }    else if (value is ScreenLocation) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129: 
        return MapOptions.decode(readValue(buffer)!);
      case 130: 
        return LngLat.decode(readValue(buffer)!);
      case 131: 
        return ScreenLocation.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class MapLibreHostApi {
  /// Constructor for [MapLibreHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MapLibreHostApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<void> jumpTo({required LngLat center, double? zoom, double? bearing, double? pitch,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.jumpTo$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[center, zoom, bearing, pitch]) as List<Object?>?;
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

  Future<void> flyTo({required LngLat center, double? zoom, double? bearing, double? pitch,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.flyTo$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[center, zoom, bearing, pitch]) as List<Object?>?;
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

  Future<ScreenLocation> toScreenLocation(double lng, double lat) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.toScreenLocation$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[lng, lat]) as List<Object?>?;
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
      return (pigeonVar_replyList[0] as ScreenLocation?)!;
    }
  }

  Future<LngLat> toLngLat(double x, double y) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.toLngLat$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[x, y]) as List<Object?>?;
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
      return (pigeonVar_replyList[0] as LngLat?)!;
    }
  }

  Future<void> addFillLayer({required String id, required String sourceId}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.addFillLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[id, sourceId]) as List<Object?>?;
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

  Future<void> addCircleLayer({required String id, required String sourceId}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.addCircleLayer$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[id, sourceId]) as List<Object?>?;
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

  Future<void> addGeoJsonSource({required String id, required String data}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.maplibre.MapLibreHostApi.addGeoJsonSource$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[id, data]) as List<Object?>?;
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

  MapOptions getOptions();

  void onStyleLoaded();

  void onClick(LngLat point);

  void onSecondaryClick(LngLat point);

  void onDoubleClick(LngLat point);

  void onLongClick(LngLat point);

  static void setUp(MapLibreFlutterApi? api, {BinaryMessenger? binaryMessenger, String messageChannelSuffix = '',}) {
    messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.getOptions$messageChannelSuffix', pigeonChannelCodec,
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
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStyleLoaded$messageChannelSuffix', pigeonChannelCodec,
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
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onClick$messageChannelSuffix', pigeonChannelCodec,
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
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onSecondaryClick$messageChannelSuffix', pigeonChannelCodec,
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
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onDoubleClick$messageChannelSuffix', pigeonChannelCodec,
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
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onLongClick$messageChannelSuffix', pigeonChannelCodec,
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
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
