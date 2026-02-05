import 'package:flutter/material.dart';
import '../../../theme.dart';

// ================================================
// 💎 LUXURY BUTTON - Premium Gold Button
// ================================================
// Black background with gold border
// Spring physics scale animation
// Shimmer effect on hover
// Sharp 0px borders
// ================================================

class LuxuryButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool isSecondary; // Inverted colors (gold bg, black text)
  final bool showIcon;
  final IconData? icon;
  final bool iconOnRight;

  const LuxuryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.isSecondary = false,
    this.showIcon = false,
    this.icon,
    this.iconOnRight = true,
  });

  @override
  State<LuxuryButton> createState() => _LuxuryButtonState();
}

class _LuxuryButtonState extends State<LuxuryButton>
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

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSecondary
        ? LuxuryColors.gold
        : LuxuryColors.pureBlack;
    final foregroundColor = widget.isSecondary
        ? LuxuryColors.pureBlack
        : LuxuryColors.gold;
    final borderColor = widget.isSecondary
        ? LuxuryColors.pureBlack
        : LuxuryColors.gold;

    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: (_) {
            _controller.forward();
          },
          onTapUp: (_) {
            _controller.reverse();
            widget.onPressed?.call();
          },
          onTapCancel: () {
            _controller.reverse();
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding:
                  widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(
                  AsymmetricConstants.borderRadiusSharp,
                ),
                border: Border.all(
                  color: borderColor,
                  width: AsymmetricConstants.borderMedium,
                ),
                boxShadow: _isHovered ? DepthSystem.goldGlow : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.showIcon && !widget.iconOnRight) ...[
                    Icon(
                      widget.icon ?? Icons.arrow_forward,
                      color: foregroundColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                      child: widget.child,
                    ),
                  ),
                  if (widget.showIcon && widget.iconOnRight) ...[
                    const SizedBox(width: 8),
                    Icon(
                      widget.icon ?? Icons.arrow_forward,
                      color: foregroundColor,
                      size: 18,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================
// 💎 LUXURY ICON BUTTON - Circular gold button
// ================================================

class LuxuryIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final bool isSecondary;

  const LuxuryIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.isSecondary = false,
  });

  @override
  State<LuxuryIconButton> createState() => _LuxuryIconButtonState();
}

class _LuxuryIconButtonState extends State<LuxuryIconButton>
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

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSecondary
        ? LuxuryColors.gold
        : LuxuryColors.pureBlack;
    final foregroundColor = widget.isSecondary
        ? LuxuryColors.pureBlack
        : LuxuryColors.gold;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: foregroundColor,
                width: AsymmetricConstants.borderMedium,
              ),
              boxShadow: _isHovered ? DepthSystem.goldGlow : DepthSystem.depth2,
            ),
            child: Icon(
              widget.icon,
              color: foregroundColor,
              size: widget.size * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================
// 💎 LUXURY TEXT BUTTON - Minimal gold text
// ================================================

class LuxuryTextButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool showUnderline;
  final IconData? icon;

  const LuxuryTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.showUnderline = false,
    this.icon,
  });

  @override
  State<LuxuryTextButton> createState() => _LuxuryTextButtonState();
}

class _LuxuryTextButtonState extends State<LuxuryTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: LuxuryColors.gold,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  decoration: widget.showUnderline || _isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: LuxuryColors.gold,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 4),
                Icon(widget.icon, color: LuxuryColors.gold, size: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
