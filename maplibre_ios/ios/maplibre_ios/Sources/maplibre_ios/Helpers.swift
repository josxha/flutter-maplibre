import Foundation
import MapLibre
import UIKit

// Update the header file for this class like this:
// cd maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/
// ./gen_swift_headers.sh

@objc(Helpers)
public class Helpers: NSObject {
    @objc public static func setValue(
        target: NSObject, field: String, value: NSObject
    ) {
        // https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue
        target.setValue(value, forKey: field)
    }

    @objc public static func parsePredicate(raw: String) -> NSPredicate? {
        if let data = raw.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                return NSPredicate(mglJSONObject: json)
            } catch let e {
                print("Couldn't parse NSPredicate from JSON: \(e)")
                return nil
            }
        } else {
            return nil
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
                    if offset.count == 2, offset.first as? String == "literal" {
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
                    } else if let first = offset.first, !(first is String) {
                        return NSExpression(forConstantValue: offset)
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
