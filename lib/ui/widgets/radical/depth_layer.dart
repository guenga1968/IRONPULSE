import 'package:flutter/material.dart';
import '../../../theme.dart';

// ================================================
// 🌊 DEPTH LAYER - Visual Depth Hierarchy System
// ================================================
// 5 predefined z-layers (base, low, mid, high, top)
// Automatic shadow calculation
// Parallax offset support
// Stacking context management
// ================================================

enum DepthLevel {
  base, // z=0, no shadow
  low, // z=1, subtle shadow
  mid, // z=2, medium shadow
  high, // z=3, prominent shadow
  top, // z=4-5, maximum shadow
}

class DepthLayer extends StatelessWidget {
  final Widget child;
  final DepthLevel level;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool enableParallax;
  final double parallaxOffset; // Scroll-based offset multiplier

  const DepthLayer({
    super.key,
    required this.child,
    this.level = DepthLevel.mid,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.enableParallax = false,
    this.parallaxOffset = 0.0,
  });

  List<BoxShadow> _getShadows() {
    switch (level) {
      case DepthLevel.base:
        return [];
      case DepthLevel.low:
        return DepthSystem.depth1;
      case DepthLevel.mid:
        return DepthSystem.depth2;
      case DepthLevel.high:
        return DepthSystem.depth3;
      case DepthLevel.top:
        return DepthSystem.depth4;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AsymmetricConstants.borderRadiusSharp,
        ),
        boxShadow: _getShadows(),
      ),
      child: child,
    );

    // Apply parallax if enabled
    if (enableParallax && parallaxOffset != 0) {
      content = Transform.translate(
        offset: Offset(0, parallaxOffset * _getParallaxMultiplier()),
        child: content,
      );
    }

    return content;
  }

  double _getParallaxMultiplier() {
    switch (level) {
      case DepthLevel.base:
        return 0.0;
      case DepthLevel.low:
        return 0.2;
      case DepthLevel.mid:
        return 0.4;
      case DepthLevel.high:
        return 0.6;
      case DepthLevel.top:
        return 0.8;
    }
  }
}

// ================================================
// 🌊 LAYERED STACK - Multi-layer depth composition
// ================================================

class LayeredStack extends StatelessWidget {
  final List<LayeredChild> layers;
  final AlignmentGeometry alignment;

  const LayeredStack({
    super.key,
    required this.layers,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    // Sort layers by depth (back to front)
    final sortedLayers = List<LayeredChild>.from(layers)
      ..sort((a, b) => a.depth.index.compareTo(b.depth.index));

    return Stack(
      alignment: alignment,
      children: sortedLayers.map((layer) {
        return DepthLayer(
          level: layer.depth,
          backgroundColor: layer.backgroundColor,
          padding: layer.padding,
          margin: layer.margin,
          enableParallax: layer.enableParallax,
          parallaxOffset: layer.parallaxOffset,
          child: layer.child,
        );
      }).toList(),
    );
  }
}

class LayeredChild {
  final Widget child;
  final DepthLevel depth;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool enableParallax;
  final double parallaxOffset;

  const LayeredChild({
    required this.child,
    this.depth = DepthLevel.mid,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.enableParallax = false,
    this.parallaxOffset = 0.0,
  });
}

// ================================================
// 🌊 DEPTH AWARE SCROLL - Parallax scroll effect
// ================================================

class DepthAwareScroll extends StatefulWidget {
  final Widget child;
  final DepthLevel depth;
  final ScrollController? scrollController;

  const DepthAwareScroll({
    super.key,
    required this.child,
    this.depth = DepthLevel.mid,
    this.scrollController,
  });

  @override
  State<DepthAwareScroll> createState() => _DepthAwareScrollState();
}

class _DepthAwareScrollState extends State<DepthAwareScroll> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DepthLayer(
      level: widget.depth,
      enableParallax: true,
      parallaxOffset: _scrollOffset,
      child: widget.child,
    );
  }
}

// ================================================
// 🌊 ELEVATION CARD - Depth-aware card wrapper
// ================================================

class ElevationCard extends StatelessWidget {
  final Widget child;
  final DepthLevel elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const ElevationCard({
    super.key,
    required this.child,
    this.elevation = DepthLevel.mid,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DepthLayer(
        level: elevation,
        backgroundColor: backgroundColor ?? LuxuryColors.surface,
        padding: padding ?? const EdgeInsets.all(16),
        margin: margin,
        child: child,
      ),
    );
  }
}
