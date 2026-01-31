import Flutter
import MapLibre
import UIKit

class MapLibreViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments _: Any?
    ) -> FlutterPlatformView {
        MapLibreView(
            frame: frame,
            viewId: viewId,
        )
    }
}
