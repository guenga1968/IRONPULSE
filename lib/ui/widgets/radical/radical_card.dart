import 'package:flutter/material.dart';
import '../../../theme.dart';

// ================================================
// 💎 RADICAL CARD - Premium 3D Depth Card
// ================================================
// Multi-layer shadows for dramatic depth
// Sharp 0px borders (luxury brutalism)
// Gold accent on active state
// Spring physics animation
// ================================================

class RadicalCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final int depthLevel; // 1-5, controls shadow intensity
  final bool showGoldAccent;
  final bool enableHoverEffect;

  const RadicalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.depthLevel = 3,
    this.showGoldAccent = false,
    this.enableHoverEffect = true,
  }) : assert(depthLevel >= 1 && depthLevel <= 5, 'Depth level must be 1-5');

  @override
  State<RadicalCard> createState() => _RadicalCardState();
}

class _RadicalCardState extends State<RadicalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Spring physics scale animation
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<BoxShadow> _getShadows() {
    // Get base shadows based on depth level
    List<BoxShadow> shadows;
    switch (widget.depthLevel) {
      case 1:
        shadows = DepthSystem.depth1;
        break;
      case 2:
        shadows = DepthSystem.depth2;
        break;
      case 3:
        shadows = DepthSystem.depth3;
        break;
      case 4:
        shadows = DepthSystem.depth4;
        break;
      case 5:
        shadows = DepthSystem.depth5;
        break;
      default:
        shadows = DepthSystem.depth3;
    }

    // Add gold glow if accent is shown
    if (widget.showGoldAccent) {
      shadows = [...shadows, ...DepthSystem.goldGlow];
    }

    // Enhance shadows on hover
    if (_isHovered && widget.enableHoverEffect) {
      shadows = shadows.map((shadow) {
        return BoxShadow(
          color: shadow.color,
          offset: Offset(shadow.offset.dx, shadow.offset.dy * 1.2),
          blurRadius: shadow.blurRadius * 1.2,
          spreadRadius: shadow.spreadRadius,
        );
      }).toList();
    }

    return shadows;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (widget.enableHoverEffect) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (widget.enableHoverEffect) {
          setState(() => _isHovered = false);
        }
      },
      child: GestureDetector(
        onTapDown: (_) {
          _controller.forward();
        },
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () {
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: widget.margin,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? LuxuryColors.surface,
              borderRadius: BorderRadius.circular(
                AsymmetricConstants.borderRadiusSharp,
              ),
              border: Border.all(
                color: widget.showGoldAccent
                    ? LuxuryColors.gold
                    : (widget.borderColor ?? Colors.transparent),
                width:
                    widget.borderWidth ??
                    (widget.showGoldAccent
                        ? AsymmetricConstants.borderMedium
                        : AsymmetricConstants.borderThin),
              ),
              boxShadow: _getShadows(),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AsymmetricConstants.borderRadiusSharp,
              ),
              child: Padding(
                padding: widget.padding ?? const EdgeInsets.all(16),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================
// 💎 LUXURY CARD VARIANTS
// ================================================

/// Featured card with maximum depth (level 5)
class FeaturedRadicalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const FeaturedRadicalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return RadicalCard(
      depthLevel: 5,
      showGoldAccent: true,
      onTap: onTap,
      padding: padding,
      child: child,
    );
  }
}

/// Standard card with medium depth (level 3)
class StandardRadicalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const StandardRadicalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return RadicalCard(
      depthLevel: 3,
      onTap: onTap,
      padding: padding,
      child: child,
    );
  }
}

/// Subtle card with minimal depth (level 1)
class SubtleRadicalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const SubtleRadicalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return RadicalCard(
      depthLevel: 1,
      onTap: onTap,
      padding: padding,
      child: child,
    );
  }
}
