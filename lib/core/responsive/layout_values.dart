import 'dart:math';
import 'package:flutter/material.dart';

class LayoutValues {
  static double getLayoutFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // layoutFactor = min(screenWidth / 360, 2.5) for non-linear scaling
    return min(width / 360, 2.5);
  }

  static double getMargin(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return width * 0.12; // 12% for desktop
    if (width >= 600) return width * 0.07; // 7% for tablet
    return 16.0; // 16px for mobile
  }

  static double getPadding(BuildContext context) {
    final factor = getLayoutFactor(context);
    return 16.0 * factor;
  }

  static double getCardRadius(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return 20.0;
    if (width >= 600) return 16.0;
    return 12.0;
  }

  static double getCardElevation(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return 8.0;
    if (width >= 600) return intensityHighElevation;
    return 2.0;
  }

  static const intensityHighElevation = 6.0;
}
