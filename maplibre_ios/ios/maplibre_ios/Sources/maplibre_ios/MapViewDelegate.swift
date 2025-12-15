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
    // print("### init new MapViewDelegate ### \(viewId) ###")
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

        // TODO(josxha): match the implementation from `setStyle()`
        var style = mapOptions.style
        if style.hasPrefix("{") {
          self._mapView = MLNMapView(frame: self._view.bounds, styleJSON: style)
        } else if style.hasPrefix("/") {
          var styleUrl = URL(fileURLWithPath: style)
          self._mapView = MLNMapView(frame: self._view.bounds, styleURL: styleUrl)
        } else if !style.hasPrefix("http://"), !style.hasPrefix("https://"),
                  !style.hasPrefix("mapbox://")
        {
          if let assetPath = Bundle.main.path(
            forResource: style.replacingOccurrences(of: ".json", with: ""),
            ofType: "json",
            inDirectory: "Frameworks/App.framework/flutter_assets"
          ) {
            do {
              let content = try String(contentsOfFile: assetPath, encoding: .utf8)
              self._mapView = MLNMapView(frame: self._view.bounds, styleJSON: content)
            } catch {
              print("❌ Failed to read Flutter asset: \(error)")
            }
          } else {
            print("❌ Could not find Flutter asset at path.")
          }
        } else {
          self._mapView = MLNMapView(frame: self._view.bounds, styleURL: URL(string: style))
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
        if let bounds = mapOptions.maxBounds {
          var mlnBounds = MLNCoordinateBounds(
            sw: CLLocationCoordinate2D(
              latitude: bounds.latitudeSouth, longitude: bounds.longitudeWest
            ),
            ne: CLLocationCoordinate2D(
              latitude: bounds.latitudeNorth, longitude: bounds.longitudeEast
            )
          )
          self._mapView.maximumScreenBounds = mlnBounds
        }

        self._flutterApi.onMapReady { _ in }

        let doubleTap = UITapGestureRecognizer(
          target: self, action: #selector(self.onDoubleTap(sender:))
        )
        doubleTap.numberOfTapsRequired = 2
        self._mapView.addGestureRecognizer(doubleTap)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
        singleTap.require(toFail: doubleTap)
        if #available(iOS 13.4, *) {
          singleTap.buttonMaskRequired = .primary
        }
        self._mapView.addGestureRecognizer(singleTap)

        if #available(iOS 13.4, *) {
          let secondaryTap = UITapGestureRecognizer(
            target: self, action: #selector(self.onSecondaryTap(sender:))
          )
          secondaryTap.buttonMaskRequired = .secondary
          self._mapView.addGestureRecognizer(secondaryTap)
        }

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

  @objc func onTap(sender: UITapGestureRecognizer) {
    var screenPosition = sender.location(in: _mapView)
    var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
    _flutterApi.onClick(
      point: LngLat(lng: point.longitude, lat: point.latitude),
      // NB: iOS points should be equivalent to Flutter LP
      screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
    ) { _ in }
  }

  @objc func onSecondaryTap(sender: UITapGestureRecognizer) {
    var screenPosition = sender.location(in: _mapView)
    var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
    _flutterApi.onSecondaryClick(
      point: LngLat(lng: point.longitude, lat: point.latitude),
      screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
    ) { _ in }
  }

  @objc func onDoubleTap(sender: UITapGestureRecognizer) {
    var screenPosition = sender.location(in: _mapView)
    var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
    _flutterApi.onDoubleClick(
      point: LngLat(lng: point.longitude, lat: point.latitude),
      screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
    ) { _ in }
  }

  @objc func onLongPress(sender: UILongPressGestureRecognizer) {
    var screenPosition = sender.location(in: _mapView)
    var point = _mapView.convert(screenPosition, toCoordinateFrom: _mapView)
    _flutterApi.onLongClick(
      point: LngLat(lng: point.longitude, lat: point.latitude),
      screenPoint: Offset(x: screenPosition.x, y: screenPosition.y)
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

  // MLNMapViewDelegate method called when camera is about to start changing
  func mapView(_: MLNMapView, regionWillChangeWith reason: MLNCameraChangeReason, animated _: Bool) {
    let changeReason: CameraChangeReason = switch reason {
    case .gestureOneFingerZoom, .gesturePan, .gesturePinch, .gestureRotate, .gestureTilt,
         .gestureZoomIn, .gestureZoomOut, .transitionCancelled:
      .apiGesture
    case .programmatic:
      .apiAnimation
    default:
      .developerAnimation
    }

    _flutterApi.onStartMoveCamera(reason: changeReason) { _ in }
  }

  /// MLNMapViewDelegate method called when camera has finished changing
  func mapView(_: MLNMapView, regionDidChangeWith _: MLNCameraChangeReason, animated _: Bool) {
    _flutterApi.onCameraIdle { (_: Result<Void, PigeonError>) in }
  }

  // MLNMapViewDelegate method called when map has finished loading
  func mapView(_ mapView: MLNMapView, didFinishLoading _: MLNStyle) {
    // setCamera() can only be used after the map did finish loading
    var camera = _mapView.camera
    camera.pitch = _mapOptions!.pitch
    _mapView.setCamera(camera, animated: false)

    _mapView = mapView
    // print("mapView didFinishLoading, call onStyleLoaded")
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
      center: center, zoom: _mapView.zoomLevel, pitch: mlnCamera.pitch,
      bearing: mlnCamera.heading
    )
    _flutterApi.onMoveCamera(camera: pigeonCamera) { _ in }
  }

  func addImage(
    id: String, bytes: FlutterStandardTypedData,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    var style = _mapView.style!
    var imageData = bytes.data
    var image = UIImage(data: imageData, scale: UIScreen.main.scale)!
    style.setImage(image, forName: id)
    completion(.success(()))
  }
}
