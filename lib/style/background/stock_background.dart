import 'dart:ui';

import 'package:flutter/material.dart';

class StockBackground extends StatelessWidget {
  final Widget child;
  StockBackground({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // SafeArea(
            //   child: Container(
            //     margin: EdgeInsets.only(top:4),
            //     child: Image.asset(
            //       'asset/images/background_image.jpg',
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
            //   child: Container(
            //     color: Colors.black.withOpacity(0.4),
            //   ),
            // ),
            Container(color:Color(0xff37303d)),
            child,
          ],
        ),
      ),
    );
  }
}
