import 'package:flutter/material.dart';
import '../responsive/layout_values.dart';

class AdaptiveTypography {
  static double scale(BuildContext context, double baseSize) {
    final factor = LayoutValues.getLayoutFactor(context);
    // Non-linear scaling: smaller devices scale less, larger devices scale up to 2.5x
    return baseSize * (0.8 + (factor * 0.2));
  }

  static TextStyle displayLarge(BuildContext context) => TextStyle(
    fontSize: scale(context, 32),
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
  );

  static TextStyle headlineLarge(BuildContext context) =>
      TextStyle(fontSize: scale(context, 28), fontWeight: FontWeight.bold);

  static TextStyle headlineMedium(BuildContext context) =>
      TextStyle(fontSize: scale(context, 24), fontWeight: FontWeight.bold);

  static TextStyle headlineSmall(BuildContext context) =>
      TextStyle(fontSize: scale(context, 20), fontWeight: FontWeight.bold);

  static TextStyle bodyLarge(BuildContext context) =>
      TextStyle(fontSize: scale(context, 16));

  static TextStyle bodyMedium(BuildContext context) =>
      TextStyle(fontSize: scale(context, 14));

  static TextStyle bodySmall(BuildContext context) =>
      TextStyle(fontSize: scale(context, 12));
}
