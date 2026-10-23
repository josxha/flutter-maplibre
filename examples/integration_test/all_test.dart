import 'package:integration_test/integration_test.dart';

import 'camera_test.dart' as camera;
import 'features_test.dart' as features;
import 'gestures_test.dart' as gestures;
import 'layers_test.dart' as layers;
import 'map_test.dart' as map;
import 'offline_test.dart' as offline;
import 'projection_test.dart' as projection;
import 'style_test.dart' as style;
import 'ui_test.dart' as ui;
import 'unsupported_test.dart' as unsupported;

/// Runs every integration test in one app launch, which is much faster on
/// devices than one launch per file.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  map.runTests();
  camera.runTests();
  projection.runTests();
  style.runTests();
  features.runTests();
  layers.runTests();
  gestures.runTests();
  ui.runTests();
  offline.runTests();
  unsupported.runTests();
}
