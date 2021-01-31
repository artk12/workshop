
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final int maxLine;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final double width;
  final double height;
  final String hint;
  final EdgeInsets padding;
  DefaultTextField({this.label, this.maxLine = 1,this.textInputType = TextInputType.text
    ,this.textEditingController,this.width,this.hint,this.height,this.padding = const EdgeInsets.all(8)});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: TextField(
          controller: textEditingController,
          cursorColor: theme.primaryColor,
          maxLines: maxLine,
          // textAlign: TextAlign.start,
          keyboardType: textInputType,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: theme.textTheme.bodyText1.copyWith(color: Colors.white.withOpacity(0.5)),
              border: InputBorder.none,
              // contentPadding: EdgeInsets.all(2),
              labelText: label,
              labelStyle: theme.textTheme.bodyText1
                  .copyWith(color: theme.primaryColor, fontSize: 16)),
          style: theme.textTheme.bodyText1,
        ),
      ),
    );
  }
}
