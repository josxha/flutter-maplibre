import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, MLNMapViewDelegate, MapLibreHostApi {
    private var _view: UIView = .init()
    private var _mapView: MLNMapView!
    private var _viewId: Int64
    private var _flutterApi: MapLibreFlutterApi
    private var _mapOptions: MapOptions? = nil

    init(
        frame _: CGRect,
        viewId viewId: Int64,
        binaryMessenger binaryMessenger: FlutterBinaryMessenger
    ) {
        var channelSuffix = String(viewId)
        _viewId = viewId
        _flutterApi = MapLibreFlutterApi(binaryMessenger: binaryMessenger, messageChannelSuffix: channelSuffix)
        super.init() // self can be used after calling super.init()
        MapLibreHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: self, messageChannelSuffix: channelSuffix)
        _mapView = MLNMapView(frame: _view.bounds)
        MapLibreRegistry.addMap(viewId: viewId, map: _mapView)
        _mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        _view.addSubview(_mapView)
        _mapView.delegate = self
        _flutterApi.getOptions { result in
            switch result {
            case let .success(mapOptions):
                self._mapOptions = mapOptions
                if let center = mapOptions.center {
                    var mapCenter = CLLocationCoordinate2D(latitude: center.lat, longitude: center.lng)
                    self._mapView.setCenter(mapCenter, zoomLevel: mapOptions.zoom, animated: false)
                }
                self._mapView.showAttribution(false)
                self._mapView.minimumZoomLevel = mapOptions.minZoom
                self._mapView.maximumZoomLevel = mapOptions.maxZoom
                self._mapView.minimumPitch = mapOptions.minPitch
                self._mapView.maximumPitch = mapOptions.maxPitch
                self._mapView.allowsRotating = mapOptions.gestures.rotate
                self._mapView.allowsZooming = mapOptions.gestures.zoom
                self._mapView.allowsTilting = mapOptions.gestures.tilt
                self._mapView.allowsScrolling = mapOptions.gestures.pan
                self._mapView.styleURL = URL(string: mapOptions.style)
            case let .failure(error):
                print(error)
            }
        }
        // self._mapView.addGestureRecognizer(UIPanGestureRecognizer(target: self._view, action: #selector(onPan)))
        // self._mapView.addGestureRecognizer(UITapGestureRecognizer(target: self._view, action: #selector(onTap)))
    }

    @objc func onPan() {
        var mlnCamera = _mapView.camera
        var center = LngLat(lng: mlnCamera.centerCoordinate.longitude, lat: mlnCamera.centerCoordinate.latitude)
        var pigeonCamera = MapCamera(center: center, zoom: mlnCamera.altitude, pitch: mlnCamera.pitch, bearing: mlnCamera.heading)
        _flutterApi.onMoveCamera(camera: pigeonCamera) { _ in
            // do nothig
        }
    }

    @objc func onTap() {
        var mlnCamera = _mapView.camera
        var center = LngLat(lng: mlnCamera.centerCoordinate.longitude, lat: mlnCamera.centerCoordinate.latitude)
        _flutterApi.onClick(point: center) { _ in
            // do nothig
        }
    }

    func view() -> UIView {
        return _view
    }

    // MLNMapViewDelegate method called when map has finished loading
    func mapView(mapView: MLNMapView, didFinishLoading _: MLNStyle) {
        _mapView = mapView
    }

    func addFillLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addCircleLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addBackgroundLayer(id _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addFillExtrusionLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addHeatmapLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addHillshadeLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addLineLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addRasterLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func addSymbolLayer(id _: String, sourceId _: String, layout _: [String: Any], paint _: [String: Any], belowLayerId _: String?, completion _: @escaping (Result<Void, Error>) -> Void) {}

    func loadImage(url _: String, completion _: @escaping (Result<FlutterStandardTypedData, Error>) -> Void) {}

    func addImage(id _: String, bytes _: FlutterStandardTypedData, completion _: @escaping (Result<Void, Error>) -> Void) {}
}
