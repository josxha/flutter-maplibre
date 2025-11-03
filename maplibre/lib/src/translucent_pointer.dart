import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Use the [TranslucentPointer] to allow the [child] widget to receive gestures
/// as well as the widgets behind.
///
/// This widget is inspired by the
/// [transparent_pointer](https://pub.dev/packages/transparent_pointer) package.
class TranslucentPointer extends SingleChildRenderObjectWidget {
  /// Create a new [TranslucentPointer] widget.
  const TranslucentPointer({required super.child, super.key});

  @override
  RenderProxyBox createRenderObject(BuildContext context) =>
      _TranslucentPointerRender();
}

class _TranslucentPointerRender extends RenderProxyBox {
  _TranslucentPointerRender() : super(null);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) => false;
}
