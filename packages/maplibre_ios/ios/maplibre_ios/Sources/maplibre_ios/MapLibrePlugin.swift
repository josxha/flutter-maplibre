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
        let factory = MapLibreViewFactory()
        registrar.register(factory, withId: "plugins.flutter.io/maplibre")
    }

    public func handle(_: FlutterMethodCall, result _: @escaping FlutterResult) {}
}

/// A stub class to force the linker to include the MLNMapViewDelegate protocol
public class MLNMapViewDelegateStub: NSObject, MLNMapViewDelegate {
    public override init() {
        super.init()
    }
}

/// A stub class to force the linker to include the FlutterApi protocol
/*
public class FlutterApiStub: NSObject, FlutterApi {
    public override init() {
        super.init()
    }
}
 */
