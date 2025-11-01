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
    arguments _: Any?,
  ) -> FlutterPlatformView {
    MapLibreView(
      frame: frame,
      viewId: viewId,
      binaryMessenger: messenger,
    )
  }
}
