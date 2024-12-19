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

@objc public class Helpers : NSObject {
    @objc public static func setExpression(target: NSObject, field: String, expression: NSExpression) -> Void {
        target.setValue(expression, forKey: field)
    }
    
    @objc public static func parseExpression(propertyName: String, expression: String) -> NSExpression? {
        print(propertyName + "     " + expression)
        do {
            // can't create an Expression using the default method if the data is a hex string
            //if (propertyName.lowercased().contains("color") && expression.first != "[") {
            if (propertyName == "circleStrokeColor") {
                print("##### circleStrokeColor")
                //var color = UIColor(named: expression)
                //return NSExpression(forConstantValue: UIColor(red: 255, green: 0, blue: 0, alpha: 1))
                return NSExpression(mglJSONObject: "[\"literal\", \"#FF0000\"]")
            }
            // can't create an Expression if the data of a literal is an array
            let json = try JSONSerialization.jsonObject(with: expression.data(using: .utf8)!, options: .fragmentsAllowed)
            if let offset = json as? [Any] {
                if offset.count == 2 && offset.first is String && offset.first as? String == "literal" {
                    if let vector = offset.last as? [Any] {
                        if(vector.count == 2) {
                            if let x = vector.first as? Double, let y = vector.last as? Double {
                                return NSExpression(forConstantValue: NSValue(cgVector: CGVector(dx: x, dy: y)))
                            }
                        }
                    }
                }
            }
            return NSExpression(mglJSONObject: json)
        } catch {
            print("Couldn't parse Expression: " + expression)
        }
        return nil
    }
}
