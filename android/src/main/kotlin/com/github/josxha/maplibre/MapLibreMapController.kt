class MapLibreMapController implements PlatformView {
    fun init() {
        lifecycleProvider.getLifecycle().addObserver(this)
        mapView.getMapAsync(this)
    }
}