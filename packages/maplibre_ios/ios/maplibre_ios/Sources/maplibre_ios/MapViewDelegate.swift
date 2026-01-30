import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, UIGestureRecognizerDelegate
{
    private var _view: UIView = .init()
    private var _mapView: MLNMapView!

    init(frame: CGRect, viewId: Int64) {
        super.init() // self can be used after calling super.init()
        self._mapView = MLNMapView(frame: frame)
        self._mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MapLibreRegistry.addMap(viewId: viewId, map: self._mapView)
        self._view.addSubview(self._mapView)
    }

    /*@objc func onTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        _flutterApi.onClick(
            point: LngLat(lng: point.longitude, lat: point.latitude),
            // NB: iOS points should be equivalent to Flutter LP
            screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
        ) { _ in }
    }

    @objc func onSecondaryTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        _flutterApi.onSecondaryClick(
            point: LngLat(lng: point.longitude, lat: point.latitude),
            screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
        ) { _ in }
    }

    @objc func onDoubleTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        _flutterApi.onDoubleClick(
            point: LngLat(lng: point.longitude, lat: point.latitude),
            screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
        ) { _ in }
    }

    @objc func onLongPress(sender: UILongPressGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        _flutterApi.onLongClick(
            point: LngLat(lng: point.longitude, lat: point.latitude),
            screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
        ) { _ in }
    }*/

    func view() -> UIView {
        _view
    }

    func gestureRecognizer(
        _: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer
    ) -> Bool {
        // Do not override the default behavior
        true
    }
}
