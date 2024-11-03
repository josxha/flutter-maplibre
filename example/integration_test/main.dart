import 'package:integration_test/integration_test.dart';

import 'controller_test.dart' as controller;
import 'models_test.dart' as models;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  controller.main();
  models.main();
}
