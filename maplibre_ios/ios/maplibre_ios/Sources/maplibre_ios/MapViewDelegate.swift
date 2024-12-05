import MapLibre

class MapViewDelegate: NSObject, MLNMapViewDelegate {
    var mapView: MLNMapView!

    // MLNMapViewDelegate method called when map has finished loading
    func mapView(_: MLNMapView, didFinishLoading _: MLNStyle) {
    }
}
