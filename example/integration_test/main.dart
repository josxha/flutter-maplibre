import 'package:integration_test/integration_test.dart';

import 'controller_test.dart' as controller;
import 'general_test.dart' as general;
import 'permission_manager_test.dart' as permission;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  controller.main();
  general.main();
  // permission.main();
}
