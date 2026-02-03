import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A custom [ScrollBehavior] that enables mouse dragging for all platforms.
/// This provides a consistent experience across touch and pointer devices.
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
