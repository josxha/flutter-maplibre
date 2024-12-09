import Foundation
//import MapLibre

// Update the header file for this class like this:
// cd maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/
// swiftc -c MapLibreRegistry.swift -module-name maplibre_ios -emit-objc-header-path MapLibreRegistry.h -emit-library -o libmaplibreios.dylib

@objc public class MapLibreRegistry: NSObject {
    private static var mapRegistry: [Int64: AnyObject] = [:]

    // Method to get the map for a given viewId
    @objc public static func getMap(viewId: Int64) -> AnyObject? {
        return mapRegistry[viewId]
    }

    // Method to add a map to the registry
    public static func addMap(viewId: Int64, map: AnyObject) {
        mapRegistry[viewId] = map
    }

    // Warning: Storing Activity in a static field may lead to memory leaks.
    @objc public static var activity: AnyObject?

    // Warning: Storing Context in a static field may lead to memory leaks.
    @objc public static var context: AnyObject?
}
