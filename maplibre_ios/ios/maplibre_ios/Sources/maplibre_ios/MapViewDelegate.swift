import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, MLNMapViewDelegate, MapLibreHostApi, UIGestureRecognizerDelegate {
    private var _view: UIView = .init()
    private var _mapView: MLNMapView!
    private var _viewId: Int64
    private var _flutterApi: MapLibreFlutterApi
    private var _mapOptions: MapOptions? = nil

    init(
        frame _: CGRect,
        viewId: Int64,
        binaryMessenger: FlutterBinaryMessenger
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
        // disable the default UI because they are rebuilt in Flutter
        _mapView.compassView.isHidden = true
        _mapView.attributionButton.isHidden = true
        _mapView.logoView.isHidden = true
        // get and apply the MapOptions from Flutter
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
        self._flutterApi.onMapReady { _ in }
        // tap gestures
        self._mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(sender:))))
        self._mapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(sender:))))
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        _flutterApi.onClick(point: LngLat(lng:point.longitude, lat: point.latitude)) { _ in }
    }

    @objc func onLongPress(sender: UILongPressGestureRecognizer) {
        var screenPosition = sender.location(in: _mapView)
        var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
        _flutterApi.onLongClick(point: LngLat(lng:point.longitude, lat: point.latitude)) { _ in }
    }

    func view() -> UIView {
        return _view
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Do not override the default behavior
        return true
    }

    // MLNMapViewDelegate method called when map has finished loading
    func mapView(mapView: MLNMapView, didFinishLoading _: MLNStyle) {
        _mapView = mapView
    }
    
    func mapView(_ mapView: MLNMapView, regionDidChangeAnimated animated: Bool) {
        onCameraMoved()
    }
    
    func mapViewRegionIsChanging(_ mapView: MLNMapView) {
        onCameraMoved()
    }
    
    func onCameraMoved() {
        var mlnCamera = _mapView.camera
        var center = LngLat(lng: mlnCamera.centerCoordinate.longitude, lat: mlnCamera.centerCoordinate.latitude)
        var pigeonCamera = MapCamera(center: center, zoom: mlnCamera.altitude, pitch: mlnCamera.pitch, bearing: mlnCamera.heading)
        _flutterApi.onMoveCamera(camera: pigeonCamera) { _ in }
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
