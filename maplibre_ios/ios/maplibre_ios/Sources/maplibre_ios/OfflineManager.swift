import Flutter
import MapLibre

class OfflineManager: NSObject, OfflineManagerHostApi {
  init(messenger: FlutterBinaryMessenger) {
    super.init()
    OfflineManagerHostApiSetup.setUp(
      binaryMessenger: messenger, api: self, messageChannelSuffix: ""
    )
  }

  func clearAmbientCache(
    completion: @escaping (Result<Void, any Error>) -> Void
  ) {
    MLNOfflineStorage.shared.clearAmbientCache(completionHandler: { error in
      if let error {
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
      if let error {
        completion(.failure(error))
      } else {
        completion(.success(()))
      }
    })
  }

  func resetDatabase(completion: @escaping (Result<Void, any Error>) -> Void) {
    MLNOfflineStorage.shared.resetDatabase(completionHandler: { error in
      if let error {
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
      if let error {
        completion(.failure(error))
      } else {
        completion(.success(()))
      }
    }
  }

  func downloadRegion(
    mapStyleUrl: String, bounds: LngLatBounds, minZoom: Double,
    maxZoom: Double, pixelDensity _: Double, metadata: String,
    completion: @escaping (Result<Void, any Error>) -> Void
  ) {
    // TODO: encode all information into the metadata for parity with android
    let mlnBounds = MLNCoordinateBounds(
      sw: CLLocationCoordinate2D(
        latitude: bounds.latitudeSouth, longitude: bounds.longitudeWest
      ),
      ne: CLLocationCoordinate2D(
        latitude: bounds.latitudeNorth, longitude: bounds.longitudeEast
      )
    )
    let region = MLNTilePyramidOfflineRegion(
      styleURL: URL(string: mapStyleUrl), bounds: mlnBounds,
      fromZoomLevel: minZoom, toZoomLevel: maxZoom
    )
    // TODO: implement
    let context = metadata.data(using: .utf8)
    if context == nil {
      let error = PigeonError(
        code: "INVALID_METADATA",
        message: "The metadata could not be converted to NSData.",
        details: nil
      )
      completion(.failure(error))
      return
    }
    MLNOfflineStorage.shared.addPack(for: region, withContext: context!) {
      pack, _ in
      pack?.resume()
      // TODO: listen to updates
      completion(.success(()))
    }
  }
}
