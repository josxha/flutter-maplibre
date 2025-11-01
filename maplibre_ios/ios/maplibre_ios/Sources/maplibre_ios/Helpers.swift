import CwlCatchException
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
    if let exception = NSException.catchException(in: {
      target.setValue(expression, forKey: field)
    }) {
      print("⚠️ Couldn't set expression in Helpers.addImageToStyle(): \(exception)")
    }
  }

  @objc public static func setExpression(
    target: NSObject, field: String, expression: NSExpression
  ) {
    if let exception = NSException.catchException(in: {
      // https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue
      target.setValue(expression, forKey: field)
    }) {
      print("⚠️ Couldn't set expression in Helpers.setExpression(): \(exception)")
    }
  }

  @objc public static func parseExpression(
    propertyName: String, expression: String
  ) -> NSExpression? {
    print("Helpers.parseExpression(): \(propertyName): \(expression)")
    var result: NSExpression? = nil

    if let exception = NSException.catchException(in: {
      // can't create an Expression using the default method if the data is a hex string
      if propertyName.contains("color"), expression.first == "#" {
        guard let color = UIColor(hexString: expression) else {
          print("⚠️ Couldn't create UIColor from hex string: \(expression)")
          return
        }
        result = NSExpression(forConstantValue: color)
        return
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
            if offset.first is String {
              if offset.count == 2, offset.first == "literal" {
                if let vector = offset.last as? [Any] {
                  if vector.count == 2 {
                    if let x = vector.first as? Double,
                       let y = vector.last as? Double
                    {
                      result = NSExpression(
                        forConstantValue: NSValue(
                          cgVector: CGVector(dx: x, dy: y)))
                      return
                    }
                  }
                }
              }
            } else {
              result = NSExpression(forConstantValue: offset)
              return
            }
          }
          result = NSExpression(mglJSONObject: json)
          return
        } catch {
          print("⚠️ JSON parsing error in Helpers.parseExpression(): \(error)")
          return
        }
      }
      // parse as a constant value
      result = NSExpression(forConstantValue: expression)
    }) {
      print("⚠️ Couldn't parse expression in Helpers.parseExpression(): \(exception)")
    }
    return result
  }
}
