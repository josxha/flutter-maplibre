import Flutter
import MapLibre
import UIKit

public class MapLibrePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        HostScopedRequestHeaders.shared.install()

        // register MapLibre view factory
        let factory = MapLibreViewFactory(withRegistrar: registrar)
        registrar.register(factory, withId: "plugins.flutter.io/maplibre")
    }
}
