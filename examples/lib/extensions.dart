import 'package:material_ui/material_ui.dart';

extension BuildContextExt on BuildContext {
  void showSnackBox(String message) {
    debugPrint(message);
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
