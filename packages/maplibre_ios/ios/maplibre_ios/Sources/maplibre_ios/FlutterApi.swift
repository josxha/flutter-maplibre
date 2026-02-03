import Foundation

@objc(FlutterApi)
public protocol FlutterApi {
    @objc func onTap(screenLocation: CGPoint)
    @objc func onSecondaryTap(screenLocation: CGPoint)
    @objc func onDoubleTap(screenLocation: CGPoint)
    @objc func onLongPress(screenLocation: CGPoint)
}
