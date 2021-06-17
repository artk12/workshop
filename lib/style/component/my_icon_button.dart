
import 'package:flutter/material.dart';
import 'package:workshop/style/theme/textstyle.dart';

class MyIconButton extends StatelessWidget {
  final String icon;
  final Function onPressed;
  final Color color;
  MyIconButton({this.onPressed,this.icon,this.color});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        child: Text(
        icon,
        style: MyTextStyle.iconStyle,
      ),
      onPressed: onPressed
    );
  }
}
