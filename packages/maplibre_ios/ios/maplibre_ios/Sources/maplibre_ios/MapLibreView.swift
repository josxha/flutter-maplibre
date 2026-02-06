import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, UIGestureRecognizerDelegate, MLNMapViewDelegate
{
    private var _view: UIView = .init()
    private var _viewId: Int64
    private var _mapView: MLNMapView!
    private var _registrar: FlutterPluginRegistrar

    init(registrar: FlutterPluginRegistrar, frame: CGRect, viewId: Int64, initStyle: String?) {
        _registrar = registrar
        _viewId = viewId
        super.init() // self can be used after calling super.init()
        
        if let initStyle = initStyle {
            let trimmed = initStyle.trimmingCharacters(in: .whitespacesAndNewlines);
            if (trimmed.starts(with: "{")) {
                // Raw JSON
                self._mapView = MLNMapView(frame: frame, styleJSON: trimmed)
            } else if (trimmed.starts(with: "/")) {
                self._mapView = MLNMapView(frame: frame, styleURL: URL(string: "file://\(trimmed)")!)
            } else if (!trimmed.starts(with: "http://") &&
                !trimmed.starts(with: "https://") &&
                !trimmed.starts(with: "mapbox://")) {
              // flutter asset
                let assetPath = self._registrar.lookupKey(forAsset: initStyle)
                let url =  URL(string: assetPath, relativeTo: Bundle.main.resourceURL)!
                self._mapView = MLNMapView(frame: frame, styleURL: url)
            } else {
              // URI
                self._mapView = MLNMapView(frame: frame, styleURL: URL(string: trimmed)!)
            }
        }
                                
        self._mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MapLibreRegistry.addMap(viewId: viewId, map: self._mapView)
        self._view.addSubview(self._mapView)
        self._mapView.delegate = self

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
    
    var api: FlutterApi? {
        MapLibreRegistry.getFlutterApi(viewId: _viewId)
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        api?.onTap(screenLocation: screenPosition)
    }

    @objc func onSecondaryTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        api?.onSecondaryTap(screenLocation: screenPosition)
    }

    @objc func onDoubleTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        api?.onDoubleTap(screenLocation: screenPosition)
    }

    @objc func onLongPress(sender: UILongPressGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
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
    
    func mapView(_ mapView: MLNMapView, didFinishLoading style: MLNStyle) {
        api?.didFinishLoadingStyle(mapView: mapView, style: style)
    }
    
    func mapView(_ mapView: MLNMapView, regionWillChangeWith reason: MLNCameraChangeReason, animated: Bool) {
        api?.regionWillChangeWithReason(mapView: mapView, reason: reason.rawValue, animated: animated)
    }
    
    func mapView(_ mapView: MLNMapView, regionIsChangingWith reason: MLNCameraChangeReason) {
        api?.regionIsChangingWithReason(mapView: mapView, reason: reason.rawValue)
    }
    
    func mapView(_ mapView: MLNMapView, regionDidChangeWith reason: MLNCameraChangeReason, animated: Bool) {
        api?.regionDidChangeWithReason(mapView: mapView, reason: reason.rawValue, animated: animated)
    }
    
    func mapViewDidBecomeIdle(_ mapView: MLNMapView) {
        api?.didBecomeIdle(mapView: mapView)
    }
}
