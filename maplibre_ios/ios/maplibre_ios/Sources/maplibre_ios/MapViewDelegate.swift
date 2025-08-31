import Flutter
import MapLibre

class MapLibreView: NSObject, FlutterPlatformView, MLNMapViewDelegate,
  MapLibreHostApi, UIGestureRecognizerDelegate
{
  private var _view: UIView = .init()
  private var _mapView: MLNMapView!
  private var _viewId: Int64
  private var _flutterApi: MapLibreFlutterApi
  private var _mapOptions: MapOptions?

  init(
    frame _: CGRect,
    viewId: Int64,
    binaryMessenger: FlutterBinaryMessenger
  ) {
    print("### init new MapViewDelegate ### \(viewId) ###")
    var channelSuffix = String(viewId)
    _viewId = viewId
    _flutterApi = MapLibreFlutterApi(
      binaryMessenger: binaryMessenger,
      messageChannelSuffix: channelSuffix
    )
    super.init() // self can be used after calling super.init()
    MapLibreHostApiSetup.setUp(
      binaryMessenger: binaryMessenger, api: self,
      messageChannelSuffix: channelSuffix
    )
    // get and apply the MapOptions from Flutter
    _flutterApi.getOptions { result in
      switch result {
      case let .success(mapOptions):
        self._mapOptions = mapOptions

        if mapOptions.style.hasPrefix("{") || mapOptions.style.hasPrefix("[") {
          self._mapView = MLNMapView(frame: self._view.bounds, styleJSON: mapOptions.style)
        } else {
          self._mapView = MLNMapView(frame: self._view.bounds, styleURL: URL(string: mapOptions.style))
        }

        MapLibreRegistry.addMap(viewId: viewId, map: self._mapView)
        self._mapView.autoresizingMask = [
          .flexibleWidth, .flexibleHeight,
        ]
        self._view.addSubview(self._mapView)
        self._mapView.delegate = self
        // disable the default UI because they are rebuilt in Flutter
        self._mapView.compassView.isHidden = true
        self._mapView.attributionButton.isHidden = true
        self._mapView.logoView.isHidden = true
        // set options
        DispatchQueue.main.async {
          var currentCenter = self._mapView.camera.centerCoordinate
          var center = CLLocationCoordinate2D(
            latitude: mapOptions.center?.lat
              ?? currentCenter.latitude,
            longitude: mapOptions.center?.lng
              ?? currentCenter.longitude
          )
          self._mapView.setCenter(
            center, zoomLevel: mapOptions.zoom,
            direction: mapOptions.bearing, animated: false
          )
        }

        self._mapView.showAttribution(false)

        self._mapView.minimumZoomLevel = mapOptions.minZoom
        self._mapView.maximumZoomLevel = mapOptions.maxZoom
        self._mapView.minimumPitch = mapOptions.minPitch
        self._mapView.maximumPitch = mapOptions.maxPitch

        self._mapView.allowsRotating = mapOptions.gestures.rotate
        self._mapView.allowsScrolling = mapOptions.gestures.pan
        self._mapView.allowsTilting = mapOptions.gestures.tilt
        self._mapView.allowsZooming = mapOptions.gestures.zoom

        self._flutterApi.onMapReady { _ in }
        // tap gestures
        self._mapView.addGestureRecognizer(
          UITapGestureRecognizer(
            target: self, action: #selector(self.onTap(sender:))
          ))
        self._mapView.addGestureRecognizer(
          UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.onLongPress(sender:))
          ))
      case let .failure(error):
        print(error)
      }
    }
  }

  func dispose() throws {
    print("### dispose MapLibre view ### \(_viewId) ###")
    MapLibreRegistry.removeMap(viewId: _viewId)
    _mapView.removeFromSuperview()
    _mapView.delegate = nil
    _mapView = nil
    _view.removeFromSuperview()
  }

  @objc func onTap(sender: UITapGestureRecognizer) {
    var screenPosition = sender.location(in: _mapView)
    var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
    _flutterApi.onClick(
      point: LngLat(lng: point.longitude, lat: point.latitude)
    ) { _ in }
  }

  @objc func onLongPress(sender: UILongPressGestureRecognizer) {
    var screenPosition = sender.location(in: _mapView)
    var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
    _flutterApi.onLongClick(
      point: LngLat(lng: point.longitude, lat: point.latitude)
    ) { _ in }
  }

  func view() -> UIView {
    _view
  }

  func gestureRecognizer(
    _: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer
  ) -> Bool {
    // Do not override the default behavior
    true
  }

  // MLNMapViewDelegate method called when map has finished loading
  func mapView(_ mapView: MLNMapView, didFinishLoading _: MLNStyle) {
    // setCamera() can only be used after the map did finish loading
    var camera = _mapView.camera
    camera.pitch = _mapOptions!.pitch
    _mapView.setCamera(camera, animated: false)

    _mapView = mapView
    print("mapView didFinishLoading, call onStyleLoaded")
    _flutterApi.onStyleLoaded { _ in }
  }

  func mapView(_: MLNMapView, regionDidChangeAnimated _: Bool) {
    onCameraMoved()
  }

  func mapViewRegionIsChanging(_: MLNMapView) {
    onCameraMoved()
  }

  func onCameraMoved() {
    var mlnCamera = _mapView.camera
    var center = LngLat(
      lng: mlnCamera.centerCoordinate.longitude,
      lat: mlnCamera.centerCoordinate.latitude
    )
    var pigeonCamera = MapCamera(
      center: center, zoom: mlnCamera.altitude, pitch: mlnCamera.pitch,
      bearing: mlnCamera.heading
    )
    _flutterApi.onMoveCamera(camera: pigeonCamera) { _ in }
  }

  func addFillLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addCircleLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addBackgroundLayer(
    id _: String, layout _: [String: Any], paint _: [String: Any],
    belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addFillExtrusionLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addHeatmapLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addHillshadeLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addLineLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addRasterLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func addSymbolLayer(
    id _: String, sourceId _: String, layout _: [String: Any],
    paint _: [String: Any], belowLayerId _: String?,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    completion(.success(()))
  }

  func loadImage(
    url _: String,
    completion _: @escaping (Result<FlutterStandardTypedData, Error>) ->
      Void
  ) {
    // completion(.success((bytes)))
  }

  func addImage(
    id: String, bytes: FlutterStandardTypedData,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    // Main Thread Checker: UI API called on a background thread: -[UIView frame]
    // DispatchQueue.main.async {
    print("addImage before")
    var style = _mapView.style!
    var imageData = bytes.data
    var image = UIImage(data: imageData, scale: UIScreen.main.scale)!
    style.setImage(image, forName: id)
    print("addImage afters")
    print("added image: \(style.image(forName: id))")
    // }
    completion(.success(()))
  }
}
