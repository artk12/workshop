import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String title;

  DefaultElevatedButton({this.onPressed, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontFamily: 'regular'),
      ),
    );
  }
}
