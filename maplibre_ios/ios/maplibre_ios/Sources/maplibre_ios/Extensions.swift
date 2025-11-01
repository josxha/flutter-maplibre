import MapLibre

extension UIColor {
  public convenience init?(hexString: String) {
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
      case 6:  // e.g. FF0000
        if scanner.scanHexInt64(&hexNumber) {
          a = 255
          r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
          g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
          b = CGFloat(hexNumber & 0x0000FF) / 255
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      case 8:  // with alpha value e.g. FFFF0000
        if scanner.scanHexInt64(&hexNumber) {
          a = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
          r = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
          g = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
          b = CGFloat(hexNumber & 0x0000_00FF) / 255
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      case 3:  // short form e.g. "F00"
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
