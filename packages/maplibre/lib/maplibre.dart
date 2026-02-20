// We export the geobase package here so that users don't have to add
// the dependency themselves.
// TODO only export the parts of geobase that we use, to avoid polluting the namespace.
export 'package:geobase/geobase.dart';
export 'package:maplibre_platform_interface/maplibre_platform_interface.dart'
    show
        AndroidPlatformViewMode,
        BackgroundStyleLayer,
        BearingRenderMode,
        BearingTrackMode,
        CameraChangeReason,
        CircleStyleLayer,
        ColorExtension,
        FillExtrusionStyleLayer,
        FillStyleLayer,
        GeoJsonSource,
        HeatmapStyleLayer,
        HillshadeStyleLayer,
        ImageSource,
        Layer,
        LineStyleLayer,
        LngLatBounds,
        LngLatQuad,
        MapCamera,
        MapController,
        MapCreatedCallback,
        MapEvent,
        MapEventCallback,
        MapEventCameraIdle,
        MapEventClick,
        MapEventDoubleClick,
        MapEventIdle,
        MapEventLongClick,
        MapEventMapCreated,
        MapEventMoveCamera,
        MapEventSecondaryClick,
        MapEventStartMoveCamera,
        MapEventStyleLoaded,
        MapEventUserInput,
        MapGestures,
        MapLibreMap,
        MapLibreMapState,
        MapOptions,
        MapProjection,
        OfflineManager,
        OfflineRegion,
        PermissionManager,
        QueriedLayer,
        RasterDemCustomEncoding,
        RasterDemEncoding,
        RasterDemMapboxEncoding,
        RasterDemSource,
        RasterDemTerrariumEncoding,
        RasterSource,
        RasterStyleLayer,
        RenderedFeature,
        Source,
        StyleController,
        StyleLayer,
        StyleLayerWithSource,
        StyleLoadedCallback,
        SymbolStyleLayer,
        TileScheme,
        VectorSource,
        VideoSource,
        // Export deprecated constant for backwards compatibility
        // ignore: deprecated_member_use
        circumferenceOfEarth,
        degree2Radian,
        earthCircumferenceWgs84,
        htmlColorNames;

export 'src/layer/circle_layer.dart' show CircleLayer;
export 'src/layer/marker_layer.dart' show IconAnchor, MarkerLayer;
export 'src/layer/polygon_layer.dart' show PolygonLayer;
export 'src/layer/polyline_layer.dart' show PolylineLayer;
export 'src/ui/map_compass.dart' show MapCompass;
export 'src/ui/map_control_buttons.dart' show MapControlButtons;
export 'src/ui/map_scalebar.dart' show MapScalebar, ScaleBarUnit;
export 'src/ui/source_attribution.dart' show SourceAttribution;
export 'src/widget_layer.dart' show Marker, WidgetLayer;
