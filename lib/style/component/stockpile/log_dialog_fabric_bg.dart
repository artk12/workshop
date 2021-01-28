import 'dart:ui';

import 'package:flutter/material.dart';

class FabricDialogBg extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final MainAxisSize mainAxisSize;
  FabricDialogBg({this.child,this.maxWidth = 200,this.mainAxisSize = MainAxisSize.min});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.05),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
