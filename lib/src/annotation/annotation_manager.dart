import 'package:maplibre/maplibre.dart';

class AnnotationManager {
  final MapController mapController;
  late List<AnnotationLayer> _oldLayers;

  AnnotationManager(this.mapController, List<AnnotationLayer> layers) {
    for (final (index, layer) in layers.indexed) {
      layer.addToMap(mapController, layer.hashCode);
    }
    _oldLayers = layers;
  }

  void updateLayers(List<AnnotationLayer> layers) {
    for (final (index, layer) in layers.indexed) {
      layer.updateOnMap(mapController, layer.hashCode);
    }
  }
}
