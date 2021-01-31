import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/stock/landing/dialog_fabric.dart';

class FabricCardMobile extends StatelessWidget {
  final Fabric fabric;
  final List<Fabric> fabrics;
  final List<FabricLog> fabricLogs;
  FabricCardMobile({this.fabric, this.fabricLogs,@required this.fabrics});

  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(height: height);
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => FabricLogDialog(
            fabrics: fabrics,
            fabric: fabric,
            fabricLogs: fabricLogs,
          ),
          barrierColor: Colors.transparent,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff9c9972).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              width: double.maxFinite,
              height: 122,
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
                          style: theme.textTheme.bodyText1
                        ),
                        space(5),
                        Text(
                          fabric.pieces + ' تیکه ',
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
                          fabric.metric + 'متر ',
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
      ),
    );
  }
}
