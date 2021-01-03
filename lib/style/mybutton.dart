import 'dart:ui';

import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  final Function()? onPress;

  MyButton({this.title,this.backgroundColor,this.onPress});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 14,
              offset: Offset(0, 0),
            ),
          ]
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: OutlinedButton(
              onPressed: onPress,
              style: OutlinedButton.styleFrom(
                shadowColor: Colors.black.withOpacity(0.5),
                backgroundColor: backgroundColor??Colors.white.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                side: BorderSide(
                  width: 1.0,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Text(
                'اضافه پارچه جدید',
                style: TextStyle(color: Colors.white, fontFamily: 'light'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
