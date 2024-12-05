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
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class MapLibreView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        //_view.backgroundColor = UIColor.blue
        //let nativeLabel = UILabel()
        //nativeLabel.text = "Native text from iOS, Yieha!"
        //nativeLabel.textColor = UIColor.white
        //nativeLabel.textAlignment = .center
        //nativeLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 48.0)

        let delegate = MapViewDelegate();
        let mapView = MLNMapView(frame: _view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        _view.addSubview(mapView)
        mapView.delegate = delegate
    }
}
