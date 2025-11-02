import Foundation
import MapLibre
import UIKit

// Update the header file for this class like this:
// cd maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/
// ./gen_swift_headers.sh

@objc public class Helpers: NSObject {
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
      let json = try JSONSerialization.jsonObject(
        with: expression.data(using: .utf8)!,
        options: .fragmentsAllowed
      )
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
    }
    // parse as a constant value
    return NSExpression(forConstantValue: expression)
  }
}
