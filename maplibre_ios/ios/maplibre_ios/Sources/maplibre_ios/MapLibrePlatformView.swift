import Foundation
import Flutter
import MapLibre
import UIKit

@objc class MapLibrePlatformView : NSObject, FlutterPlatformView {
    @objc init(view: UIView) {
        self._view = view
        super.init()
    }
    
    fileprivate let _view: UIView
    
    func view() -> UIView {
      _view
    }
}
