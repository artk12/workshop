
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshop/style/component/background_widget.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final int maxLine;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final double width;
  final double height;
  final String hint;
  final EdgeInsets padding;
  final int maxLength;
  final TextAlign textAlign;
  DefaultTextField({this.textAlign = TextAlign.start,this.maxLength,this.label, this.maxLine = 1,this.textInputType = TextInputType.text
    ,this.textEditingController,this.width,this.hint,this.height,this.padding = const EdgeInsets.all(8)});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BackgroundWidget(
      width: width,
      height: height,
      padding: padding,
      child: TextField(
        maxLength: maxLength,
        controller: textEditingController,
        cursorColor: theme.primaryColor,
        maxLines: maxLine,
        textAlign: textAlign,
        // textAlign: TextAlign.start,
        keyboardType: textInputType,
        decoration: InputDecoration(
            counter: new SizedBox(
              height: 0.0,
              width: 0,
            ),
            hintText: hint,
            hintStyle: theme.textTheme.bodyText1.copyWith(color: Colors.white.withOpacity(0.5),fontSize: 14),
            border: InputBorder.none,
            // contentPadding: EdgeInsets.all(2),
            labelText: label,
            labelStyle: theme.textTheme.bodyText1
                .copyWith(color: theme.primaryColor, fontSize: 14)),
        style: theme.textTheme.bodyText1,
      ),
    );
  }
}
