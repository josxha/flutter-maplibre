import Flutter
import MapLibre

class OfflineManager: NSObject, OfflineManagerHostApi {
    init(messenger: FlutterBinaryMessenger) {
        super.init()
        OfflineManagerHostApiSetup.setUp(
            binaryMessenger: messenger, api: self, messageChannelSuffix: "")
    }


    func clearAmbientCache(
        completion: @escaping (Result<Void, any Error>) -> Void
    ) {
        MLNOfflineStorage.shared.clearAmbientCache(completionHandler: { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }

    func invalidateAmbientCache(
        completion: @escaping (Result<Void, any Error>) -> Void
    ) {
        MLNOfflineStorage.shared.invalidateAmbientCache(completionHandler: {
            error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }

    func mergeOfflineRegions(
        path: String,
        completion: @escaping (Result<[OfflineRegion], any Error>) -> Void
    ) {
        MLNOfflineStorage.shared.addContents(ofFile: path) {
            url, packs, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let regions = packs?.map({ pack in
                    // TODO implement
                    return OfflineRegion(pack: pack)
                })
                completion(.success((regions)))
            }
        }
    }

    func resetDatabase(completion: @escaping (Result<Void, any Error>) -> Void)
    {
        MLNOfflineStorage.shared.resetDatabase(completionHandler: { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }

    func setMaximumAmbientCacheSize(
        bytes: Int64, completion: @escaping (Result<Void, any Error>) -> Void
    ) {
        MLNOfflineStorage.shared.setMaximumAmbientCacheSize(UInt(bytes)) {
            error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func downloadRegion(
        mapStyleUrl: String, bounds: LngLatBounds, minZoom: Double,
        maxZoom: Double, pixelDensity: Double, metadata: [String: Any?],
        completion: @escaping (Result<Void, any Error>) -> Void
    ) {
        let mlnBounds = MLNCoordinateBounds(
            sw: CLLocationCoordinate2D(
                latitude: bounds.latitudeSouth, longitude: bounds.longitudeWest),
            ne: CLLocationCoordinate2D(
                latitude: bounds.latitudeNorth, longitude: bounds.longitudeEast)
        )
        let region = MLNTilePyramidOfflineRegion(
            styleURL: URL(string: mapStyleUrl), bounds: mlnBounds,
            fromZoomLevel: minZoom, toZoomLevel: maxZoom)
        // TODO implement
        let context = NSData(data: metadata)
        MLNOfflineStorage.shared.addPack(for: region, withContext: context) {
            pack, error in
            pack?.resume()
        }
    }
}
