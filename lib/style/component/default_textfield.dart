import 'dart:ui';

import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final int maxLine ;
  DefaultTextField({this.label = '',this.maxLine = 1});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
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
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              cursorColor: theme.primaryColor,
              maxLines: maxLine,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  labelText: label,
                  labelStyle: theme.textTheme.bodyText1!.copyWith(
                      color: theme.primaryColor, fontSize: 16, height: 0.5)),
              style: theme.textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
