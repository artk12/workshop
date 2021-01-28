import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardBlurBackgroundCard extends StatelessWidget {
  final Widget child;
  final Color color;
  DashboardBlurBackgroundCard({@required this.child,this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
          child: Container(
              decoration: BoxDecoration(
                  color: color == null ? Colors.black.withOpacity(0.25):color,
                  borderRadius: BorderRadius.circular(15)),
              child: child),
        ),
      ),
    );
  }
}
