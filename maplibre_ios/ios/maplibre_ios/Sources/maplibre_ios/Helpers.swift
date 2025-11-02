import Foundation
import Flutter
import MapLibre
import UIKit

// Update the header file for this class like this:
// cd maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/
// ./gen_swift_headers.sh

@objc public class Helpers: NSObject {
    @objc public static func createMapLibrePlatformView(view: UIView) -> FlutterPlatformView {
        return MapLibrePlatformView(view: view)
    }
    
  @objc public static func addImageToStyle(
    target: NSObject, field: String, expression: NSExpression
  ) {
      target.setValue(expression, forKey: field)
  }

  @objc public static func setExpression(
    target: NSObject, field: String, expression: NSExpression
  ) {
      // https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue
      target.setValue(expression, forKey: field)
  }

  @objc public static func parseExpression(
    propertyName: String, expression: String
  ) -> NSExpression? {
    print("Helpers.parseExpression(): \(propertyName): \(expression)")

      // can't create an Expression using the default method if the data is a hex string
      if propertyName.contains("color"), expression.first == "#" {
        guard let color = UIColor(hexString: expression) else {
          print("⚠️ Couldn't create UIColor from hex string: \(expression)")
          return nil
        }
        return NSExpression(forConstantValue: color)
      }
      if expression.starts(with: "[") {
        // can't create an Expression if the data of a literal is an array
        do {
          let json = try JSONSerialization.jsonObject(
            with: expression.data(using: .utf8)!,
            options: .fragmentsAllowed
          )

          // print("json: \(json)")
          if let offset = json as? [Any] {
            // Case 1: ["literal", [x, y]]
            if let keyword = offset.first as? String,
               keyword == "literal",
               offset.count == 2,
               let vector = offset.last as? [Any],
               vector.count == 2,
               let x = vector.first as? Double,
               let y = vector.last as? Double
            {
              return NSExpression(
                forConstantValue: NSValue(cgVector: CGVector(dx: x, dy: y))
              )
            }

            // Case 2: simple array literal like [x, y] or [5,5]
            return NSExpression(forConstantValue: offset)
          }
          return NSExpression(mglJSONObject: json)
        } catch {
          print("⚠️ JSON parsing error in Helpers.parseExpression(): \(error)")
          return nil
        }
      }
      // parse as a constant value
      return NSExpression(forConstantValue: expression)
  }
}
