import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardCardBackgroundBlur extends StatelessWidget {
  final Widget? child;
  DashboardCardBackgroundBlur({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8.0),
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
        // borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 40, sigmaX: 40),
          child: Container(
              // decoration: BoxDecoration(
              //   boxShadow: [
                  // BoxShadow(color: Colors.black.withOpacity(0.0),blurRadius: 3),
                // ]
                // color: Colors.white.withOpacity(0.1),
                // borderRadius: BorderRadius.circular(15),
              // ),
              child: child),
        ),
      ),
    );
  }
}
