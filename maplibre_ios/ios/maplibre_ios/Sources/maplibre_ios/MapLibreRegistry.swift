import Foundation
import MapLibre
import UIKit

// Update the header file for this class like this:
// cd maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/
// swiftc -c MapLibreRegistry.swift -module-name maplibre_ios -emit-objc-header-path MapLibreRegistry.h -emit-library -o libmaplibreios.dylib -target arm64-apple-ios18.1-simulator -sdk $(xcrun --sdk iphonesimulator --show-sdk-path) -F /Users/joscha/Library/Caches/CocoaPods/Pods/Release/MapLibre/6.8.1-46c5f/MapLibre.xcframework/ios-arm64_x86_64-simulator

@objc public class MapLibreRegistry: NSObject {
  private static var mapRegistry: [Int64: AnyObject] = [:]

  // Method to get the map for a given viewId
  @objc public static func getMap(viewId: Int64) -> AnyObject? {
    mapRegistry[viewId]
  }

  // Method to add a map to the registry
  public static func addMap(viewId: Int64, map: AnyObject) {
    mapRegistry[viewId] = map
  }

  // Method to remove a map to the registry
  public static func removeMap(viewId: Int64) {
    mapRegistry.removeValue(forKey: viewId)
  }

  // Warning: Storing Activity in a static field may lead to memory leaks.
  @objc public static var activity: AnyObject?

  // Warning: Storing Context in a static field may lead to memory leaks.
  @objc public static var context: AnyObject?
}
