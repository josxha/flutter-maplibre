import Flutter
import MapLibre
import UIKit

public class MapLibreIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "maplibre_ios", binaryMessenger: registrar.messenger(),
    )
    let instance = MapLibreIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    // register MapLibre view factory
    let factory = MapLibreViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "plugins.flutter.io/maplibre")

    // setup OfflineManager
    OfflineManager(messenger: registrar.messenger())
  }

  public func handle(
    _ call: FlutterMethodCall, result: @escaping FlutterResult,
  ) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
