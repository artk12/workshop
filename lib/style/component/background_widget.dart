import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double width;
  final double height;
  final Widget child;
  BackgroundWidget({this.padding, this.height, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 5,
        //     spreadRadius: 1,
        //   )
        // ],
      ),
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
