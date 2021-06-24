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
              height: 160,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.maxFinite,
                height: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    space(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'پارچه',
                          style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    space(6),
                    Text(fabric.barCode,style: theme.textTheme.headline1,),
                    space(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom:3),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border:Border(bottom: BorderSide(color: Colors.white.withOpacity(0.4),width: 1.5))
                          ),
                          child: fabric.calite.isEmpty? Text("فاقد کالیته",):Text(
                            fabric.calite,
                            style: theme.textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                    space(14),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fabric.pieces+' تکه ',
                            style: theme.textTheme.headline1,
                          ),
                          fabric.color.isEmpty? Text("فاقد رنگ",):Text(
                            fabric.color,
                            style: theme.textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
                    space(7),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fabric.manufacture,
                            style: theme.textTheme.headline1,
                          ),
                          Text(
                            fabric.metric+' متر ',
                            style: theme.textTheme.headline1,
                          ),
                        ],
                      ),
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
