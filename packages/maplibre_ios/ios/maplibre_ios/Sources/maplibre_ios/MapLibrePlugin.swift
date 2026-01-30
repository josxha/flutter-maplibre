import Flutter
import MapLibre
import UIKit

public class MapLibrePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "maplibre_ios", binaryMessenger: registrar.messenger()
        )
        let instance = MapLibrePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)

        // register MapLibre view factory
        let factory = MapLibreViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "plugins.flutter.io/maplibre")

        // setup OfflineManager
        OfflineManager(messenger: registrar.messenger())
    }

    public func handle(_: FlutterMethodCall, result _: @escaping FlutterResult) {}
}
