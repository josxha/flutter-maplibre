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

@objc public class Helpers: NSObject {
  @objc public static func addImageToStyle(
    target: NSObject, field: String, expression: NSExpression
  ) {
    do {
      target.setValue(expression, forKey: field)
    } catch {
      print("Couldn't set expression in Helpers.addImageToStyle()")
    }
  }

  @objc public static func setExpression(
    target: NSObject, field: String, expression: NSExpression
  ) {
    do {
      // https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue
      try target.setValue(expression, forKey: field)
    } catch {
      print("Couldn't set expression in Helpers.setExpression()")
    }
  }

  @objc public static func parseExpression(
    propertyName: String, expression: String
  ) -> NSExpression? {
    print("\(propertyName): \(expression)")
    do {
      // can't create an Expression using the default method if the data is a hex string
      if propertyName.contains("color"), expression.first == "#" {
        let color = UIColor(hexString: expression)
        return NSExpression(forConstantValue: color)
      }
      if expression.starts(with: "[") {
        // can't create an Expression if the data of a literal is an array
        let json = try JSONSerialization.jsonObject(
          with: expression.data(using: .utf8)!,
          options: .fragmentsAllowed
        )
        // print("json: \(json)")
        if let offset = json as? [Any] {
          if offset.count == 2, offset.first is String,
             offset.first as? String == "literal"
          {
            if let vector = offset.last as? [Any] {
              if vector.count == 2 {
                if let x = vector.first as? Double,
                   let y = vector.last as? Double
                {
                  return NSExpression(
                    forConstantValue: NSValue(
                      cgVector: CGVector(dx: x, dy: y)))
                }
              }
            }
          }
        }
        return NSExpression(mglJSONObject: json)
      }
      // parse as a constant value
      return NSExpression(forConstantValue: expression)

    } catch {
      print("Couldn't parse Expression: " + expression)
    }
    return nil
  }
}

public extension UIColor {
  convenience init?(hexString: String) {
    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
    let a: CGFloat

    if hexString.hasPrefix("#") {
      let start = hexString.index(hexString.startIndex, offsetBy: 1)
      let hexColor = hexString[start...]

      let scanner = Scanner(string: String(hexColor))
      var hexNumber: UInt64 = 0

      switch hexColor.count {
      case 6: // e.g. FF0000
        if scanner.scanHexInt64(&hexNumber) {
          a = 255
          r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
          g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
          b = CGFloat(hexNumber & 0x0000FF) / 255
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      case 8: // with alpha value e.g. FFFF0000
        if scanner.scanHexInt64(&hexNumber) {
          a = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
          r = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
          g = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
          b = CGFloat(hexNumber & 0x0000_00FF) / 255
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      case 3: // short form e.g. "F00"
        if scanner.scanHexInt64(&hexNumber) {
          a = 255
          r = CGFloat((hexNumber & 0xF00) >> 8) / 15
          g = CGFloat((hexNumber & 0x0F0) >> 4) / 15
          b = CGFloat(hexNumber & 0x00F) / 15
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      default:
        break
      }
    }
    return nil
  }
}
