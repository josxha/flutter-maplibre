import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/ios/extensions.dart';
import 'package:maplibre_ios/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart' as objc;

/// iOS specific implementation of the [OfflineManager].
class OfflineManagerIos implements OfflineManager {
  const OfflineManagerIos._(this._storage);

  final MLNOfflineStorage _storage;

  /// Create a new [OfflineManagerIos] instance.
  static Future<OfflineManagerIos> createInstance() async {
    final storage = MLNOfflineStorage.getSharedOfflineStorage();
    return OfflineManagerIos._(storage);
  }

  @override
  Future<void> clearAmbientCache() async {
    final completion = objc.ObjCBlock<ffi.Void Function(objc.NSError?)>(
      ffi.nullptr,
      retain: false,
      release: true,
    );
    _storage.clearAmbientCacheWithCompletionHandler_(completion);
  }

  @override
  void dispose() {}

  @override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) async* {
    final region = MLNTilePyramidOfflineRegion.new1()
        .initWithStyleURL_bounds_fromZoomLevel_toZoomLevel_(
      mapStyleUrl.toNSURL(),
      bounds.toMLNCoordinateBounds(),
      minZoom,
      maxZoom,
    );
    final context = utf8.encode(jsonEncode(metadata)).toNSData();
    //final completion = objc.ObjCBlock<ffi.Void Function(MLNOfflinePack?, objc.NSError?)>(ffi.nullptr, retain: false, release: true);
    _storage.addPackForRegion_withContext_completionHandler_(
      region,
      context,
      null,
    );
  }

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) async {
    final packs = _storage.packs;
    for (var i = 0; i < packs!.count; i++) {
      final ffiPack = MLNOfflinePack.castFrom(packs.objectAtIndex_(i));
      final jsonBytes = ffiPack.context.toList();
      final json = jsonDecode(utf8.decode(jsonBytes)) as Map<String, Object?>;
      print(json);
      if (json['id'] != regionId) {
        final ffiRegion = MLNTilePyramidOfflineRegion.castFrom(ffiPack.region);
        return OfflineRegion(
          id: regionId,
          bounds: ffiRegion.bounds.toLngLatBounds(),
          minZoom: ffiRegion.minimumZoomLevel,
          maxZoom: ffiRegion.maximumZoomLevel,
          pixelRatio: 1,
          // TODO
          styleUrl: ffiRegion.styleURL.toString(),
        );
      }
    }
    throw Exception('Region not found');
  }

  @override
  Future<void> invalidateAmbientCache() async {
    final completion = objc.ObjCBlock<ffi.Void Function(objc.NSError?)>(
      ffi.nullptr,
      retain: false,
      release: true,
    );
    _storage.invalidateAmbientCacheWithCompletionHandler_(completion);
  }

  @override
  Future<List<OfflineRegion>> listOfflineRegions() async {
    final packs = _storage.packs;
    final regions = <OfflineRegion>[];
    for (var i = 0; i < packs!.count; i++) {
      final ffiPack = MLNOfflinePack.castFrom(packs.objectAtIndex_(i));
      final ffiRegion = MLNTilePyramidOfflineRegion.castFrom(ffiPack.region);
      final jsonBytes = ffiPack.context.toList();
      final json = jsonDecode(utf8.decode(jsonBytes)) as Map<String, Object?>;
      final region = OfflineRegion(
        id: (json['id'] ?? -1) as int,
        bounds: ffiRegion.bounds.toLngLatBounds(),
        minZoom: ffiRegion.minimumZoomLevel,
        maxZoom: ffiRegion.maximumZoomLevel,
        // TODO ffiPack.pixelRatio,
        pixelRatio: 1,
        styleUrl: ffiRegion.styleURL.toString(),
      );
      regions.add(region);
    }
    return regions;
  }

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async {
    // TODO: implement mergeOfflineRegions
    throw UnimplementedError();
  }

  @override
  Future<void> packDatabase() async {
    // TODO: implement packDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> resetDatabase() async {
    final completion = objc.ObjCBlock<ffi.Void Function(objc.NSError?)>(
      ffi.nullptr,
      retain: false,
      release: true,
    );
    _storage.resetDatabaseWithCompletionHandler_(completion);
  }

  @override
  void runPackDatabaseAutomatically({required bool enabled}) async {
    // TODO: implement runPackDatabaseAutomatically
  }

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async {
    final completion = objc.ObjCBlock<ffi.Void Function(objc.NSError?)>(
      ffi.nullptr,
      retain: false,
      release: true,
    );
    _storage.setMaximumAmbientCacheSize_withCompletionHandler_(
      bytes,
      completion,
    );
  }

  @override
  void setOfflineTileCountLimit({required int amount}) =>
      _storage.setMaximumAllowedMapboxTiles_(amount);
}
