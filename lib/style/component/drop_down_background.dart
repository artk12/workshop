import 'package:flutter/material.dart';

class DropDownBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final double blur;
  DropDownBackground(
      {@required this.child,
      this.padding = const EdgeInsets.all(8.0),
      this.radius = 15,
      this.blur = 35});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 1,
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)),
          child: child,
        ),
      ),
    );
  }
}
