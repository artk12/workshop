
import 'dart:ui';
import 'package:flutter/material.dart';

class StockAppbar extends StatelessWidget {
  final List<Widget>? rightWidget;
  final List<Widget>? leftWidget;
  final String? title;
  StockAppbar({this.rightWidget,this.leftWidget,this.title});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 50.0,
            sigmaY: 50.0,
          ),
          child: Container(
            height: kToolbarHeight,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black38,
              // borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: rightWidget??[],
                  ),
                ),
                SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(title!,
                          style: theme.textTheme.headline1),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: leftWidget??[]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
