import Foundation
import Flutter

@objc public protocol FlutterApi {
    @objc func createPlatformView(viewId: Int) -> FlutterPlatformView
}
