import MapLibre
import Flutter

class MapViewDelegate: NSObject, MLNMapViewDelegate, MapLibreHostApi {
    var mapView: MLNMapView!

    // MLNMapViewDelegate method called when map has finished loading
    func mapView(_: MLNMapView, didFinishLoading _: MLNStyle) {
    }
    /// Add a fill layer to the map style.
    func addFillLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a circle layer to the map style.
    func addCircleLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a background layer to the map style.
    func addBackgroundLayer(id: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a fill extrusion layer to the map style.
    func addFillExtrusionLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a heatmap layer to the map style.
    func addHeatmapLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a hillshade layer to the map style.
    func addHillshadeLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a line layer to the map style.
    func addLineLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a raster layer to the map style.
    func addRasterLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Add a symbol layer to the map style.
    func addSymbolLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    /// Loads an image to the map. An image needs to be loaded before it can
    /// get used.
    func loadImage(url: String, completion: @escaping (Result<FlutterStandardTypedData, Error>) -> Void) {}
    /// Add an image to the map.
    func addImage(id: String, bytes: FlutterStandardTypedData, completion: @escaping (Result<Void, Error>) -> Void) {}
}
