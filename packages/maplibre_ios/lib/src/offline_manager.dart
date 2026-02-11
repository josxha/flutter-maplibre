import 'dart:async';
import 'dart:convert';

import 'package:maplibre_ios/src/extensions.dart';
import 'package:maplibre_ios/src/maplibre_ffi.g.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:objective_c/objective_c.dart' as objc;

/// iOS specific implementation of the [OfflineManager].
class OfflineManagerIos implements OfflineManager {
  /// Create a new iOS specific [OfflineManager] instance.
  OfflineManagerIos(this._storage) {
    Helpers.createOfflinePackProgressListenerWithCallbacks(_callbacks);
  }

  final MLNOfflineStorage _storage;
  late final OfflinePackProgressCallbacks _callbacks =
      OfflinePackProgressCallbacks$Builder.implementAsListener(
        onErrorWithNotification_: _onErrorWithNotification,
        onMaximumAllowedTilesWithNotification_: _onMaximumAllowedTiles,
        onProgressChangedWithNotification_: _onProgressChanged,
      );
  final _downloadStreamControllers =
      <int, StreamController<DownloadProgress>>{};

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
  void dispose() {
    Helpers.removeOfflinePackProgressListenerWithCallbacks(_callbacks);
    for (final controller in _downloadStreamControllers.values) {
      if (!controller.isClosed) controller.close();
    }
    _downloadStreamControllers.clear();
  }

