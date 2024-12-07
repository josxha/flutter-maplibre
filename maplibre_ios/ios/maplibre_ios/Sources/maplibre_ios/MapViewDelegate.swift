import MapLibre
import Flutter

class MapLibreView: NSObject, FlutterPlatformView, MLNMapViewDelegate, MapLibreHostApi {
    private var _view: UIView = UIView()
    private var _mapView: MLNMapView!
    private var _viewId: Int64
    private var _flutterApi: MapLibreFlutterApi
    private var _mapOptions: MapOptions? = nil
    
    init(
        frame: CGRect,
        viewId viewId: Int64,
        binaryMessenger binaryMessenger: FlutterBinaryMessenger
    ) {
        var channelSuffix = String(viewId)
        self._viewId = viewId
        self._flutterApi = MapLibreFlutterApi(binaryMessenger: binaryMessenger, messageChannelSuffix: channelSuffix)
        super.init() // self can be used after calling super.init()
        MapLibreHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: self, messageChannelSuffix: channelSuffix)
        _mapView = MLNMapView(frame: _view.bounds)
        // TODO apply MapOptions
        _mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        _view.addSubview(_mapView)
        _mapView.delegate = self
        self._flutterApi.getOptions { result in
            switch result {
            case .success(let mapOptions):
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
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        //self._mapView.addGestureRecognizer(UIPanGestureRecognizer(target: self._view, action: #selector(onPan)))
        //self._mapView.addGestureRecognizer(UITapGestureRecognizer(target: self._view, action: #selector(onTap)))
    }
    
    @objc func onPan() {
        var mlnCamera = _mapView.camera
        var center = LngLat(lng: mlnCamera.centerCoordinate.longitude, lat: mlnCamera.centerCoordinate.latitude)
        var pigeonCamera = MapCamera(center: center, zoom: mlnCamera.altitude, pitch: mlnCamera.pitch, bearing: mlnCamera.heading)
        _flutterApi.onMoveCamera(camera: pigeonCamera) { result in
            // do nothig
        }
    }
    
    @objc func onTap() {
        var mlnCamera = _mapView.camera
        var center = LngLat(lng: mlnCamera.centerCoordinate.longitude, lat: mlnCamera.centerCoordinate.latitude)
        _flutterApi.onClick(point: center) { result in
            // do nothig
        }
    }

    func view() -> UIView {
        return _view
    }
    // MLNMapViewDelegate method called when map has finished loading
    func mapView(mapView: MLNMapView, didFinishLoading _: MLNStyle) {
        self._mapView = mapView
    }
    
    func addFillLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addCircleLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addBackgroundLayer(id: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addFillExtrusionLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addHeatmapLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addHillshadeLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addLineLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addRasterLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func addSymbolLayer(id: String, sourceId: String, layout: [String: Any], paint: [String: Any], belowLayerId: String?, completion: @escaping (Result<Void, Error>) -> Void) {}
    
    func loadImage(url: String, completion: @escaping (Result<FlutterStandardTypedData, Error>) -> Void) {}
    
    func addImage(id: String, bytes: FlutterStandardTypedData, completion: @escaping (Result<Void, Error>) -> Void) {}
}
