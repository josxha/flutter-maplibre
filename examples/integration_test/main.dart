import 'package:integration_test/integration_test.dart';

import 'controller_test.dart' as controller;
import 'general_test.dart' as general;
import 'map_camera_test.dart' as camera;
import 'map_options_test.dart' as options;
import 'map_scalebar_test.dart' as scalebar;
import 'offline_manager_test.dart' as offline;
import 'permission_manager_test.dart' as permission;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  controller.main();
  general.main();
  camera.main();
  options.main();
  scalebar.main();
  offline.main();
  permission.main();
}
