import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, UIGestureRecognizerDelegate
{
    private var _view: UIView = .init()
    private var _viewId: Int64
    private var _mapView: MLNMapView!

    init(frame: CGRect, viewId: Int64) {
        _viewId = viewId
        super.init() // self can be used after calling super.init()
        self._mapView = MLNMapView(frame: frame)
        self._mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MapLibreRegistry.addMap(viewId: viewId, map: self._mapView)
        self._view.addSubview(self._mapView)

        let doubleTap = UITapGestureRecognizer(
            target: self, action: #selector(self.onDoubleTap(sender:))
        )
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        self._mapView.addGestureRecognizer(doubleTap)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
        singleTap.require(toFail: doubleTap)
        singleTap.delegate = self
        if #available(iOS 13.4, *) {
            singleTap.buttonMaskRequired = .primary
        }
        self._mapView.addGestureRecognizer(singleTap)

        if #available(iOS 13.4, *) {
            let secondaryTap = UITapGestureRecognizer(
                target: self, action: #selector(self.onSecondaryTap(sender:))
            )
            secondaryTap.buttonMaskRequired = .secondary
            secondaryTap.delegate = self
            self._mapView.addGestureRecognizer(secondaryTap)
        }

        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.onLongPress(sender:))
        )
        longPress.delegate = self
        self._mapView.addGestureRecognizer(longPress)
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var api = MapLibreRegistry.getFlutterApi(viewId: self._viewId)
        api?.onTap(screenLocation: screenPosition)
    }

    @objc func onSecondaryTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        var api = MapLibreRegistry.getFlutterApi(viewId: self._viewId)
        api?.onSecondaryTap(screenLocation: screenPosition)
    }

    @objc func onDoubleTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        var api = MapLibreRegistry.getFlutterApi(viewId: self._viewId)
        api?.onDoubleTap(screenLocation: screenPosition)
    }

    @objc func onLongPress(sender: UILongPressGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        var api = MapLibreRegistry.getFlutterApi(viewId: self._viewId)
        api?.onLongPress(screenLocation: screenPosition)
    }

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
