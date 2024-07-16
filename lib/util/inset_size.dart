import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

typedef SizeToDoubleCallback = double Function(Size size);

double _widthFromSize(Size size) {
  return size.width;
}

class InsetSize {
  final Size _contextSize;

  InsetSize(this._contextSize);

  factory InsetSize.of(BuildContext context) {
    final mediaQuerySize = MediaQuery.sizeOf(context);

    return InsetSize(mediaQuerySize);
  }

  double get responsive => dimension();

  double dimension({
    double breakpoint = 600,
    double breakpointInset = 12.0,
    double fraction = 0.2,
    SizeToDoubleCallback sizeFrom = _widthFromSize,
  }) {
    final size = sizeFrom(_contextSize);

    final isBreakpoint = size < breakpoint;

    final inset = isBreakpoint ? breakpointInset : size * fraction;

    return inset;
  }

  double lerp(
    Map<double, double Function(double value)> breakpoints, {
    SizeToDoubleCallback sizeFrom = _widthFromSize,
  }) {
    if (breakpoints.isEmpty || breakpoints.length == 1) throw ArgumentError();
    final size = sizeFrom(_contextSize);

    final breakpointSizes = breakpoints.keys.sorted((a, b) => a.compareTo(b));
    double startKey = breakpointSizes.last;
    double endKey = breakpointSizes.first;

    for (final it in breakpointSizes) {
      if (it >= size) {
        endKey = it;
      } else {
        startKey = it;
      }
    }

    // t = (x - a) / (b - a)
    final double t = ((size - startKey) / (endKey - startKey)).clamp(0, 1);

    final start = breakpoints[startKey]!(size);
    final end = breakpoints[endKey]!(size);

    return lerpDouble(start, end, t)!;
  }
}
