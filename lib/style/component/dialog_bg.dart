import 'dart:ui';

import 'package:flutter/material.dart';

class DialogBg extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final MainAxisSize mainAxisSize;
  DialogBg({this.child,this.maxWidth = 200,this.mainAxisSize = MainAxisSize.min});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xff37303d),
          ),
          child: child
        ),
      ),
    );
  }
}
