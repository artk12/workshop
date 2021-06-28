
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class SaveAndCancelButton extends StatelessWidget{
  final Function saveButton;
  final Function cancelButton;
  final double fontSize;
  SaveAndCancelButton({this.cancelButton,this.saveButton,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.resolveWith(
                      (states) => Colors.green,
                ),
              ),
              child: Text(
                MyIcons.CHECK,
                style: MyTextStyle.iconStyle
                    .copyWith(fontSize: fontSize??30,color: Colors.white),
              ),
              onPressed: saveButton
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.resolveWith(
                      (states) => Color(0xFF7C231B),
                ),
              ),
              child: Text(
                MyIcons.CANCEL,
                style: MyTextStyle.iconStyle
                    .copyWith(fontSize: fontSize??30,color: Colors.white),
              ),
              onPressed: cancelButton
            ),
          ),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
      ],
    );
  }

}