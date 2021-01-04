
import 'dart:ui';

import 'package:flutter/material.dart';

class IconOutlineButton extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  IconOutlineButton({this.color,this.icon});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 45,
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shadowColor: Colors.black.withOpacity(0.5),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              side: BorderSide(
                width: 1.0,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.85),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
