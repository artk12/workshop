
import 'package:flutter/material.dart';
import 'package:workshop/style/theme/textstyle.dart';

class MyIconButton extends StatelessWidget {
  final String icon;
  final Function onPressed;
  MyIconButton({this.onPressed,this.icon});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        icon,
        style: MyTextStyle.iconStyle,
      ),
      onPressed: onPressed
    );
  }
}
