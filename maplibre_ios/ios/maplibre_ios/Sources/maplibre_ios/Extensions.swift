import MapLibre

public extension UIColor {
    convenience init?(hexString: String) {
        let r, g, b, a: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString[start...]

            let scanner = Scanner(string: String(hexColor))
            var hexNumber: UInt64 = 0

            if hexColor.count == 6 {
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000FF) / 255
                    a = 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 8 {
                if scanner.scanHexInt64(&hexNumber) {
                    a = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    r = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000_00FF) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
