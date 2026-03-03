import 'dart:ui';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

part 'color.dart';
part 'color_relief.dart';
part 'decision.dart';
part 'feature_data.dart';
part 'heatmap.dart';
part 'lookup.dart';
part 'math.dart';
part 'ramps_scales_curves.dart';
part 'string.dart';
part 'types.dart';
part 'variable_binding.dart';
part 'zoom.dart';

/// Base class for expressions.
extension type const Expression<T extends Object?>.fromJson(List<Object?> json)
    implements List<Object?> {}
