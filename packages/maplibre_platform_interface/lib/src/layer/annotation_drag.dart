part of 'annotation_manager.dart';

/// How far a drag is.
enum _DropState {
  /// The user moves the feature.
  dragging,

  /// The user let go, and the app has not saved the feature at its new
  /// place yet.
  dropped,

  /// The app saved the feature at its new place, which shows in the overlay
  /// until the layer's source has it.
  saved,
}

/// A feature that the user drags, shown in a one-feature overlay right above
/// its layer, whose own feature is hidden meanwhile. Moving it writes only
/// the overlay's source, not the layer's whole source.
class _FeatureDrag {
  _FeatureDrag(this.entry, this.featureIndex, this.feature, this.overlay);

  static const sourceId = 'maplibre-drag-source';
  static const layerId = 'maplibre-drag-layer';

  final AnnotationEntry entry;
  final int featureIndex;
  final Feature feature;

  /// The style layer that shows the feature while it is dragged.
  final StyleLayer overlay;

  _DropState state = _DropState.dragging;

  /// The geometry to show next, while the map still takes the one before.
  Geometry? _next;
  var _sending = false;

  /// Whether the overlay is gone, or its style.
  var _ended = false;

  /// Adds the overlay to [style] with the feature at [geometry], below the
  /// layer [belowLayerId] or on top.
  void show(StyleController style, Geometry geometry, String? belowLayerId) {
    final source = GeoJsonSource.data(id: sourceId, data: _data(geometry));
    unawaited(style.sources.add(source));
    unawaited(style.layers.add(overlay, belowLayerId: belowLayerId));
  }

  /// Shows the feature at [geometry] on [style]. Only the latest geometry is
  /// sent while the map still takes the one before.
  void move(StyleController style, Geometry geometry) {
    _next = geometry;
    if (!_sending) unawaited(_send(style));
  }

  Future<void> _send(StyleController style) async {
    _sending = true;
    try {
      while (!_ended) {
        final geometry = _next;
        if (geometry == null) break;
        _next = null;
        await style.sources.updateGeoJsonData(sourceId, _data(geometry));
      }
    } on Object catch (error, stack) {
      _report(error, stack, 'while moving a dragged feature');
    } finally {
      _sending = false;
    }
  }

  /// Removes the overlay from [style], or only stops the drag if the style
  /// is gone.
  void end(StyleController? style) {
    _ended = true;
    if (style == null) return;
    unawaited(style.layers.remove(layerId));
    unawaited(style.sources.remove(sourceId));
  }

  /// The filter of the feature's layer that hides the feature, on top of
  /// [own], the layer's own filter.
  Expression<bool> hidingFilter(Expression<bool>? own) {
    final hide = Expression.notEqual(
      Expression.get(AnnotationManager.featureIndexProperty),
      Expression.literal(featureIndex),
    );
    return own == null ? hide : Expression.all([own, hide]);
  }

  GeoJsonData _data(Geometry geometry) {
    final shown = Feature(
      id: feature.id,
      geometry: geometry,
      properties: {
        ...feature.properties,
        AnnotationManager.featureIndexProperty: featureIndex,
      },
    );
    return .featureCollection(FeatureCollection([shown]));
  }
}
