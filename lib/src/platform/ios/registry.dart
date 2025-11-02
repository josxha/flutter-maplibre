import 'package:objective_c/objective_c.dart';

/// Registry for platform views.
abstract class Registry {
  /// The platform views mapped by their view IDs.
  static final platformViews = <int, ObjCObjectBase>{};
}
