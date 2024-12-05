import Flutter
import UIKit

public class MapLibreIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "maplibre_ios", binaryMessenger: registrar.messenger())
    let instance = MapLibreIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let factory = MapLibreViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "plugins.flutter.io/maplibre")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
