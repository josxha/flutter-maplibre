import Foundation
import MapLibre

@objc(FlutterApi)
public protocol FlutterApi: AnyObject {
    // Gestures
    @objc func onTap(screenLocation: CGPoint)
    @objc func onSecondaryTap(screenLocation: CGPoint)
    @objc func onDoubleTap(screenLocation: CGPoint)
    @objc func onLongPress(screenLocation: CGPoint)
    
    // MLNMapViewDelegate
    @objc func didFinishLoadingStyle(mapView: MLNMapView, style: MLNStyle)
    @objc func regionWillChangeWithReason(mapView: MLNMapView, reason: UInt, animated: Bool)
    @objc func regionIsChangingWithReason(mapView: MLNMapView, reason: UInt)
    @objc func regionDidChangeWithReason(mapView: MLNMapView, reason: UInt, animated: Bool)
    @objc func didBecomeIdle(mapView: MLNMapView)
}
