import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/style/component/blur_background.dart';

class FabricCardMobile extends StatelessWidget {

  final Fabric fabric;
  FabricCardMobile({this.fabric});

  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(height: height);
    ThemeData theme = Theme.of(context);

    return BlurBackground(
      radius: 5,
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 122,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/images/img_2.jpg'), fit: BoxFit.cover),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 122,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    spreadRadius: 20,
                    blurRadius: 10),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.maxFinite,
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      space(5),
                      Text(
                        'پارچه',
                        style: theme.textTheme.bodyText1.copyWith(shadows: [
                          Shadow(blurRadius: 7, color: Colors.black)
                        ]),
                      ),
                      space(5),
                      Text(
                        fabric.pieces +' تیکه ',
                        style: theme.textTheme.bodyText1,
                      ),
                      space(5),
                      Text(
                       fabric.manufacture,
                        style: theme.textTheme.bodyText1,
                      ),
                      space(5),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      space(5),
                      Text(
                        fabric.calite,
                        style: theme.textTheme.bodyText1,
                      ),
                      space(5),
                      Text(
                        fabric.color,
                        style: theme.textTheme.bodyText1,
                      ),
                      space(5),
                      Text(
                        fabric.metric+'متر ',
                        style: theme.textTheme.bodyText1,
                      ),
                      space(5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
