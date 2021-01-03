import 'package:flutter/material.dart';

class StockBackground extends StatelessWidget {

  final Widget? child;
  StockBackground({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('asset/images/background_image.jpeg')),
              ),
            ),
            Container(
              color: Colors.black26,
            ),
            child!,
          ],
        ),
      ),
    );
  }
}
