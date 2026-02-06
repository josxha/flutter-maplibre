import Flutter
import MapLibre
import UIKit

class MapLibreViewFactory: NSObject, FlutterPlatformViewFactory {
    private var _registrar: FlutterPluginRegistrar
    
    init(withRegistrar registrar: FlutterPluginRegistrar) {
        self._registrar = registrar
        super.init()
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        MapLibreView(
            registrar: _registrar,
            frame: frame,
            viewId: viewId,
            initStyle: args as! String?,
        )
    }
}
