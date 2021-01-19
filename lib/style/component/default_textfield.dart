import 'dart:ui';

import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final int maxLine;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;
  final double? width;
  DefaultTextField({this.label = '', this.maxLine = 1,this.textInputType = TextInputType.text,this.textEditingController,this.width});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 1,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 35, sigmaX: 35),
          child: Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: textEditingController,
              cursorColor: theme.primaryColor,
              maxLines: maxLine,
              keyboardType: textInputType,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(2),
                  labelText: label,
                  labelStyle: theme.textTheme.bodyText1!
                      .copyWith(color: theme.primaryColor, fontSize: 16)),
              style: theme.textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
