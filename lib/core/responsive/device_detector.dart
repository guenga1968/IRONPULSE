import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class DeviceDetector {
  static bool get isWeb => kIsWeb;

  static bool get isDesktopPlatform {
    if (kIsWeb) return false;
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  static bool get isMobilePlatform {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool get hasMouse => isWeb || isDesktopPlatform;
}
