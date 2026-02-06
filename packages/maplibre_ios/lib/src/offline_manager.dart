import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:maplibre_ios/src/extensions.dart';
import 'package:maplibre_ios/src/maplibre_ffi.g.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:objective_c/objective_c.dart' as objc;

/// iOS specific implementation of the [OfflineManager].
class OfflineManagerIos implements OfflineManager {
  /// Create a new iOS specific [OfflineManager] instance.
  OfflineManagerIos(this._storage);

  final MLNOfflineStorage _storage;
  late final OfflinePackProgressCallbacks _callbacks = _createCallbacks(
    WeakReference(this),
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
    final weakCompleter = WeakReference(completer);
    _storage.clearAmbientCacheWithCompletionHandler(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) {
          weakCompleter.target?.completeError(error);
        } else {
          weakCompleter.target?.complete();
        }
      }),
    );
    return completer.future;
  }

  @override
  void dispose() {
    Helpers.removeOfflinePackProgressListenerWithCallbacks(_callbacks);
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
    final ffiRegion = MLNTilePyramidOfflineRegion.new$().initWithStyleURL(
      mapStyleUrl.toNSURL(),
      bounds: bounds.toMLNCoordinateBounds(),
      fromZoomLevel: minZoom,
      toZoomLevel: maxZoom,
    );
    final id = DateTime.now().millisecondsSinceEpoch;
    final context = <String, Object?>{
      'id': id,
      'styleUrl': mapStyleUrl,
      'pixelRatio': pixelDensity,
      ...metadata,
    };
    final streamCtrl = StreamController<DownloadProgress>();
    _downloadStreamControllers[id] = streamCtrl;
    final completer = Completer<MLNOfflinePack>();
    final region = OfflineRegion(
      id: id,
      bounds: bounds,
      minZoom: minZoom,
      maxZoom: maxZoom,
      pixelRatio: 1,
      styleUrl: mapStyleUrl,
    );
    _storage.addPackForRegion(
      ffiRegion,
      withContext: utf8.encode(jsonEncode(context)).toNSData(),
      completionHandler: _createAddPackCompletionHandler(
        weakCompleter: WeakReference(completer),
        weakRegion: WeakReference(region),
        weakStreamCtrl: WeakReference(streamCtrl),
      ),
    );
    final _ = await completer.future;
    yield* streamCtrl.stream;
  }

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) async {
    final packs = _storage.packs!.asDart();
    for (var i = 0; i < packs.length; i++) {
      final ffiPack = MLNOfflinePack.as(packs[i]);
      final json = ffiPack.context.toDartMap();
      if (json['id'] == regionId) {
        final ffiRegion = MLNTilePyramidOfflineRegion.as(ffiPack.region);
        return OfflineRegion(
          id: regionId,
          bounds: ffiRegion.bounds.toLngLatBounds(),
          minZoom: ffiRegion.minimumZoomLevel,
          maxZoom: ffiRegion.maximumZoomLevel,
          pixelRatio: json['pixelRatio'] as double? ?? 1,
          styleUrl: json['styleUrl'] as String? ?? '',
          metadata: json,
        );
      }
    }
    throw Exception('Region not found');
  }

  @override
  Future<void> invalidateAmbientCache() async {
    final completer = Completer<void>();
    final weakCompleter = WeakReference(completer);
    _storage.invalidateAmbientCacheWithCompletionHandler(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) {
          weakCompleter.target?.completeError(error);
        } else {
          weakCompleter.target?.complete();
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
      final jsonBytes = ffiPack.context.toList();
      final json = jsonDecode(utf8.decode(jsonBytes)) as Map<String, Object?>;
      return OfflineRegion(
        id: (json['id'] ?? -1) as int,
        bounds: ffiRegion.bounds.toLngLatBounds(),
        minZoom: ffiRegion.minimumZoomLevel,
        maxZoom: ffiRegion.maximumZoomLevel,
        pixelRatio: json['pixelRatio'] as double? ?? 1,
        styleUrl: json['styleUrl'] as String? ?? '',
        metadata: json,
      );
    }, growable: false);
  }

  @override
  Future<void> resetDatabase() async {
    final completer = Completer<void>();
    final weakCompleter = WeakReference(completer);
    _storage.resetDatabaseWithCompletionHandler(
      ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) {
          weakCompleter.target?.completeError(error);
        } else {
          weakCompleter.target?.complete();
        }
      }),
    );
  }

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async {
    final completer = Completer<void>();
    final weakCompleter = WeakReference(completer);
    _storage.setMaximumAmbientCacheSize(
      bytes,
      withCompletionHandler: ObjCBlock_ffiVoid_NSError.listener((error) {
        if (error != null) {
          weakCompleter.target?.completeError(error);
        } else {
          weakCompleter.target?.complete();
        }
      }),
    );
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

  static OfflinePackProgressCallbacks _createCallbacks(
    WeakReference<OfflineManagerIos> weakManager,
  ) => OfflinePackProgressCallbacks$Builder.implementAsListener(
    onErrorWithNotification_: (notification) =>
        weakManager.target?._onErrorWithNotification(notification),
    onMaximumAllowedTilesWithNotification_: (notification) =>
        weakManager.target?._onMaximumAllowedTiles(notification),
    onProgressChangedWithNotification_: (notification) =>
        weakManager.target?._onProgressChanged(notification),
  );

  void _onProgressChanged(objc.NSNotification notification) {
    final pack = notification.offlinePack;
    if (pack == null) return;
    final json = pack.context.toDartMap();
    final regionId = (json['id'] ?? -1) as int;
    final streamCtrl = _downloadStreamControllers[regionId];
    if (streamCtrl == null) return;
    // final ffiRegion = MLNTilePyramidOfflineRegion.as(pack.region);
    final region = OfflineRegion(
      id: regionId,
      /*bounds: ffiRegion.bounds.toLngLatBounds(),
      minZoom: ffiRegion.minimumZoomLevel,
      maxZoom: ffiRegion.maximumZoomLevel,*/
      bounds: LngLatBounds.fromPoints(const [
        Geographic(lon: 0, lat: 0),
        Geographic(lon: 60, lat: 60),
      ]),
      minZoom: 0,
      maxZoom: 0,
      pixelRatio: json['pixelRatio'] as double? ?? 1,
      styleUrl: json['styleUrl'] as String? ?? '',
      metadata: json,
    );
    streamCtrl.add(pack.toDownloadProgress(region));
  }

  void _onErrorWithNotification(objc.NSNotification notification) {
    /*final pack = notification.offlinePack;
    if (pack == null) return;
    final json = pack.context.toDartMap();
    final regionId = (json['id'] ?? -1) as int;
    final streamCtrl = _downloadStreamControllers[regionId];
    if (streamCtrl == null) return;
    final ffiRegion = MLNTilePyramidOfflineRegion.as(pack.region);
    final region = OfflineRegion(
      id: regionId,
      bounds: ffiRegion.bounds.toLngLatBounds(),
      minZoom: ffiRegion.minimumZoomLevel,
      maxZoom: ffiRegion.maximumZoomLevel,
      pixelRatio: json['pixelRatio'] as double? ?? 1,
      styleUrl: json['styleUrl'] as String? ?? '',
      metadata: json,
    );
    streamCtrl.add(pack.toDownloadProgress(region));*/
  }

  void _onMaximumAllowedTiles(objc.NSNotification notification) {
    /*final pack = notification.offlinePack;
    if (pack == null) return;
    final json = pack.context.toDartMap();
    final regionId = (json['id'] ?? -1) as int;
    final streamCtrl = _downloadStreamControllers[regionId];
    if (streamCtrl == null) return;
    final ffiRegion = MLNTilePyramidOfflineRegion.as(pack.region);
    final region = OfflineRegion(
      id: regionId,
      bounds: ffiRegion.bounds.toLngLatBounds(),
      minZoom: ffiRegion.minimumZoomLevel,
      maxZoom: ffiRegion.maximumZoomLevel,
      pixelRatio: json['pixelRatio'] as double? ?? 1,
      styleUrl: json['styleUrl'] as String? ?? '',
      metadata: json,
    );
    streamCtrl.add(pack.toDownloadProgress(region));*/
  }

  static objc.ObjCBlock<Void Function(MLNOfflinePack?, objc.NSError?)>?
  _createAddPackCompletionHandler({
    required WeakReference<OfflineRegion> weakRegion,
    required WeakReference<Completer<MLNOfflinePack>> weakCompleter,
    required WeakReference<StreamController<DownloadProgress>> weakStreamCtrl,
  }) => ObjCBlock_ffiVoid_MLNOfflinePack_NSError.listener((pack, error) {
    if (error != null) {
      weakCompleter.target?.completeError(error);
      return;
    }
    if (pack == null) {
      weakCompleter.target?.completeError(Exception('Pack is null'));
      return;
    }
    final region = weakRegion.target;
    if (region == null) {
      weakCompleter.target?.completeError(Exception('Region is null'));
      return;
    }
    weakCompleter.target?.complete(pack);
    pack.resume(); // start downloading
    weakStreamCtrl.target?.add(pack.toDownloadProgress(region));
  });
}
