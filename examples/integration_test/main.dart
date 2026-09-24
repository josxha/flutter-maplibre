import 'package:integration_test/integration_test.dart';

import 'controller_test.dart' as controller;
import 'general_test.dart' as general;
import 'map_camera_test.dart' as camera;
import 'map_options_test.dart' as options;
import 'map_scalebar_test.dart' as scalebar;
import 'offline_manager_test.dart' as offline;
import 'permission_manager_test.dart' as permission;
import 'style/layer/background_test.dart' as background_style_layer;
import 'style/layer/circle_test.dart' as circle_style_layer;
// import 'style/layer/color_relief_test.dart' as color_relief_style_layer;
// import 'style/layer/fill_extrusion_test.dart' as fill_extrusion_style_layer;
import 'style/style_test.dart' as style;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  controller.main();
  general.main();
  camera.main();
  options.main();
  scalebar.main();
  offline.main();
  permission.main();
  background_style_layer.main();
  circle_style_layer.main();
  // color_relief_style_layer.main();
  // fill_extrusion_style_layer.main();
  style.main();
}
