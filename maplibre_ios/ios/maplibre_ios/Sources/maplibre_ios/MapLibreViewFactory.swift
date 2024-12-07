import Flutter
import MapLibre
import UIKit

class MapLibreViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return MapLibreView(
            frame: frame,
            viewId: viewId,
            binaryMessenger: messenger)
    }
}

class MapLibreView: NSObject, FlutterPlatformView {
    private var _view: UIView = UIView()
    private var _viewId: Int64
    private var _flutterApi: MapLibreFlutterApi
    private var _mapOptions: MapOptions

    init(
        frame: CGRect,
        viewId viewId: Int64,
        binaryMessenger binaryMessenger: FlutterBinaryMessenger?
    ) {
        self._viewId = viewId
        final var channelSuffix = String(viewId)
        _flutterApi = MapLibreFlutterApi(binaryMessenger: binaryMessenger, messageChannelSuffix: channelSuffix)
        _flutterApi.getOptions(completion:  (options) -> Void {
            _mapOptions = options
            let delegate = MapViewDelegate();
            MapLibreHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: delegate, messageChannelSuffix: channelSuffix)
            let mapView = MLNMapView(frame: _view.bounds)
            // TODO apply MapOptions
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            _view.addSubview(mapView)
            mapView.delegate = delegate
            
        })
        super.init()
        // iOS views can be created here
        createNativeView()
    }

    func view() -> UIView {
        return _view
    }
}
