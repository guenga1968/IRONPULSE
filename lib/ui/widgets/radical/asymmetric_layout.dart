import 'package:flutter/material.dart';
import '../../../theme.dart';

// ================================================
// 📐 ASYMMETRIC LAYOUT - 90/10 Compression
// ================================================
// Extreme asymmetry with 90% negative space
// Content compressed to 10% of screen
// Configurable anchor position
// Responsive breakpoints
// ================================================

enum AsymmetricAnchor {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  left,
  right,
  top,
  bottom,
}

class AsymmetricLayout extends StatelessWidget {
  final Widget child;
  final Widget? backgroundChild; // Content for the 90% space
  final AsymmetricAnchor anchor;
  final double contentRatio; // Default 0.10 (10%)
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const AsymmetricLayout({
    super.key,
    required this.child,
    this.backgroundChild,
    this.anchor = AsymmetricAnchor.right,
    this.contentRatio = AsymmetricConstants.contentRatio,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Calculate content dimensions based on anchor
    double? width;
    double? height;
    double? left;
    double? right;
    double? top;
    double? bottom;

    switch (anchor) {
      case AsymmetricAnchor.left:
        width = size.width * contentRatio;
        left = 0;
        break;
      case AsymmetricAnchor.right:
        width = size.width * contentRatio;
        right = 0;
        break;
      case AsymmetricAnchor.top:
        height = size.height * contentRatio;
        top = 0;
        break;
      case AsymmetricAnchor.bottom:
        height = size.height * contentRatio;
        bottom = 0;
        break;
      case AsymmetricAnchor.topLeft:
        width = size.width * contentRatio;
        height = size.height * contentRatio;
        left = 0;
        top = 0;
        break;
      case AsymmetricAnchor.topRight:
        width = size.width * contentRatio;
        height = size.height * contentRatio;
        right = 0;
        top = 0;
        break;
      case AsymmetricAnchor.bottomLeft:
        width = size.width * contentRatio;
        height = size.height * contentRatio;
        left = 0;
        bottom = 0;
        break;
      case AsymmetricAnchor.bottomRight:
        width = size.width * contentRatio;
        height = size.height * contentRatio;
        right = 0;
        bottom = 0;
        break;
    }

    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: Stack(
        children: [
          // Background (90% space)
          if (backgroundChild != null) Positioned.fill(child: backgroundChild!),

          // Content (10% space)
          Positioned(
            left: left,
            right: right,
            top: top,
            bottom: bottom,
            width: width,
            height: height,
            child: Container(padding: padding, child: child),
          ),
        ],
      ),
    );
  }
}

// ================================================
// 📐 ASYMMETRIC SPLIT - Side-by-side asymmetry
// ================================================

class AsymmetricSplit extends StatelessWidget {
  final Widget primaryChild; // 10% content
  final Widget secondaryChild; // 90% space
  final bool primaryOnLeft; // If false, primary on right
  final double splitRatio; // Default 0.10
  final Color? dividerColor;
  final double dividerWidth;

  const AsymmetricSplit({
    super.key,
    required this.primaryChild,
    required this.secondaryChild,
    this.primaryOnLeft = false,
    this.splitRatio = AsymmetricConstants.contentRatio,
    this.dividerColor,
    this.dividerWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Expanded(
      flex: (splitRatio * 100).toInt(),
      child: primaryChild,
    );

    final secondary = Expanded(
      flex: ((1 - splitRatio) * 100).toInt(),
      child: secondaryChild,
    );

    final divider = dividerWidth > 0
        ? Container(
            width: dividerWidth,
            color: dividerColor ?? LuxuryColors.gold,
          )
        : const SizedBox.shrink();

    return Row(
      children: primaryOnLeft
          ? [primary, divider, secondary]
          : [secondary, divider, primary],
    );
  }
}

// ================================================
// 📐 COMPRESSED COLUMN - Vertical asymmetry
// ================================================

class CompressedColumn extends StatelessWidget {
  final List<Widget> children;
  final AsymmetricAnchor anchor;
  final double compressionRatio; // How much to compress (0.1 = 10%)
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CompressedColumn({
    super.key,
    required this.children,
    this.anchor = AsymmetricAnchor.top,
    this.compressionRatio = AsymmetricConstants.contentRatio,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxHeight = size.height * compressionRatio;

    return Align(
      alignment: _getAlignment(),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }

  Alignment _getAlignment() {
    switch (anchor) {
      case AsymmetricAnchor.top:
      case AsymmetricAnchor.topLeft:
      case AsymmetricAnchor.topRight:
        return Alignment.topCenter;
      case AsymmetricAnchor.bottom:
      case AsymmetricAnchor.bottomLeft:
      case AsymmetricAnchor.bottomRight:
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }
}

// ================================================
// 📐 COMPRESSED ROW - Horizontal asymmetry
// ================================================

class CompressedRow extends StatelessWidget {
  final List<Widget> children;
  final AsymmetricAnchor anchor;
  final double compressionRatio; // How much to compress (0.1 = 10%)
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CompressedRow({
    super.key,
    required this.children,
    this.anchor = AsymmetricAnchor.left,
    this.compressionRatio = AsymmetricConstants.contentRatio,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width * compressionRatio;

    return Align(
      alignment: _getAlignment(),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }

  Alignment _getAlignment() {
    switch (anchor) {
      case AsymmetricAnchor.left:
      case AsymmetricAnchor.topLeft:
      case AsymmetricAnchor.bottomLeft:
        return Alignment.centerLeft;
      case AsymmetricAnchor.right:
      case AsymmetricAnchor.topRight:
      case AsymmetricAnchor.bottomRight:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }
}
