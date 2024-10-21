import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Use the [TransparentPointer] to allow the [child] widget to receive gestures
/// as well as the widgets behind.
///
/// This widget is inspired by the
/// [transparent_pointer](https://pub.dev/packages/transparent_pointer) package.
class TransparentPointer extends SingleChildRenderObjectWidget {
  /// Create a new [TransparentPointer] widget.
  const TransparentPointer({
    required super.child,
    super.key,
  });

  @override
  RenderProxyBox createRenderObject(BuildContext context) =>
      _TransparentPointerRender();
}

class _TransparentPointerRender extends RenderProxyBox {
  _TransparentPointerRender() : super(null);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) => false;
}
