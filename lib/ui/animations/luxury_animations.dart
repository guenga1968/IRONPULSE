import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// ================================================
// ⚡ LUXURY ANIMATIONS - Premium Animation System
// ================================================
// Staggered reveals with delays
// Spring physics for premium feel
// Depth-aware parallax
// Motion accessibility support
// ================================================

class LuxuryAnimations {
  // ================================================
  // STAGGERED REVEAL - Sequential fade-in
  // ================================================

  static Widget staggeredReveal({
    Duration delay = const Duration(milliseconds: 200),
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOutCubic,
    required List<Widget> children,
  }) {
    return _StaggeredRevealWidget(
      delay: delay,
      duration: duration,
      curve: curve,
      children: children,
    );
  }

  // ================================================
  // SPRING PHYSICS - Premium bounce effect
  // ================================================

  static SpringSimulation springPhysics({
    double mass = 1.0,
    double stiffness = 100.0,
    double damping = 10.0,
    double start = 0.0,
    double end = 1.0,
    double velocity = 0.0,
  }) {
    return SpringSimulation(
      SpringDescription(mass: mass, stiffness: stiffness, damping: damping),
      start,
      end,
      velocity,
    );
  }

  // ================================================
  // LUXURY SCALE - Premium press animation
  // ================================================

  static Widget luxuryScale({
    required Widget child,
    required VoidCallback onTap,
    double scaleDown = 0.95,
    Duration duration = const Duration(milliseconds: 150),
  }) {
    return _LuxuryScaleWidget(
      scaleDown: scaleDown,
      duration: duration,
      onTap: onTap,
      child: child,
    );
  }

  // ================================================
  // FADE SLIDE - Fade + slide animation
  // ================================================

  static Widget fadeSlide({
    required Widget child,
    required Animation<double> animation,
    Offset beginOffset = const Offset(0, 0.2),
    Offset endOffset = Offset.zero,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: endOffset,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

// ================================================
// STAGGERED REVEAL WIDGET
// ================================================

class _StaggeredRevealWidget extends StatefulWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;
  final Curve curve;

  const _StaggeredRevealWidget({
    required this.delay,
    required this.duration,
    required this.curve,
    required this.children,
  });

  @override
  State<_StaggeredRevealWidget> createState() => _StaggeredRevealWidgetState();
}

class _StaggeredRevealWidgetState extends State<_StaggeredRevealWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(duration: widget.duration, vsync: this),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(parent: controller, curve: widget.curve);
    }).toList();

    // Start animations with staggered delays
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.delay * i, () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.children.length, (index) {
        return FadeTransition(
          opacity: _animations[index],
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(_animations[index]),
            child: widget.children[index],
          ),
        );
      }),
    );
  }
}

// ================================================
// LUXURY SCALE WIDGET
// ================================================

class _LuxuryScaleWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleDown;
  final Duration duration;

  const _LuxuryScaleWidget({
    required this.child,
    required this.onTap,
    required this.scaleDown,
    required this.duration,
  });

  @override
  State<_LuxuryScaleWidget> createState() => _LuxuryScaleWidgetState();
}

class _LuxuryScaleWidgetState extends State<_LuxuryScaleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleDown,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}

// ================================================
// MOTION AWARE - Accessibility support
// ================================================

class MotionAware extends StatelessWidget {
  final Widget animated;
  final Widget? staticChild;

  const MotionAware({super.key, required this.animated, this.staticChild});

  @override
  Widget build(BuildContext context) {
    // Check for reduced motion preference
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    if (disableAnimations && staticChild != null) {
      return staticChild!;
    }

    return animated;
  }
}

// ================================================
// SHIMMER EFFECT - Gold shimmer for luxury
// ================================================

class GoldShimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool enabled;

  const GoldShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
    this.enabled = true,
  });

  @override
  State<GoldShimmer> createState() => _GoldShimmerState();
}

class _GoldShimmerState extends State<GoldShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFFD4AF37), // Gold
                Color(0xFFFFD700), // Bright gold
                Color(0xFFD4AF37), // Gold
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ================================================
// PULSE ANIMATION - Subtle breathing effect
// ================================================

class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
    this.minScale = 0.98,
    this.maxScale = 1.02,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}