  @override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) async* {
    final ffiRegion = Helpers.createTilePyramidOfflineRegionWithStyleURL(
      mapStyleUrl.toNSURL(),
      fromZoomLevel: minZoom,
      toZoomLevel: maxZoom,
      east: bounds.longitudeEast,
      north: bounds.latitudeNorth,
      west: bounds.longitudeWest,
      south: bounds.latitudeSouth,
    );
    final id = DateTime.now().millisecondsSinceEpoch;
    final context = PackContext.fromJson(
      id: id,
      styleUrl: mapStyleUrl,
      pixelDensity: pixelDensity,
      metadata: metadata,
    );
    final streamCtrl = StreamController<DownloadProgress>();
    _downloadStreamControllers[id] = streamCtrl;
    final completer = Completer<MLNOfflinePack>();
    final region = OfflineRegion(
      id: id,
      bounds: bounds,
      minZoom: minZoom,
      maxZoom: maxZoom,
      pixelRatio: pixelDensity,
      styleUrl: mapStyleUrl,
    );
    _storage.addPackForRegion(
      ffiRegion,
      withContext: context.toNSData(),
      completionHandler: ObjCBlock_ffiVoid_MLNOfflinePack_NSError.listener((
        pack,
        error,
      ) {
        if (error != null) {
          completer.completeError(error);
          return;
        }
        if (pack == null) {
          completer.completeError(Exception('Pack is null'));
          return;
        }
        completer.complete(pack);
        pack.resume(); // start downloading
        streamCtrl.add(pack.toDownloadProgress(region));
      }),
    );
    final _ = await completer.future;
    yield* streamCtrl.stream;
  }

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) async {
    final packs = _storage.packs!.asDart();
    for (var i = 0; i < packs.length; i++) {
      final ffiPack = MLNOfflinePack.as(packs[i]);
      final json = PackContext.fromNSData(ffiPack.context);
      if (json.id == regionId) {
        final ffiRegion = MLNTilePyramidOfflineRegion.as(ffiPack.region);
        return OfflineRegion(
          id: regionId,
          bounds: ffiRegion.bounds.toLngLatBounds(),
          minZoom: ffiRegion.minimumZoomLevel,
          maxZoom: ffiRegion.maximumZoomLevel,
          pixelRatio: json.pixelDensity,
          styleUrl: json.styleUrl,
          metadata: json.metadata,
        );
      }
    }
    throw Exception('Region not found');
  }

  @override
  Future<void> invalidateAmbientCache() async {
    final completer = Completer<void>();
    _storage.invalidateAmbientCacheWithCompletionHandler(
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
  Future<List<OfflineRegion>> listOfflineRegions() async {
    final packs = _storage.packs!.asDart();
    return List<OfflineRegion>.generate(packs.length, (i) {
      final ffiPack = MLNOfflinePack.as(packs[i]);
      final ffiRegion = MLNTilePyramidOfflineRegion.as(ffiPack.region);
      final context = PackContext.fromNSData(ffiPack.context);
      return OfflineRegion(
        id: context.id,
        bounds: ffiRegion.bounds.toLngLatBounds(),
        minZoom: ffiRegion.minimumZoomLevel,
        maxZoom: ffiRegion.maximumZoomLevel,
        pixelRatio: context.pixelDensity,
        styleUrl: context.styleUrl,
        metadata: context.metadata,
      );
    }, growable: false);
  }

  @override
  Future<void> resetDatabase() async {
    final completer = Completer<void>();
    final weakStorage = WeakReference(_storage);
    _storage.resetDatabaseWithCompletionHandler(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        weakStorage.target?.reloadPacks();
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
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async {
    final completer = Completer<void>();
    _storage.setMaximumAmbientCacheSize(
      bytes,
      withCompletionHandler: ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) {
          completer.completeError(error);
        } else {
          completer.complete();
        }
      }),
    );
    await completer.future;
  }

  @override
  void setOfflineTileCountLimit({required int amount}) =>
      _storage.setMaximumAllowedMapboxTiles(amount);

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async => throw UnsupportedError(
    'Importing Offline Regions is not available on iOS.',
  );

  @override
  Future<void> packDatabase() async =>
      throw UnsupportedError('The database cannot be packed on iOS.');

  @override
  void runPackDatabaseAutomatically({required bool enabled}) =>
      throw UnsupportedError('The database cannot be packed on iOS.');

  void _onProgressChanged(objc.NSNotification notification) {
    final pack = notification.offlinePack;
    if (pack == null) return;
    final context = PackContext.fromNSData(pack.context);
    final regionId = context.id;
    final streamCtrl = _downloadStreamControllers[regionId];
    if (streamCtrl == null || streamCtrl.isClosed) return;
    final ffiRegion = MLNTilePyramidOfflineRegion.as(pack.region);
    final region = OfflineRegion(
      id: regionId,
      bounds: ffiRegion.bounds.toLngLatBounds(),
      minZoom: ffiRegion.minimumZoomLevel,
      maxZoom: ffiRegion.maximumZoomLevel,
      pixelRatio: context.pixelDensity,
      styleUrl: context.styleUrl,
      metadata: context.metadata,
    );
    final progress = pack.toDownloadProgress(region);
    streamCtrl.add(progress);
    if (progress.downloadCompleted) {
      streamCtrl.close();
      _downloadStreamControllers.remove(regionId);
    }
  }

  void _onErrorWithNotification(objc.NSNotification notification) {
    // TODO check if this is the correct way to handle this notification
    final pack = notification.offlinePack;
    if (pack == null) return;
    final context = PackContext.fromNSData(pack.context);
    final regionId = context.id;
    final streamCtrl = _downloadStreamControllers[regionId];
    if (streamCtrl == null || streamCtrl.isClosed) return;
    final ffiRegion = MLNTilePyramidOfflineRegion.as(pack.region);
    final region = OfflineRegion(
      id: regionId,
      bounds: ffiRegion.bounds.toLngLatBounds(),
      minZoom: ffiRegion.minimumZoomLevel,
      maxZoom: ffiRegion.maximumZoomLevel,
      pixelRatio: context.pixelDensity,
      styleUrl: context.styleUrl,
      metadata: context.metadata,
    );
    final progress = pack.toDownloadProgress(region);
    streamCtrl.add(progress);
  }

  void _onMaximumAllowedTiles(objc.NSNotification notification) {
    // TODO check if this is the correct way to handle this notification
    final pack = notification.offlinePack;
    if (pack == null) return;
    final context = PackContext.fromNSData(pack.context);
    final regionId = context.id;
    final streamCtrl = _downloadStreamControllers[regionId];
    if (streamCtrl == null || streamCtrl.isClosed) return;
    final ffiRegion = MLNTilePyramidOfflineRegion.as(pack.region);
    final region = OfflineRegion(
      id: regionId,
      bounds: ffiRegion.bounds.toLngLatBounds(),
      minZoom: ffiRegion.minimumZoomLevel,
      maxZoom: ffiRegion.maximumZoomLevel,
      pixelRatio: context.pixelDensity,
      styleUrl: context.styleUrl,
      metadata: context.metadata,
    );
    final progress = pack.toDownloadProgress(region);
    streamCtrl.add(progress);
  }
}

extension type const PackContext(Map<String, Object?> data) {
  PackContext.fromJson({
    required int id,
    required String styleUrl,
    required double pixelDensity,
    required Map<String, Object?> metadata,
  }) : this({
         'id': id,
         'styleUrl': styleUrl,
         'pixelRatio': pixelDensity,
         'metadata': metadata,
       });

  PackContext.fromNSData(objc.NSData data) : this(data.toDartMap());

  int get id => data['id'] as int? ?? -1;

  String get styleUrl => data['styleUrl'] as String? ?? '';

  double get pixelDensity => data['pixelRatio'] as double? ?? 1;

  // TODO remove old metadata structure in favor of the new one, but keep it for backwards compatibility for now
  Map<String, Object?> get metadata =>
      (data['metadata'] as Map<String, dynamic>?)?.cast<String, Object?>() ??
      data;

  objc.NSData toNSData() => utf8.encode(jsonEncode(data)).toNSData();
}
