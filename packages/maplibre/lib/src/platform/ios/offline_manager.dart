import 'dart:async';
import 'dart:convert';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/ios/extensions.dart';
import 'package:maplibre/src/platform/offline_manager_native.dart';
import 'package:maplibre_ios/maplibre_ffi.g.dart';
import 'package:maplibre_ios/objective_c.dart' as objc;

/// iOS specific implementation of the [OfflineManager].
class OfflineManagerIos extends OfflineManagerNative {
  /// Create a new iOS specific [OfflineManager] instance.
  OfflineManagerIos(this._storage);

  final MLNOfflineStorage _storage;

  /// Create a new [OfflineManagerIos] instance.
  static Future<OfflineManagerIos> createInstance() async {
    final storage = MLNOfflineStorage.getSharedOfflineStorage();
    return OfflineManagerIos(storage);
  }

  @override
  Future<void> clearAmbientCache() async {
    final completer = Completer<void>();
    _storage.clearAmbientCacheWithCompletionHandler(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) {
          completer.completeError(error);
        } else {
          completer.complete();
        }
      }),
    );
    return completer.future;
  }

  @override
  void dispose() {}

  /*@override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) async* {
    final region = MLNTilePyramidOfflineRegion.new$()
        .initWithStyleURL_bounds_fromZoomLevel_toZoomLevel_(
          mapStyleUrl.toNSURL(),
          bounds.toMLNCoordinateBounds(),
          minZoom,
          maxZoom,
        );
    final context = utf8.encode(jsonEncode(metadata)).toNSData();

    final completer = Completer<MLNOfflinePack>();
    _storage.addPackForRegion_withContext_completionHandler_(
      region,
      context,
      ObjCBlock_ffiVoid_MLNOfflinePack_NSError.listener((pack, error) {
        if (pack != null) {
          completer.complete(pack);
          pack.resume(); // start downloading
        }
        completer.completeError(error!);
      }),
    );
    final _ = await completer.future;
    // TODO: use the NotificationCenter to track the download process: https://maplibre.org/maplibre-native/ios/latest/documentation/maplibre-native-for-ios/offlinepackexample/
  }*/

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) async {
    final packs = _storage.packs!.asDart();
    for (var i = 0; i < packs.length; i++) {
      final ffiPack = MLNOfflinePack.as(packs[i]);
      final jsonBytes = ffiPack.context.toList();
      final json = jsonDecode(utf8.decode(jsonBytes)) as Map<String, Object?>;
      // print(json);
      if (json['id'] == regionId) {
        final ffiRegion = MLNTilePyramidOfflineRegion.as(ffiPack.region);
        return OfflineRegion(
          id: regionId,
          bounds: ffiRegion.bounds.toLngLatBounds(),
          minZoom: ffiRegion.minimumZoomLevel,
          maxZoom: ffiRegion.maximumZoomLevel,
          pixelRatio: 1,
          // TODO
          styleUrl: 'ffiRegion.styleURL.toString()',
          metadata: json,
        );
      }
    }
    throw Exception('Region not found');
  }

  /*@override
  Future<void> invalidateAmbientCache() async {
    final completer = Completer<void>();
    _storage.invalidateAmbientCacheWithCompletionHandler_(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) completer.completeError(error);
        return completer.complete();
      }),
    );
    return completer.future;
  }*/

  @override
  Future<List<OfflineRegion>> listOfflineRegions() async {
    final packs = _storage.packs!.asDart();
    return List<OfflineRegion>.generate(packs.length, (i) {
      final ffiPack = MLNOfflinePack.as(packs[i]);
      final ffiRegion = MLNTilePyramidOfflineRegion.as(ffiPack.region);
      final jsonBytes = ffiPack.context.toList();
      final json = jsonDecode(utf8.decode(jsonBytes)) as Map<String, Object?>;
      return OfflineRegion(
        id: (json['id'] ?? -1) as int,
        bounds: ffiRegion.bounds.toLngLatBounds(),
        minZoom: ffiRegion.minimumZoomLevel,
        maxZoom: ffiRegion.maximumZoomLevel,
        // TODO ffiPack.pixelRatio,
        pixelRatio: 1,
        styleUrl: 'ffiRegion.styleURL.absoluteString!.toDartString()',
        metadata: json,
      );
    }, growable: false);
  }

  /*@override
  Future<void> resetDatabase() async {
    final completer = Completer<void>();
    _storage.resetDatabaseWithCompletionHandler_(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) completer.completeError(error);
        completer.complete();
      }),
    );
  }*/

  /*@override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async {
    final completer = Completer<void>();
    _storage.setMaximumAmbientCacheSize_withCompletionHandler_(
      bytes,
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) completer.completeError(error);
        completer.complete();
      }),
    );
  }*/

  @override
  void setOfflineTileCountLimit({required int amount}) =>
      _storage.setMaximumAllowedMapboxTiles(amount);
}
