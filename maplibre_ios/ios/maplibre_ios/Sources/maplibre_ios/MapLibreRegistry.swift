import Foundation
import MapLibre

@objc class MapLibreRegistry: NSObject {
    private static var mapRegistry: [Int64: MLNMapView] = [:]

    // Method to get the map for a given viewId
    @objc public static func getMap(viewId: Int64) -> MLNMapView? {
        return mapRegistry[viewId]
    }

    // Method to add a map to the registry
    public static func addMap(viewId: Int64, map: MLNMapView) {
        mapRegistry[viewId] = map
    }

    // Warning: Storing Activity in a static field may lead to memory leaks.
    @objc public static var activity: AnyObject?

    // Warning: Storing Context in a static field may lead to memory leaks.
    @objc public static var context: AnyObject?
}
