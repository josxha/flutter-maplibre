import Foundation

@objc(FlutterApi)
public protocol FlutterApi {
    @objc func onTap()
    @objc func onSecondaryTap()
    @objc func onDoubleTap()
    @objc func onLongPress()
}
