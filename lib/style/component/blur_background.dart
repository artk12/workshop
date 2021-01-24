import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final double blur;
  BlurBackground(
      {@required this.child,
      this.padding = const EdgeInsets.all(8.0),
      this.radius = 15,
      this.blur = 35});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 1,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: blur, sigmaX: blur),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(radius)),
              child: child),
        ),
      ),
    );
  }
}
