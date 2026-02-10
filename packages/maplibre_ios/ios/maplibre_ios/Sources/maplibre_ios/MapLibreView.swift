import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, UIGestureRecognizerDelegate, MLNMapViewDelegate {
    private var _view: UIView = .init()
    private var _viewId: Int64
    private var _mapView: MLNMapView!
    private var _registrar: FlutterPluginRegistrar

    init(registrar: FlutterPluginRegistrar, frame: CGRect, viewId: Int64, initStyle: String) {
        _registrar = registrar
        _viewId = viewId
        super.init() // self can be used after calling super.init()

        let trimmed = initStyle.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.starts(with: "{") {
            // Raw JSON
            _mapView = MLNMapView(frame: frame, styleJSON: trimmed)
        } else if trimmed.starts(with: "/") {
            _mapView = MLNMapView(frame: frame, styleURL: URL(string: "file://\(trimmed)")!)
        } else if !trimmed.starts(with: "http://"),
                  !trimmed.starts(with: "https://"),
                  !trimmed.starts(with: "mapbox://")
        {
            // flutter asset
            let assetPath = _registrar.lookupKey(forAsset: initStyle)
            let url = URL(string: assetPath, relativeTo: Bundle.main.resourceURL)!
            _mapView = MLNMapView(frame: frame, styleURL: url)
        } else {
            // URI
            _mapView = MLNMapView(frame: frame, styleURL: URL(string: trimmed)!)
        }

        _mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MapLibreRegistry.addMap(viewId: viewId, map: _mapView)
        _view.addSubview(_mapView)
        _mapView.delegate = self

        // Double tap
        let doubleTap = UITapGestureRecognizer(
            target: self,
            action: #selector(onDoubleTap(sender:))
        )
        doubleTap.numberOfTapsRequired = 2
        doubleTap.cancelsTouchesInView = false
        doubleTap.delegate = self
        _mapView.addGestureRecognizer(doubleTap)

        // Unified click (primary + secondary)
        let clickTap = UITapGestureRecognizer(
            target: self,
            action: #selector(onTap(sender:))
        )
        clickTap.numberOfTapsRequired = 1
        clickTap.cancelsTouchesInView = false
        clickTap.delegate = self

        // Single waits for double
        clickTap.require(toFail: doubleTap)

        _mapView.addGestureRecognizer(clickTap)

        // Long press
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(onLongPress(sender:))
        )

        longPress.minimumPressDuration = 0.5
        longPress.allowableMovement = 10
        longPress.cancelsTouchesInView = false

        // Long press waits for taps
        longPress.require(toFail: clickTap)
        longPress.require(toFail: doubleTap)

        longPress.delegate = self
        _mapView.addGestureRecognizer(longPress)
    }

    var api: FlutterApi? {
        MapLibreRegistry.getFlutterApi(viewId: _viewId)
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        let screenPosition = sender.location(in: _mapView)

        if #available(iOS 13.4, *) {
            let mask = sender.buttonMask

            // Simulator often sends both → treat as primary
            if mask.contains(.secondary), !mask.contains(.primary) {
                api?.onSecondaryTap(screenLocation: screenPosition)
                return
            }
        }

        // Default: primary click
        api?.onTap(screenLocation: screenPosition)
    }

    @objc func onSecondaryTap(sender: UITapGestureRecognizer) {
        if #available(iOS 13.4, *) {
            // Simulator often sends both buttons — require *only* secondary
            if sender.buttonMask.contains(.primary) {
                return
            }
        }

        var screenPosition = sender.location(in: _mapView)
        api?.onSecondaryTap(screenLocation: screenPosition)
    }

    @objc func onDoubleTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        api?.onDoubleTap(screenLocation: screenPosition)
    }

    @objc func onLongPress(sender: UILongPressGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        api?.onLongPress(screenLocation: screenPosition)
    }

    func view() -> UIView {
        _view
    }

    func gestureRecognizer(
        _: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer
    ) -> Bool {
        // Do not override the default behavior of MapLibre
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
