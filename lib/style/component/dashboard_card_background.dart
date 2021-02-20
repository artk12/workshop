import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardCardBackground extends StatelessWidget {
  final Widget child;
  DashboardCardBackground({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.3),
          //   blurRadius: 3,
          //   spreadRadius: 0,
          // )
        ],
      ),
      child: Container(
        color: Color(0xff4a4a4a).withOpacity(0.2),
          // decoration: BoxDecoration(
          //   boxShadow: [
              // BoxShadow(color: Colors.black.withOpacity(0.0),blurRadius: 3),
            // ]
            // color: Colors.white.withOpacity(0.1),
            // borderRadius: BorderRadius.circular(15),
          // ),
          child: child),
    );
  }
}
