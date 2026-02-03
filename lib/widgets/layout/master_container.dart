import 'package:flutter/material.dart';
import '../../core/responsive/layout_values.dart';

class MasterContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const MasterContainer({super.key, required this.child, this.maxWidth = 1440});

  @override
  Widget build(BuildContext context) {
    final margin = LayoutValues.getMargin(context);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: child,
      ),
    );
  }
}
