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
  controller.test();
  general.test();
  camera.test();
  options.test();
  scalebar.test();
  offline.test();
  permission.test();
}
