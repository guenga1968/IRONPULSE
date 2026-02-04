import 'package:flutter/material.dart';
import '../../theme.dart';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool isSecondary;

  final EdgeInsetsGeometry? padding;

  const AdaptiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isSecondary = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double height;
    double horizontalPadding;
    double borderRadius;

    if (width >= 1024) {
      height = 64;
      horizontalPadding = 32;
      borderRadius = 16;
    } else if (width >= 600) {
      height = 56;
      horizontalPadding = 24;
      borderRadius = 14;
    } else {
      height = 48;
      horizontalPadding = 16;
      borderRadius = 12;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? AppColors.surface : AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: Size(0, height),
        padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: isSecondary ? 0 : 4,
      ),
      child: child,
    );
  }
}
